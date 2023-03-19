<?php
defined('BASEPATH') OR exit('No direct access allowed');
class UserSession extends CI_Controller{
    public $data;
    public function  __construct(){
        parent::__construct();
        // if($this->session.has_userdata('user')==false){
        //     redirect('welcome/index');
        // }
        $this->load->model('InformationsModel');
        $inf=$this->InformationsModel->getInfo();
        $this->data=array('nom_societe'=>$inf['nom'],'logo'=>$inf['logo']);
    }
}
