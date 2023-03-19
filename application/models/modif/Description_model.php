<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Description_model extends CI_Model {

    public function getWithoutImage(){
        $query = $this->db->query( "select  * from description not like '%image%' " );
        return $query;
    }

    public function get_all_descriptions() {
        $query = $this->db->get('description');
        return $query->result();
    }
    public function getDescriptionById($id) {
        $this->db->select('*');
        $this->db->from('description');
        $this->db->where('iddescription', $id);
        $query = $this->db->get();
        return get_object_vars($query->row());  
    }
}
?>
