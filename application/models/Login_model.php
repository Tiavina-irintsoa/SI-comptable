<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Login_model extends CI_Model{
    public function getData(){
        $data = array(
            0 => array(
                "nom"=>"admin",
                "mdp"=>"12345"
            )
            );
        return $data;
    }

    public function verifyLogin( $array , $nom , $mdp){
        $array = $this->getData();
        for( $i = 0 ; $i != count($array) ; $i++ ){
            if( $array[$i]["nom"] == $nom && $array[$i]["mdp"] == $mdp  )
                return ;
        }
        throw new Exception("n'est pas un admin ");
    }
}

?>