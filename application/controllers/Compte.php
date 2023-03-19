<?php
include('UserSession.php');
defined('BASEPATH') OR exit('No direct access allowed');
class Compte extends UserSession{
    public function __construct(){
        parent::__construct();
        $this->load->model('CompteModel');
    }
    public function uploadform(){
        $data['page']='uploadcompte';
        $data['retour']='compte/liste';
        $data['societe']=$this->data;
        if($this->input->get('erreur')!=null){
            $data['erreur']=$this->input->get('erreur');
        }
        if($this->input->get('message')!=null){
            $data['message']=$this->input->get('message');
        }
        $data['title']="Importer un fichier";
        $this->load->view('templateform',$data);
    }

    public function upload(){
        $config['upload_path'] = './assets/csv/'; // dossier où le fichier sera téléchargé
        $config['allowed_types'] = 'csv'; // types de fichiers autorisés
        $config['max_size'] = '2048'; // taille maximale autorisée en kilo-octets
    
        $this->load->library('upload', $config);
    
        if (!$this->upload->do_upload('file')) {
            $error = array('error' => $this->upload->display_errors());
            redirect('compte/uploadform?erreur='.$error['error']);
        } else {
            try {
                $data = array('upload_data' => $this->upload->data());
                $name=$data['upload_data']['full_path'];
                $this->CompteModel->saveCSV($name);
                redirect('compte/uploadform?message=Fichier importe avec succes');
            } catch (Throwable $th) {
                redirect('compte/uploadform?erreur='.$th->getMessage());
            }
        }
    }

    public function editform(){
        $id=$this->input->get('id');
        $data=$this->CompteModel->getCompte($id);
        $data['page']='modifcompte';
        $data['retour']='compte/liste';
        $data['id']=$id;
        $data['societe']=$this->data;
        $data['title']="Modifier un compte";
        $this->load->view('templateform',$data);
    }
    
    public function edit(){
        $this->form_validation->set_rules('numero', 'Numero de compte', 'trim|required');
        $this->form_validation->set_rules('libelle', 'Libelle', 'trim|required');
        $data=array();
        $data['page']='modifcompte';
        $data['societe']=$this->data;
        $data['retour']='compte/liste';
        $data['title']="Modifier un compte";
        $data['libelle']=$this->input->post('libelle');
        $data['id']=$this->input->post('id');
        $data['numero']=$this->input->post('numero');
        if ($this->form_validation->run() == FALSE) {
            $this->load->view('templateform',$data);
        }
        else{
            $compte=array(
                "libelle"=>$data['libelle'],
                "idcompte"=>$data['id'],
                "numero"=>$data['numero']
            );
            $this->CompteModel->edit($data['id'],$compte);
            redirect('compte/liste');
        }
    }

    public function liste(){
        $data=array();
        $data['list']=$this->CompteModel->all();
        $data['societe']=$this->data;
        $data['page']='compte';
        if($this->input->get('erreur')!=null){
            $data['erreur']=$this->input->get('erreur');
        }
        if($this->input->get('message')!=null){
            $data['message']=$this->input->get('message');
        }
        $data['title']='Liste des comptes';
        $this->load->view('template',$data);
    }

    public function search(){
        $search_item=$this->input->get('recherche');
        $data['list']=$this->CompteModel->search($search_item);
        $data['societe']=$this->data;
        $data['page']='compte';
        $data['title']='Resultats de la recherche pour '.$search_item;
        $this->load->view('template',$data);
    }

    public function add(){
        $this->form_validation->set_rules('numero', 'Numero de compte', 'trim|required|max_length[5]');
        $this->form_validation->set_rules('libelle', 'Libelle', 'trim|required');
        $data=array();
        $data['page']='ajoutcompte';
        $data['societe']=$this->data;
        $data['retour']='compte/liste';
        $data['title']="Ajouter un compte";
        if ($this->form_validation->run() == FALSE) {
            $this->load->view('templateform',$data);
        }
        else{
            $compte=array();
            $compte['libelle']=$this->input->post('libelle');
            $compte['numero']=$this->input->post('numero');
            try {
                $this->CompteModel->save($compte);
                redirect('compte/addform?message=Compte ajoute avec succes');
            } catch (Throwable $th) {
                redirect('compte/addform?erreur='.$th->getMessage());
            }
        }
    }
    public function addform(){
        $data=array();
        $data['societe']=$this->data;
        $data['retour']='compte/liste';
        $data['title']="Ajouter un compte";
        $data['page']='ajoutcompte';
        $data['js']='ajouttiers.js';
        if($this->input->get('numero')!=null){
            $data['numero']=$this->input->get('numero');
        }
        if($this->input->get('erreur')!=null){
            $data['erreur']=$this->input->get('erreur');
        }
        if($this->input->get('message')!=null){
            $data['message']=$this->input->get('message');
        }
        $this->load->view('templateform',$data);
    }
    public function index(){
        redirect('compte/liste');
    }
    public function delete(){
        try {
            $id=$this->input->get('id');
            $this->CompteModel->delete($id);
            redirect('compte/liste?message=Compte efface avec succes');
        } catch (Throwable $th) {
            redirect('compte/liste?erreur='.$th->getMessage());
        }
    }
}