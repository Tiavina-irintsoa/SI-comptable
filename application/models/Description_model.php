<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Description_model extends CI_Model {
    
    public function getIdByDescription($description) {
        echo ' nom : '. $description ;
        $this->db->select('iddescription');
        $this->db->from('description');
        $this->db->where('description', $description);
        $query = $this->db->get();
        
        if ($query->num_rows() == 1) {;
            $nb = $query->row()->iddescription;
            echo 'niditra '.$nb;
            return $nb;
        } else {
            return null;
        }
    }
    public function getDescriptionById($id) {
        $this->db->select('iddescription');
        $this->db->from('description');
        $this->db->where('iddescription', $id);
        $query = $this->db->get();
        return get_object_vars($query->row());  
    }
}
