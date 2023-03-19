<?php
include('UserSession.php');
defined('BASEPATH') OR exit('No direct access allowed');
class Tiers extends UserSession{
    public function __construct(){
        parent::__construct();
        $this->load->model('TiersModel');
    }
    public function liste(){
        $data=array();
        $data['list']=$this->TiersModel->all();
        $data['societe']=$this->data;
        $data['page']='tiers';
        $data['title']='Liste des tiers';
        $this->load->view('template',$data);
    }
    public function search(){
        $search_item=$this->input->get('recherche');
        $data['list']=$this->TiersModel->search($search_item);
        $data['societe']=$this->data;
        $data['page']='tiers';
        $data['title']='Resultats de la recherche pour '.$search_item;
        $this->load->view('template',$data);
    }
    public function index(){
        redirect('tiers/liste');
    }
    public function editform(){
        $id=$this->input->get('id');
        $data=array();
        $data['tiers']=$this->TiersModel->getTiers_by_id($id);
        $data['page']='modiftiers';
        $data['retour']='tiers/liste';
        $data['societe']=$this->data;
        $data['title']="Modifier un compte tiers";
        $this->load->view('templateform',$data);
    }
    public function edit(){
        $this->form_validation->set_rules('numero', 'Numero de compte', 'trim|required');
        $this->form_validation->set_rules('nom', 'Nom', 'trim|required|min_length[1]|max_length[13]');
        $data=array();
        $data['page']='modiftiers';
        $data['societe']=$this->data;
        $data['retour']='tiers/liste';
        $data['title']=
    "Modifier un compte tiers";
        $data['nom']=$this->input->post('nom');
        $data['id']=$this->input->post('id');
        $data['numero']=$this->input->post('numero');
        $data['tiers']=$this->TiersModel->getTiers_by_id($data['id']);
        if ($this->form_validation->run() == FALSE) {
            $this->load->view('templateform',$data);
        }
        else{
            $tiers=array(
                "nom"=>$data['nom'],
                "idtiers"=>$data['id'],
                "numero"=>$data['numero']
            );
            $this->TiersModel->edit($data['id'],$tiers);
            redirect('tiers/liste');
        }
    }
    public function add(){
        $this->form_validation->set_rules('numero', 'Numero de compte', 'trim|required');
        $this->form_validation->set_rules('nom', 'Nom', 'trim|required|min_length[1]|max_length[13]');
        $data=array();
        $data['page']='ajouttiers';
        $data['societe']=$this->data;
        $data['retour']='tiers/liste';
        $data['title']="Ajouter un compte tiers";
        if ($this->form_validation->run() == FALSE) {
            $this->load->view('templateform',$data);
        }
        else{
            $tiers=array();
            $tiers['nom']=$this->input->post('nom');
            $num=$this->input->post('numero');
            $this->load->Model('CompteModel');
            if(!$this->CompteModel->exists($num)){
                echo 'exists not';
            }
            else{
                try {
                    $compte=$this->CompteModel->exists($num);
                    $tiers['idcompte']=$compte['idcompte'];
                    $this->TiersModel->save($tiers,$num);
                    echo 'success';
                } catch (\Throwable $th) {
                    echo $th->getMessage();
                }
            }
        }
    }
    public function addform(){
        $data=array();
        $data['societe']=$this->data;
        $data['retour']='tiers/liste';
        $data['title']="Ajouter un compte tiers";
        $data['js']='ajouttiers.js';
        $data['page']='ajouttiers';
        
        $this->load->view('templateform',$data);
    }
    
    public function delete(){
        $id=$this->input->get('id');
        $this->TiersModel->delete($id);
        redirect('tiers/liste');
    }
}