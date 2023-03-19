<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Formulairesociete_model extends CI_Model {

    public function insert($id, $valeur) {
        $this->db->insert('informations', array(
            'iddescription' => $id,
            'valeur' => $valeur
        ));
    }
    
    
}
