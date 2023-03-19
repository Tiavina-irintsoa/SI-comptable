<?php
include('UserSession.php');
defined('BASEPATH') OR exit('No direct access allowed');

class Devise extends UserSession{
    public function __construct(){
        parent::__construct();
        $this->load->model('DeviseModel');
    }
    public function add(){
        $this->form_validation->set_rules('nom', 'Nom de devise', 'trim|required');
        $this->form_validation->set_rules('taux', 'Taux de change', 'trim|required');
        $data=array();
        $data['page']='ajoutdevise';
        $data['societe']=$this->data;
        $data['retour']='devise/liste';
        $data['title']="Ajouter une devise";
        if ($this->form_validation->run() == FALSE) {
            $this->load->view('templateform',$data);
        }
        else{
            try {
                $equivalence=array('taux'=>$this->input->post('taux'),'date'=>$this->input->post('date'));
                $devise=array();
                $devise['nom']=$this->input->post('nom');
                $this->DeviseModel->save($devise,$equivalence);
                redirect('devise/addform?message=Devise ajoutee avec succes');

            } catch (\Throwable $th) {
                redirect('devise/addform?erreur='.$th->getMessage());
            }
        }
    }
    public function equivalence(){
        $id=$this->input->get('id');
        $data=array();
        $data['devise']=$this->DeviseModel->getDevise($id);
        $data['page']='editequivalence';
        $data['retour']='devise/liste';
        $data['societe']=$this->data;
        $data['title']='Modifier un taux de change';
        $this->load->view('templateform',$data);
    }
    public function delete(){
     try {
        $id=$this->input->get('id');
        $this->DeviseModel->delete($id);
        redirect('devise/liste?message=Devise supprimee avec succes');
     } catch (\Throwable $th) {
        redirect('devise/liste?erreur='.$th->getMessage());
     }
    }
    public function addequivalence(){
        $this->form_validation->set_rules('taux', 'Taux de change', 'trim|required');
        $id=$this->input->post('id');
        $data=array();
        $devise=$this->DeviseModel->getDevise($id);
        $data['devise']=array('iddevise'=>$id,'taux'=>$this->input->post('taux'),'nom'=>$devise['nom']);
        $data['page']='editequivalence';
        $data['retour']='devise/liste';
        $data['societe']=$this->data;
        $data['title']='Modifier un taux de change';
        if ($this->form_validation->run() == FALSE) {
            $this->load->view('templateform',$data);
        }
        else{
            try {
                $equivalence=array(
                    'taux'=>$this->input->post("taux"),'iddevise'=>$id,'date'=>$this->input->post("date")
                );
                $this->DeviseModel->saveEquivalence($equivalence);
                redirect("devise/liste?message=Taux ajoute avec succes");
            } catch (\Throwable $th) {
                redirect('devise/liste?erreur='.$th->getMessage());
            }
        }
    }
    public function addform(){
        $data=array();
        $data['societe']=$this->data;
        $data['retour']='devise/liste';
        $data['title']="Ajouter une nouvelle devise";
        $data['page']='ajoutdevise';
        if($this->input->get('erreur')!=null){
            $data['erreur']=$this->input->get('erreur');
        }
        if($this->input->get('message')!=null){
            $data['message']=$this->input->get('message');
        }
        $this->load->view('templateform',$data);
    }
    public function liste(){
        $data=array();
        $data['societe']=$this->data;
        $data['page']='devise';
        if($this->input->get('message')!=null){
            $data['message']=$this->input->get('message');
        }
        if($this->input->get('erreur')!=null){
            $data['erreur']=$this->input->get('erreur');
        }
        $data['title']='Les devises';
        $data['list']=$this->DeviseModel->all();
        $this->load->view('template',$data);
    }
    public function search(){
        $search_item=$this->input->get('recherche');
        $data['list']=$this->DeviseModel->search($search_item);
        $data['societe']=$this->data;
        $data['page']='devise';
        $data['title']='Resultats de la recherche pour '.$search_item;
        $this->load->view('template',$data);
    }
    public function index(){
        redirect('devise/liste');
    }

}