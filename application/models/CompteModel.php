<?php
defined('BASEPATH') OR exit('No direct access allowed');
class CompteModel extends CI_Model{
    public function all(){
        $query = $this->db->get('compte_trie');
        return to_array($query->result());
    }
    public function delete($id){
        $query = $this->db->get_where('ligne' , array('idcompte' => $id));
        if(count($query->row())>0){
            throw new Exception("Le compte n'a pas pu etre supprime car une ecriture l'utilise deja", 1);               
        }
        else{
            $this->db->delete('compte' , array('idcompte' => $id));
        }   
    }

    public function search($search_term){
        $query = $this->db->select('*')
                  ->from('compte')
                  ->group_start()
                  ->like('numero', $search_term)
                  ->or_like('libelle', $search_term)
                  ->group_end()
                  ->get();
        return to_array($query->result());
    }

    public function save($data){
        $data ['numero'] = str_pad($data['numero'], 5, '0', STR_PAD_RIGHT);
        $query = $this->db->get_where('compte' , array('numero' => $data['numero']));
        if($query->num_rows()>0){
            throw new Exception("Le numero de compte ".$data['numero']." existe deja");
        }
        else{
            $this->db->insert('compte' , $data);
        }   
    }

    public function getContent($file){
        $fichier = fopen($file, 'r');
        if (!$fichier) {
            throw new Exception('Impossible d\'ouvrir le fichier.');
        }
        $tableau = array();
        $delimiteurs = array(',', ';');
        $longueur_max=10000;
    while (($ligne = fgets($fichier, $longueur_max)) !== FALSE){
        foreach ($delimiteurs as $delimiteur) {
            $colonnes = str_getcsv($ligne, $delimiteur);
            if (count($colonnes) > 1) {
                // le délimiteur est trouvé
                $delimiteur_trouve = $delimiteur;
                break 2; // sortir de la boucle while et de la boucle foreach
            }
        }
    }
    fclose($fichier);
        if(!isset($delimiteur_trouve)){
            throw new Exception("Erreur lors de la lecture du fichier: Delimiteur nom trouve");
        }
        else if (isset($delimiteur_trouve)) {
            $fichier = fopen($file, 'r');
            while (($ligne = fgetcsv($fichier,$longueur_max,$delimiteur_trouve)) !== false) {
                $tableau[] = array('numero'=>$ligne[0],'libelle'=>$ligne[1]);
            }
        }

    fclose($fichier);
        return $tableau;
    }
    public function saveCSV($file){
        $this->db->trans_start();
        $tableau=$this->getContent($file);
        for ($i=0; $i < count($tableau); $i++) { 
            try{
                $this->save($tableau[$i]);
            }
            catch(Exception $e){
                $this->db->trans_rollback();
                throw $e;
            }
        }
        $this->db->trans_commit();
    }

    public function edit($id,$data){
        $this->db->select('*');
        $this->db->from('compte');
        $this->db->where('libelle',$data['libelle']);
        $this->db->or_where('compte',$data['numero']);
        $query = $this->db->get();
        if($query->num_rows()>0){
            throw new Exception("Ce compte existe deja");
        }
        else{
            $this->db->where('idcompte', $id);
            $this->db->update('compte', $data);
        } 
    }
    public function exists($num){
        $query = $this->db->get_where('compte' , array('numero' => $num));
        if($query->num_rows()>0){
            return get_object_vars($query -> row());
        }
        return false;
    }
    public function isTiers($num){
        foreach ($this->getCompte_tiers() as $tiers) {
            if($num==$tiers['numero']){
                return true;
            }
        }
        return false;
    }
    public function getCompte_tiers(){
        $query = $this->db->get('compte_tiers');
        return to_array($query->result());
    }
    public function getCompte($id){
        $query = $this->db->get_where('compte' , array('idcompte' => $id));
        return get_object_vars($query -> row());
    }
    public function get_compte_by_num($num){
        $query = $this->db->get_where('compte' , array('numero' => $num));
        return $query -> row();
    }
    public function getLast(){
        $query = $this->db->get('compte');
        return $query->last_row();
    }
}
?>