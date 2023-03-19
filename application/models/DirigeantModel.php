<?php
defined('BASEPATH') OR exit('No direct access allowed');
class DirigeantModel extends CI_Model{
    public function getInfo(){
        $query = $this->db->get('dirigeant_date_extract');
        $dirigeant = $query -> last_row();

        $query = $this->db->get_where('mois' , array('idmois' => $dirigeant->mois));
        $mois = $query -> row();

        return array(
            'nom'=>$dirigeant->nom,
            'email'=>$dirigeant->email,
            'Date'=>$dirigeant->jour . ' ' . $mois->mois . ' ' . $dirigeant->annee
        );
    }

    public function save($dirigeant){
        $this->db->insert('dirigeant',$dirigeant);
    }
}