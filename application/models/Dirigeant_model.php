<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Dirigeant_model extends CI_Model {
    public function __construct() {
        parent::__construct();
    }

    public function insert($nom, $courriel, $datedebut) {
        $data = array(
            'nom' => $nom,
            'email' => $courriel,
            'date' => $datedebut
        );

        $this->db->insert('dirigeant', $data);
        return $this->db->insert_id();
    }
}
?>
