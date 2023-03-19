<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Compte_model extends CI_Model {

    
    public function get_all()
    {
        // Récupération de toutes les valeurs de la table "compte"
        $query = $this->db->get('compte');
        $query =  $query->result();
        var_dump($query);
        return $query;

        $query = " select * from compte  ";
        $query = sprintf( $query , '%' , $nom  , '%' ,  '%' , $nom  , '%' );

        $query = $this->db->query($query);
        $array = $query->row_array();
        return $array;
    }

    public function ajouter_compte($numero) {
        $data = array(
            'numero' => $numero,
            'libelle' => $this->input->post('description')
        );
        return $this->db->insert('compte', $data);
    }

    public function verifier_numero_compte($numero)
    {
        $sql ='select * from compte where numero = %s';
        $sql = sprintf($sql, $this->db->escape($numero));
        $query = $this->db->query($sql);
        $i = 0;
        foreach($query->result_array() as $row){
            $i += 1;
        }
        echo $sql;
        return $i ;
    }

    public function verifier_description_compte($description)
    {
        $sql ='select * from compte where libelle = %s';
        $sql = sprintf($sql, $this->db->escape($description));
        $query = $this->db->query($sql);
        $i = 0;
        foreach($query->result_array() as $row){
            $i += 1;
        }
        echo $sql;
        return $i;
    }

}
