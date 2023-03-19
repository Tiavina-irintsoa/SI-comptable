<?php
defined('BASEPATH') OR exit('No direct access allowed');
class ComptabiliteModel extends CI_Model{
    public function getInfo(){
        $query = $this->db->get_where('info_description' , array('description' => 'tenue_compte(Ariary)'));
        $tenue_compte = $query -> row();

        $query = $this->db->get_where('info_description' , array('description' => 'capital'));
        $capital = $query -> row();

        $query = $this->db->get_where('date_exrcice_extract');
        $exercice = $query -> last_row();

        $query = $this->db->get('mois' , array('idmois' => $exercice->mois_debut));
        $mois_debut = $query -> row();

        $query = $this->db->get_where('mois' , array('idmois' => $exercice->mois_fin));
        $mois_fin = $query -> row();

        return array(
            'tenue_compte'=>$tenue_compte->valeur,
            'Capital'=>$capital->valeur,
            'ExerciceDebut'=>$exercice->jour_debut . ' ' . $mois_debut->mois . ' ' . $exercice->annee_debut,
            'ExcerciceFin'=>$exercice->jour_fin . ' ' . $mois_fin->mois . ' ' . $exercice->annee_fin
        );
    }
}