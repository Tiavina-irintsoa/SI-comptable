<?php
defined('BASEPATH') OR exit('No direct access allowed');
class DeviseModel extends CI_Model{
    public function all(){
        $query = $this->db->query('select * from devise_taux');
        return to_array($query->result());
    }
    public function save($devise,$equivalence){
        $query = $this->db->get_where('devise' , array('nom' => $devise['nom']));
        if($query->num_rows()>0){
            throw new Exception('La devise '.$devise['nom'].' existe deja');
        }
        else{
            $this->db->trans_start();
            try {
                $this->db->insert('devise' , $devise);
                $last=$this->getLast();
                $equivalence['iddevise']=$last->iddevise;
                $this->saveEquivalence($equivalence);
                $this->db->trans_commit();
            } catch (\Throwable $th) {
                $this->db->trans_rollback();
                throw $e;
            }
        }   
    }
    public function getLast(){
        $query= $this->db->get('devise');
        return $query->last_row();
    }
    public function getDevise($id){
        $query = $this->db->get_where('devise_taux' , array('id_devise' => $id));
        return get_object_vars($query -> row());
    }
    public function saveEquivalence($equivalence){
        $query=$this->db->get_where('devisequivalence',array('iddevise'=> $equivalence['iddevise'],'date'=>$equivalence['date']));
        if($query->num_rows()>0){
            throw new Exception('Le taux de cette devise a deja ete mis a jour');
        }
        $this->db->insert('devisequivalence' , $equivalence);
    }
    public function delete($id){
        $query = $this->db->get_where('ecriture' , array('iddevise' => $id));
        if(($query->num_rows())>0){
            throw new Exception("La devise n'a pas pu etre supprime car une ecriture l'utilise deja");               
        }
        else{
            $this->db->delete('devisequivalence' , array('iddevise' => $id));
            $this->db->delete('devise' , array('iddevise' => $id));
        }
    }
    public function search($search_term){
            $query = $this->db->select('*')
                      ->from('devise_taux')
                      ->like('nom', $search_term)
                      ->get();
            return to_array($query->result());
        }
    
}