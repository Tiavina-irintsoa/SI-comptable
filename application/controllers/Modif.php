<?php
defined('BASEPATH') OR exit('No direct script access allowed');
include('UserSession.php');
class Modif extends UserSession {

    public function __construct(){
        parent::__construct();
        $this->load->model('modif/description_model');
    }
    public function newdirigeant(){
        $this->form_validation->set_rules('email', 'Email', 'required|valid_email');
        $this->form_validation->set_rules('date', 'Date', 'required');
        $this->form_validation->set_rules('nom', 'Nom', 'required');
        if ($this->form_validation->run() == FALSE) {
            $data = array();
            $data['retour']='informations';
            $data['title']="Modifier le dirigeant";
            $data['societe']=$this->data;
            $data['page']='dirigeant';
            if($this->input->get('erreur')!=null){
                $data['erreur']=$this->input->get('erreur');
            }
            if($this->input->get('message')!=null){
                $data['message']=$this->input->get('message');
            }
            $this->load->view('templateform',$data);
        } else {
            $dirigeant=array('nom'=>$this->input->post('nom'),'email'=>$this->input->post('email'),'date'=>$this->input->post('date'));
            $this->load->Model('DirigeantModel');
            $this->DirigeantModel->save($dirigeant);
            redirect('modif/dirigeantform?message=Dirigeant ajoute avec succes');
        }
        
    }
    public function getinput(){
        $iddescri=$this->input->post('description');
        $desc=$this->description_model->getDescriptionById($iddescri);
        echo $desc['inputtype'];
    }
    public function updateInfo(){
        $this->form_validation->set_rules('description', 'Description', 'required');
        $this->form_validation->set_rules('valeur', 'Valeur', 'required');

    }
    public function index(){
        $data = array();
        $data['descriptions'] = $this->description_model->get_all_descriptions();
        $data['retour']='informations';
        $data['title']="Modifier des informations";
        $data['societe']=$this->data;
        $data['page']='modif/InformationModif.php';
        $data['js']='modif.js';
        if($this->input->get('erreur')!=null){
            $data['erreur']=$this->input->get('erreur');
        }
        if($this->input->get('message')!=null){
            $data['message']=$this->input->get('message');
        }
        $this->load->view('templateform',$data);
    }

    public function dirigeantform(){
        $data = array();
        $data['retour']='informations';
        $data['title']="Modifier le dirigeant";
        $data['societe']=$this->data;
        $data['page']='dirigeant';
        if($this->input->get('erreur')!=null){
            $data['erreur']=$this->input->get('erreur');
        }
        if($this->input->get('message')!=null){
            $data['message']=$this->input->get('message');
        }
        $this->load->view('templateform',$data);
    }

    public function save(){
        $this->form_validation->set_rules('description', 'Description', 'required');
        // if($this->input->post('text')==null){
        //     $this->form_validation->set_rules('file', 'Fichier', 'required');
        // }
        // else{
        //     $this->form_validation->set_rules('text', 'Valeur', 'required');
        // }
        if ($this->form_validation->run() == FALSE) {
            $data = array();
            $data['descriptions'] = $this->description_model->get_all_descriptions();
            $data['retour']='informations';
            $data['title']="Modifier information";
            $data['societe']=$this->data;
            $data['page']='modif/InformationModif.php';
            $data['js']='modif.js';
            $this->load->view('templateform', $data);
        }else{
        $this->load->model('modif/informations_model');
        $data = array(
            'iddescription' => $this->input->post('description')
        );
        var_dump($this->input->post('text'));
        if($this->input->post('text')==null){
            echo 'file';
            $config['upload_path'] = './assets/docs/'; 
            $config['allowed_types'] = 'gif|jpg|png|webp|jpeg|pdf';
            $config['max_size'] = '2048';
            $this->load->library('upload', $config);
            if (!$this->upload->do_upload('file')) {
                $error = array('error' => $this->upload->display_errors());
                redirect('modif?erreur='.$error['error']);
            } 
            else{
                try {
                    $uploaddata=$this->upload->data();
                    $data['valeur']=$uploaddata['file_name'];
                    $this->informations_model->insert_info($data);
                    redirect('modif?message=Information modifiee avec succes');
                } catch (\Throwable $th) {
                    redirect('modif?erreur='.$th->getMessage());
                }
            }
        }
        else{
            echo 'text';
            $data['valeur']=$this->input->post('text');
            try {
                $this->informations_model->insert_info($data);
                redirect('modif?message=Information modifiee avec succes');
            } catch (\Throwable $th) {
                redirect('modif?erreur='.$th->getMessage());
            }
        }
        
    }
    }

}