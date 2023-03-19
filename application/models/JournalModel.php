<?php
defined('BASEPATH') OR exit('No direct access allowed');
class JournalModel extends CI_Model{

    public function all(){
        $this->db->select('*');
        $this->db->from('journal');
        $this->db->order_by('code', 'asc');
        $query = $this->db->get();
        
       return to_array($query->result());
    }
    public function delete($id){
        $query = $this->db->get_where('ecriture' , array('iddevise' => $id));
        if($query->num_rows()>0){
            throw new Exception('Le journal ne peut etre efface car une ecriture l\'utilise deja');
        }
        else{
            $this->db->delete('journal' , array('idjournal' => $id));
        }
    }
    public function save($data){
        $this->db->select('*');
        $this->db->from('journal');
        $this->db->where('code',$data['code']);
        $this->db->or_where('nom',$data['nom']);
        $query = $this->db->get();
        if($query->num_rows()>0){
            throw new Exception("Un journal du meme nom ou du meme code existe deja");
        }
        else{
             $this->db->insert('journal' , $data);
        }
    }
    public function edit($id,$data){
        $this->db->select('*');
        $this->db->from('journal');
        $this->db->where('idjournal !=', $id);
        $this->db->group_start();
        $this->db->where('code', $data['code']);
        $this->db->or_where('nom', $data['devise']);
        $this->db->group_end();
        $query = $this->db->get();
        if($query->num_rows()>0){
            throw new Exception("Un journal du meme nom ou du meme code existe deja");
        }
        $this->db->where('idjournal', $id);
        $this->db->update('journal', $data);
    }
    public function search($search_term){
        
        $query = $this->db->select('*')
                  ->from('journal')
                  ->group_start()
                  ->like('code', $search_term)
                  ->or_like('nom', $search_term)
                  ->group_end()
                  ->get();
        return to_array($query->result());
    }
    public function getJournal($id){
        $query = $this->db->get_where('journal' , array('idjournal' => $id));
        return get_object_vars($query -> row());
    }
}
?>