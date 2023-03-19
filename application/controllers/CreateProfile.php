<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class CreateProfile extends CI_Controller {
    public function __construct(){
        parent::__construct();
        date_default_timezone_set('Indian/Antananarivo');
        $this->load->model('Formulairesociete_model');
        $this->load->model('NbEmploye_model');
        $this->load->model('Exercice_model');
        $this->load->model('Dirigeant_model');
        $this->load->model('Description_model');
        $this->load->library('upload');
        $this->data = array();
        $this->data['title'] = 'création société';
        $this->data['etape'] = 1;
        $this->data['content'] = 'societe.php';
        $this->data['suivant']='CreateProfile/rate';
        $this->data['retour']='#';
        $this->data['titreEtape']='Informations générales:';
        $this->data['description']='Commneçcons par les informations de base , qui etes vous et que faites vous?';
    }

    public function index(){
        $this->load->view('template1.php' , $this->data);
    }


/// insertion
    public function create(){
        if( !isset( $_SESSION['declaration'] ) || !isset($_SESSION['info']) ||!isset($_SESSION['dirigeant'] )|| !isset($_SESSION['exercice']) ){
            redirect( 'CreateProfile' );
        } else{
            $declaration = $this->session->userdata('declaration');
            $info = $this->session->userdata('info');

            // Insérer les données de la déclaration dans formulaireSociete
            foreach ($declaration as $key => $value) {
                $id  = $this->Description_model->getIdByDescription( $key );
                $this->FormulaireSociete_model->insert($id, $value);
            }

            // Insérer les données de info dans formulaireSociete
            foreach ($info as $key => $value) {
                $id  = $this->Description_model->getIdByDescription( $key );
                $this->FormulaireSociete_model->insert($id, $value);
            }

            // Insérer les données de exercice dans Exercice_model
            $debutExercice = $_SESSION['exercice']['debut-exercice'];
            $this->Exercice_model->insert($debutExercice);

            // Insérer les données de dirigeant dans Dirigeant_model
            $dirigeant = $this->session->userdata('dirigeant');
            $this->Dirigeant_model->insert($dirigeant['nom'], $dirigeant['courriel'], $dirigeant['datedebut']);

            var_dump($_SESSION);

            redirect('Accueil');
        }

    }

///étape 4 
    public function comptabilite(){
        $this->getDataCompta();
        $this->load->view('template1.php' , $this->data);
    }

    public function getDataCompta(){
        $this->data['etape'] = 4;
        $this->data['content'] = 'comptabilite.php';
        $this->data['suivant']='CreateProfile/process_comptabilite';
        $this->data['retour']='CreateProfile/create';
        $this->data['titreEtape']='Comptabilités:';
        $this->data['description']="Enfin donner nous la date de début d'exercice,";

    }


    public function process_comptabilite(){
        $this->form_validation->set_rules('debut-exercice', 'debut-exercice', 'required');
        if ($this->form_validation->run() == FALSE) {
            $this->load->view('comptabilite');
        } else {
            $_SESSION['exercice']['debut-exercice'] = $this->input->post('debut-exercice');            

            redirect('createProfile/create');
        }
    }

/// étape 3
    public function declaration(){
        $this->getDataDeclaration();
        $this->load->view('template1.php',$this->data);
    }

    public function getDataDeclaration(){
        $this->data['etape'] = 3;
        $this->data['content'] = 'declaration.php';
        $this->data['suivant']='CreateProfile/process_declaration';
        $this->data['retour']='CreateProfile/dirigeant';
        $this->data['titreEtape']='Declaration Administrative :';
        $this->data['description']='Quelque déclaration';
    }

    public function process_declaration()
    {
        $config['upload_path'] = './uploads';
        $config['allowed_types'] = 'gif|jpg|png|webp|jpeg';
        $config['max_size'] = 4000;
        $config['max_width'] = 4000;
        $config['max_height'] = 4000;

        $this->form_validation->set_rules('nif', 'NIF', 'required');
        
        $this->form_validation->set_rules('ns', 'NS', 'required');

        $this->form_validation->set_rules('rcs', 'RCS', 'required');

        $this->form_validation->set_rules('capital', 'Capital', 'required');

        $file = array(); $nsImg ; $nifImg ; $rcsImg;

        if ($this->form_validation->run() == FALSE) {
             // Erreurs de validation
            $this->data['errors'] = validation_errors();
            echo ' erreur eto  '.$this->data['errors'];
            // $this->load->view('declaration');
        } else {
            $this->upload->initialize($config);
            if ($this->upload->do_upload('nifImg') ){
                $file = $this->upload->data() ;
                $nifImg = $file['file_name'];
            }
            if(    $this->upload->do_upload('nsImg') ){
                $file = $this->upload->data() ;
                $nsImg = $file['file_name'];
            }
            if ( $this->upload->do_upload('rcsImg')) {
                $file = $this->upload->data() ;
                $rcsImg = $file['file_name'];
                // Traiter les données de formulaire ici
                $nif = $this->input->post('nif');
                $ns = $this->input->post('ns');
                $rcs = $this->input->post('rcs');
                $capital = $this->input->post('capital');

                $data = array(
                    'nif' => $this->input->post('nif'),
                    'ns' => $this->input->post('ns'),
                    'rcs' => $this->input->post('rcs'),
                    'capital' => $this->input->post('capital'),
                    'nifImg' => $nifImg,
                    'nsImg' => $nsImg,
                    'rcsImg' => $rcsImg
                );

                // Stocker les données du formulaire en session
                $this->session->set_userdata('declaration', $data);
                // Charger la vue dirigeant.php
                var_dump($_SESSION);

                redirect( 'CreateProfile/comptabilite' );

            }
            else {
                //Erreur de l'upload
                var_dump( $this->upload->display_errors());
                $this->load->view('', array('error' => $this->upload->display_errors()));
            }
        }
    }

    
/// étape2
    public function dirigeant(){
        $this->getDataDirigeant();
        $this->load->view('template1.php' , $this->data);
    } 

    public function getDataDirigeant(){
        $this->data['etape'] = 2;
        $this->data['content'] = 'dirigeant.php';
        $this->data['suivant']='CreateProfile/process_dirigeant';
        $this->data['retour']='CreateProfile';
        $this->data['titreEtape']='Informations sur le dirigeant:';
        $this->data['description']='Maintenant parlons de celui qui dirige votre société';
    }

    public function process_dirigeant()
    {
        // Valider les données du formulaire
        $this->form_validation->set_rules('nom', 'Nom', 'trim|required');
        $this->form_validation->set_rules('courriel', 'Courriel', 'trim|required|valid_email');
        $this->form_validation->set_rules('datedebut', 'Date de début', 'trim|required');
        if ($this->form_validation->run() == FALSE) {
            $this->getDataDirigeant();
            $this->load->view('template1.php' , $this->data);
        } else {
            // Stocker les données du formulaire en session
            $data = array(
                'nom' => $this->input->post('nom'),
                'courriel' => $this->input->post('courriel'),
                'contact' => $this->input->post('contact'),
                'datedebut' => $this->input->post('datedebut')
            );
            $this->data['data'] = $data; 
            $this->session->set_userdata('dirigeant', $data);  
            // var_dump( $_SESSION);
            redirect( 'createProfile/declaration' );
        }
    }

/// étape 1 
    public function rate() {
        $config['upload_path'] = './uploads';
        $config['allowed_types'] = 'gif|jpg|png|webp|jpeg';
        $config['max_size'] = 4000;
        $config['max_width'] = 4000;
        $config['max_height'] = 4000;

        // Règles de validation pour chaque champ de formulaire
        $this->form_validation->set_rules('nom', 'Nom', 'required|min_length[3]|max_length[20]|trim');
        $this->form_validation->set_rules('objet', 'Objet', 'required|min_length[3]|max_length[30]|trim');
        $this->form_validation->set_rules('siege', 'Siège', 'required|min_length[3]|max_length[30]|trim');
        $this->form_validation->set_rules('datecreation', 'Date de création', 'required|trim');
        $this->form_validation->set_rules('nbPersonne', 'Nombre de personne', 'required|trim|integer|greater_than[0]|trim');
        $this->form_validation->set_rules('telephone', ' Téléphone ', 'required|trim');
        $this->form_validation->set_rules('telecopie', ' Télécopie ', 'required|trim');

        // Si la validation échoue, revenir à la page précédente
        if ($this->form_validation->run() == FALSE) {
            $this->load->view('template1',$this->data);
        } else {
            // upload
            $this->upload->initialize($config);
            if (!$this->upload->do_upload('logo')) {
                $error = array('error' => $this->upload->display_errors());
                $this->data['error'] = $error;
                var_dump( $error );
                // $this->load->view('template1',$this->data);
            }else{
                $data = array('upload_data' => $this->upload->data());
                $info = array(
                    'nom' => $this->input->post('nom'),
                    'objet' => $this->input->post('objet'),
                    'siege' => $this->input->post('siege'),
                    'datecreation' => $this->input->post('datecreation'),
                    'logo' => $data['upload_data']['file_name'],
                    'telephone' => $this->input->post('telephone'),
                    'telecopie' => $this->input->post('telecopie'),
                    'nbPersonne' => $this->input->post('nbPersonne')
                );
                
                $this->session->set_userdata('info', $info);
                // redirect( 'createProfile/dirigeant' );
            }
        }
    }


}