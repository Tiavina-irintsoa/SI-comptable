<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
    class Login extends CI_Controller {
        
        public function register(){
            $this->load->model('Admin_model');
            $this->load->library('form_validation');

            $this->form_validation->set_rules('username', 'Nom', 'required');
            $this->form_validation->set_rules('password', 'Mot de passe', 'required');

            $data = array();

            if ($this->form_validation->run() === false) {
                $data['errors'] = $this->form_validation->error_array();
            } else {
                $nom = $this->input->post('username');
                $mdp = $this->input->post('password');
                
                // Vérifier si le compte n'existe pas déjà
                $existing_admin = $this->Admin_model->get_admin_by_nom($nom);
                if (!empty($existing_admin)) {
                    $data['error'] = 'Ce nom d\'utilisateur est déjà pris.';
                } else {
                    // Insérer le nouveau compte dans la table admin
                    echo 'niditra tato';
                    $admin_data = array(
                        'nom' => $nom,
                        'mdp' => $mdp
                    );
                    $this->Admin_model->insert_admin($admin_data);
                    $data['success'] = 'Le compte a été créé avec succès.';
                    }
                }

                $data['description'] = "Formulaire d' inscription";
                $data['title'] = 'register';
                $data['section1'] = 'Inscrivez vous';
                $data['lien'] = '/login/register';
                $data['button'] = 'Commencez';
                $this->load->view('template2', $data);
        }

        public function index() {
            $this->load->model('Admin_model');
            $data = array();
            if ($this->input->post()) {

                $this->form_validation->set_rules('username', 'Nom d\'utilisateur', 'required');
                $this->form_validation->set_rules('password', 'Mot de passe', 'required');

                if ($this->form_validation->run() === false) {
                    $data['error'] = $this->form_validation->error_array();
                }else{
                    $username = $this->input->post('username');
                    $password = $this->input->post('password');
                    
                    if (!empty($username) && !empty($password)) {
                        $admin = $this->Admin_model->check_credentials($username, $password);
                        if (!empty($admin)) {
                            $this->session->set_userdata('admin_id', $admin['idadmin']);
                            redirect('informations');
                        } else {
                            $data['error'] = 'Nom d\'utilisateur ou mot de passe invalide.';
                        }
                    } else {
                        $data['error'] = 'Veuillez remplir tous les champs.';
                    }
                }
            }
            $data['title'] = 'login';
            $data['lien'] = 'login';
            $data['content'] = 'Bienvenue';
            $data['section1'] = 'Bienvenue à vous';
            $data['description'] = 'Formulaire de connexion';
            $data['button'] =  'Inscription';
            if( isset($data['error']) )
                $this->load->view('template2.php', $data);
            else{
                redirect('accueil');
            }
        }
    }
    

?>