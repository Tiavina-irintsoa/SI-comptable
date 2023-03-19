<?php
defined('BASEPATH') OR exit('No direct access allowed');

function to_array($objects){
    $tableau_associatif = array();

foreach ($objects as $objet) {
    $tableau_associatif[] = get_object_vars($objet);
}
return $tableau_associatif;
}