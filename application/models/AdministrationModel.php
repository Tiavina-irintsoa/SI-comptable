<?php
defined('BASEPATH') OR exit('No direct access allowed');
class AdministrationModel extends CI_Model{
    public function getInfo(){
        $query = $this->db->get_where('info_description' , array('description' => 'nif'));
        $nif = $query -> row();

        $query = $this->db->get_where('info_description' , array('description' => 'imagenif'));
        $imagenif = $query -> row();

        $query = $this->db->get_where('info_description' , array('description' => 'ns'));
        $ns = $query -> row();

        $query = $this->db->get_where('info_description' , array('description' => 'imagens'));
        $imagens = $query -> row();

        $query = $this->db->get_where('info_description' , array('description' => 'rcs'));
        $rcs = $query -> row();
        
        $query = $this->db->get_where('info_description' , array('description' => 'imagercs'));
        $imagercs = $query -> row();
        return array(
            'nif'=> $nif->valeur,
            'imagenif'=>$imagenif->valeur,
            'ns'=>$ns->valeur,
            'imagens'=>$imagens->valeur,
            'rcs'=>$rcs->valeur,
            'imagercs'=>$imagercs->valeur
        );
    }
}