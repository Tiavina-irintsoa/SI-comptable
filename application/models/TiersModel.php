<?php
defined('BASEPATH') OR exit('No direct access allowed');
class TiersModel extends CI_Model{
    public function all(){
        $query = $this->db->get('tiers_compte');
        return to_array($query->result());
    }
    public function delete($id){
        $tiers = $this->getTiers_by_id($id);
        $this->db->delete('tiers' , array('idtiers' => $id));
        $this->load->model('CompteModel');
		$this->CompteModel->delete($tiers->idcompte);
    }

    public function save($data,$num){
       
        $this->load->Model('CompteModel');
        if($this->CompteModel->isTiers($num)==false){
            throw new Exception('Seuls les comptes 40,41,45,46 peuvent avoir un compte tiers');
        }
        $this->db->select('*');
        $this->db->from('tiers');
        $this->db->where('idcompte',$data['idcompte']);
        $query = $this->db->get();
        if($query->num_rows()>0){
            throw new Exception("Un compte tiers utilise deja ce compte");
        }
        $this->db->insert('tiers' , $data);
    }
    public function edit($id,$data){
        $tiers = $this->getTiers_by_id($id);
        $compte['numero'] = $data['compte'];
        $compte['libelle'] = $data['nom'];
        $this->load->model('CompteModel');
        $this->CompteModel->edit($tiers->idcompte , $compte);
        $tiers_edit['nom'] = $data['nom'];
        $this->db->where('idtiers', $id);
        $this->db->update('tiers', $tiers_edit);
    }
    // eto zao
    public function getTiers($num_compte){
        $this->load->model('CompteModel');
		$compte = $this->CompteModel->get_compte_by_num($num_compte);
        $query = $this->db->get_where('tiers' , array('idcompte' => $compte->idcompte));
        return get_object_vars($query -> row());
    }
    public function getTiers_by_id($id){
        $query = $this->db->get_where('tiers_compte' , array('idtiers' => $id));
        return get_object_vars($query -> row());
    }
    // recherche
    public function search($search_term){
        $query = $this->db->select('*')
                  ->from('tiers_compte')
                  ->group_start()
                  ->like('numero', $search_term)
                  ->or_like('nom', $search_term)
                  ->group_end()
                  ->get();
        return to_array($query->result());
    }
}
?>