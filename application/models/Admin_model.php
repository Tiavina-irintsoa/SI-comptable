<?php 
defined('BASEPATH') OR exit('No direct script access allowed');

    class Admin_model extends CI_Model {

        public function check_credentials($username, $password) {
            $query = $this->db->get_where('admin', array('nom' => $username, 'mdp' => $password));
            return $query->row_array();
        }

        public function insert_admin($data) {
            return $this->db->insert('admin', $data);
        }
    
        public function get_admin_by_nom($nom) {
            $query = $this->db->get_where('admin', array('nom' => $nom));
            return $query->row_array();
        }       
    }
    
?>