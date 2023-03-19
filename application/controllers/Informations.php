<?php
include('UserSession.php');
defined('BASEPATH') OR exit('No direct access allowed');
class Informations extends UserSession{
    public function __construct(){
        parent::__construct();
        $this->load->model('AdministrationModel');
        $this->load->model('DirigeantModel');
        $this->load->model('ComptabiliteModel');
    }
    public function index(){
        $data=array();
        $data['title']="Informations sur ".$this->data['nom_societe'];
        $data['societe']=$this->data;
        $data['page']='informations';
        $data['info']=$this->InformationsModel->getInfo();
        $data['dirigeant']=$this->DirigeantModel->getInfo();
        $data['comptabilite']=$this->ComptabiliteModel->getInfo();
        $data['administration']=$this->AdministrationModel->getInfo();
        $this->load->view('template',$data);
    }
}