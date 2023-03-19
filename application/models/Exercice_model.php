<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Exercice_model extends CI_Model {
    public function __construct() {
        parent::__construct();
    }

    public function insert($debut_exercice) {
        $data = array(
            'debut' => $debut_exercice
        );

        $this->db->insert('exercice', $data);
        return $this->db->insert_id();
    }
}
?>
