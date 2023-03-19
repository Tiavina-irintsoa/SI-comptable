<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Accueil extends CI_Controller {
    public function __construct(){
        parent::__construct();
        $this->data['title'] = 'login';
        $this->data['lien'] = 'login';
        $this->data['content'] = 'Bienvenue';
        $this->data['description'] = 'Formulaire de connexion';
        $this->data['section1'] = 'Bienvenue à vous';
        $this->data['button'] = 'Commencez';
        $query = $this->db->query('select * from exercice');

        // Vérification du résultat
        if (count($query->result_array()) == 0) {
            redirect('createProfile');
        }
    }

    public function inscription(){
        $this->data['description'] = "Formulaire d' inscription";
        $this->data['title'] = 'register';
        $this->data['lien'] = '/login/register';
        $this->data['content'] = 'Bienvenue';
        $this->data['section1'] = 'Insrivez vous';

        $this->load->view('template2.php', $this->data);
    }
    

    public function index(){
        $this->load->view('template2.php',$this->data);
    }

}