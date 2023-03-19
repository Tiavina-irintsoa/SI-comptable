<?php
include('UserSession.php');
defined('BASEPATH') OR exit('No direct access allowed');
class Journal extends UserSession{
    public function __construct(){
        parent::__construct();
        $this->load->model('JournalModel');
    }
    public function liste(){
        $data=array();
        $data['list']=$this->JournalModel->all();
        $data['societe']=$this->data;
        $data['page']='journal';
        $data['title']='Liste des journaux';
        if($this->input->get('erreur')!=null){
            $data['erreur']=$this->input->get('erreur');
        }
        if($this->input->get('message')!=null){
            $data['message']=$this->input->get('message');
        }
        $this->load->view('template',$data);
    }
    public function search(){
        $search_item=$this->input->get('recherche');
        $data['list']=$this->JournalModel->search($search_item);
        $data['societe']=$this->data;
        $data['page']='journal';
        $data['title']='Resultats de la recherche pour '.$search_item;
        $this->load->view('template',$data);
    }
    public function editform(){
        $id=$this->input->get('id');
        $data=$this->JournalModel->getJournal($id);
        $data['page']='modifjournal';
        $data['retour']='journal/liste';
        $data['id']=$id;
        $data['societe']=$this->data;
        $data['title']="Modifier un journal";
        $this->load->view('templateform',$data);
    }
    public function edit(){
        $this->form_validation->set_rules('code', 'Code de journal', 'trim|required');
        $this->form_validation->set_rules('nom', 'Nom de journal', 'trim|required');
        $data=array();
        $data['page']='modifjournal';
        $data['societe']=$this->data;
        $data['retour']='journal/liste';
        $data['title']="Modifier un journal";
        $data['nom']=$this->input->post('nom');
        $data['id']=$this->input->post('id');
        $data['code']=$this->input->post('code');
        if ($this->form_validation->run() == FALSE) {
            $this->load->view('templateform',$data);
        }
        else{
            $tiers=array(
                "nom"=>$data['nom'],
                "idjournal"=>$data['id'],
                "code"=>$data['code']
            );
            try {
                $this->JournalModel->edit($data['id'],$tiers);
                redirect('journal/liste?message=Journal modifie avec succes');
            } catch (\Throwable $th) {
                redirect('journal/liste?erreur='.$th->getMessage());
            }
        }
    }
    public function index(){
        redirect('journal/liste');
    }
    public function delete(){
        try {
            $id=$this->input->get('id');
            $this->JournalModel->delete($id);
            redirect('journal/liste?message=Journal efface avec succes');
        } catch (\Throwable $th) {
            redirect('journal/liste?erreur='.$th->getMessage());
        }
    }
    public function add(){
        $this->form_validation->set_rules('code', 'Code de journal', 'trim|required');
        $this->form_validation->set_rules('nom', 'Nom de journal', 'trim|required');
        $data=array();
        $data['page']='ajoutjournal';
        $data['societe']=$this->data;
        $data['retour']='journal/liste';
        $data['title']="Ajouter un journal";
        if ($this->form_validation->run() == FALSE) {
            $this->load->view('templateform',$data);
        }
        else{
            $journal=array();
            $journal['nom']=$this->input->post('nom');
            $journal['code']=$this->input->post('code');
            try {
                $this->JournalModel->save($journal);
                redirect('journal/addform?message=Journal ajoute avec succes');
            } catch (\Throwable $th) {
                redirect('journal/addform?erreur='.$th->getMessage());
            }
        }
    }
    public function addform(){
        $data=array();
        $data['societe']=$this->data;
        $data['retour']='journal/liste';
        $data['title']="Ajouter un journal";
        $data['page']='ajoutjournal';
        if($this->input->get('erreur')!=null){
            $data['erreur']=$this->input->get('erreur');
        }
        if($this->input->get('message')!=null){
            $data['message']=$this->input->get('message');
        }
        $this->load->view('templateform',$data);
        
    }
}