<?php
defined('BASEPATH') OR exit('No direct access allowed');
class DescriptionModel extends CI_Model{
    public function getDescription($description){
        $query = $this->db->get_where('description' , array('description' => $description));
        return get_object_vars($query -> row());
    }
}