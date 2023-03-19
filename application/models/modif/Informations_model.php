<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Informations_model extends CI_Model {
    public function insert_info($data) {
        $this->db->insert('informations', $data);
    }
}
?>