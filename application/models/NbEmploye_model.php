<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
class NbEmploye_model extends CI_Model {

    public function insert($valeur) {
        $this->db->insert('nbEmploye', array(
            'valeur' => $valeur
        ));
    }

}


?>