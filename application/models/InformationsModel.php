<?php
defined('BASEPATH') OR exit('No direct access allowed');
class InformationsModel extends CI_Model{
    public function getInfo(){
        $query = $this->db->get_where('info_description' , array('description' => 'nom'));
        $nom = $query -> row();

        $query = $this->db->get_where('info_description' , array('description' => 'objet'));
        $objet = $query -> row();

        $query = $this->db->get_where('info_description' , array('description' => 'siege'));
        $siege = $query -> row();

        $query = $this->db->get_where('info_description' , array('description' => 'telephone'));
        $telephone = $query -> row();

        $query = $this->db->get_where('info_description' , array('description' => 'telecopie'));
        $telecopie = $query -> row();

        $query = $this->db->get_where('info_description' , array('description' => 'email'));
        $email = $query -> row();
        $query = $this->db->get_where('info_description' , array('description' => 'logo'));
        $logo = $query -> row();

        return array(
            'nom'=>$nom->valeur,
            'logo'=>$logo->valeur,
            'objet'=>$objet->valeur,
            'creation'=>'31 Decembre 2000',
            'siege'=>$siege->valeur,
            'telephone'=>$telephone->valeur,
            'telecopie'=>$telecopie->valeur,
            'email'=>$email->valeur
        );
    }
}