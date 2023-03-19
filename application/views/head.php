<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="apple-touch-icon" sizes="76x76" href="./assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="./assets/img/favicon.png">
  
  <title>
    <?php echo $title; ?>
  </title>
  <link href="<?php echo base_url(); ?>assets/css/nucleo-icons.css" rel="stylesheet" />
  <link href="<?php echo base_url(); ?>assets/css/error.css" rel="stylesheet" />
  <link href="<?php echo base_url(); ?>assets/css/image.css" rel="stylesheet" />
  <link href="./assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  <script src="<?php echo base_url(); ?>assets/js/fontawesome.js" crossorigin="anonymous"></script>
  <link href="<?php echo base_url(); ?>/assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- CSS Files -->
  <link id="pagestyle" href="<?php echo base_url(); ?>assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
  <link rel="stylesheet" href="<?php echo base_url(); ?>assets/css/confirmbox.css">
</head>

<body class="g-sidenav-show   bg-gray-100">
  <div class="min-height-300 bg-primary position-absolute w-100"></div>
  <aside class="sidenav bg-white navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-4 " id="sidenav-main">
    <div class="sidenav-header">
      <i class="fas fa-times p-3 cursor-pointer text-secondary opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i>
      <a class="navbar-brand m-0" target="_blank">
        <img src="<?php echo base_url(); ?>assets/docs/<?php echo $societe['logo'] ; ?>" class="navbar-brand-img h-100" alt="main_logo">
        <span class="ms-1 font-weight-bold"><?php echo $societe['nom_societe']; ?></span>
      </a>
    </div>
    <hr class="horizontal dark mt-0">
    <div class="collapse navbar-collapse  w-auto " id="sidenav-collapse-main">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link <?php if($page=='informations'){echo " active ";} ?>" href="<?php echo site_url('informations/index'); ?>">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
              <i class="ni ni-tv-2 text-primary text-sm opacity-10"></i>
            </div>
            <span class="nav-link-text ms-1">Informations generales</span>
          </a>
        </li>
        <li class="nav-item mt-3">
          <h6 class="ps-4 ms-2 text-uppercase text-xs font-weight-bolder opacity-6">Comptabilite</h6>
        </li>
        <li class="nav-item">
          <a class="nav-link <?php if($page=='devise'){echo " active ";} ?>" href="<?php echo site_url('devise/liste'); ?>">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
              <i class="ni ni-single-02 text-dark text-sm opacity-10"></i>
            </div>
            <span class="nav-link-text ms-1">Liste des devises</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link <?php if($page=='compte'){echo " active ";} ?>" href="<?php echo site_url('compte/liste'); ?>">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
              <i class="ni ni-collection text-info text-sm opacity-10"></i>
            </div>
            <span class="nav-link-text ms-1">Plan comptable general</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link <?php if($page=='journal'){echo " active ";} ?>" href="<?php echo site_url('journal/liste'); ?>">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
              <i class="ni ni-collection text-info text-sm opacity-10"></i>
            </div>
            <span class="nav-link-text ms-1">Journaux</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link <?php if($page=='tiers'){echo " active ";} ?>" href="<?php echo site_url('tiers/liste'); ?>">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
              <i class="ni ni-collection text-info text-sm opacity-10"></i>
            </div>
            <span class="nav-link-text ms-1">Compte tiers</span>
          </a>
        </li>
        <li class="nav-item mt-3">
          <h6 class="ps-4 ms-2 text-uppercase text-xs font-weight-bolder opacity-6">Utilisateurs</h6>
        </li>
        <li>
        <a class="nav-link <?php if($page=='compte'){echo " active ";} ?>" href="<?php echo site_url('login/register'); ?>">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
              <i class="ni ni-single-02 text-dark text-sm opacity-10"></i>
            </div>
            <span class="nav-link-text ms-1">Ajouter un utilisateur</span>
          </a>
        </li>
      </ul>
    </div>
    
  </aside>
  <main class="main-content position-relative border-radius-lg ">
