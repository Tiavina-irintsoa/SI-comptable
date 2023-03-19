<nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl " id="navbarBlur" data-scroll="false">
      <div class="container-fluid py-1 px-3">

        <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
          <div class="ms-md-auto pe-md-3 d-flex align-items-center">
            <div class="input-group">
            <form action="<?php echo site_url('modif'); ?>" method="get">
              <input type="submit" class="form-control" value="Modifier les informations">
            </form>
            </div>
          </div>
        </div>
      </div>
    </nav>
<div class="main-content position-relative max-height-vh-100 h-100" style="padding-top:35vh;">
    <div class="card shadow-lg mx-4 ">
      <div class="card-body p-3">
        <div class="row gx-4">
          <div class="col-auto">
            <div class="avatar avatar-xl position-relative">
              <a href="<?php echo base_url(); ?>assets/docs/<?php echo $societe['logo'];?>" id="logo" target="__blank">
                <img src="<?php echo base_url(); ?>assets/docs/<?php echo $societe['logo'];?>" alt="profile_image" class="w-100 border-radius-lg shadow-sm">
              </a>
            </div>
          </div>
          <div class="col-auto my-auto">
            <div class="h-100">
              <h5 class="mb-1">
                <?php echo $info['nom']; ?>
              </h5>
              <p class="mb-0 font-weight-bold text-sm">
              <?php echo $info['objet']; ?>
              </p>
            </div>
          </div>
          <div class="col-lg-4 col-md-6 my-sm-auto ms-sm-auto me-sm-0 mx-auto mt-3">
            <div class="nav-wrapper position-relative end-0">
            <span class="mb-2 text-xs">Cree le: <span class="text-dark font-weight-bold ms-sm-2"><?php echo $info['creation'];?></span></span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="container-fluid py-4">
      <div class="row">
        <div class="col-md-8">
          <div class="card">
            <div class="card-header pb-0 px-3">
              <h6 class="mb-0">Informations sur la societe</h6>
            </div>
            <div class="card-body pt-4 p-3">
              <ul class="list-group">
                <li class="list-group-item border-0 d-flex p-4 mb-2 bg-gray-100 border-radius-lg">
                  <div class="d-flex flex-column">
                    <h6 class="mb-3 text-sm">Declaration administrative</h6>
                    <span class="mb-2 text-xs">Numero d'identification fiscale: <a href="<?php echo base_url().'assets/docs/'.$administration['imagenif'];?>"  target="__blank" style="text-decoration:underline;" id="nif">
                    <span class="text-dark font-weight-bold ms-sm-2"><?php echo $administration['nif'];?></span>
                    </a></span>
                    
                    <span class="mb-2 text-xs">Numero dans le registre des societes: <a href="<?php echo base_url().'assets/docs/'.$administration['imagercs'];?>" target="__blank" style="text-decoration:underline;" id="rcs">
                    <span class="text-dark ms-sm-2 font-weight-bold"><?php echo $administration['rcs'];?></span>
                    </a></span>
                    <span class="text-xs">NS: <a href="<?php echo base_url().'assets/docs/'.$administration['imagens'];?> " target="__blank" style="text-decoration:underline;" id="ns">
                    <span class="text-dark ms-sm-2 font-weight-bold"><?php echo $administration['ns'];?></span>
                    </a></span>
                  </div>
                  
                </li>
                <li class="list-group-item border-0 d-flex p-4 mb-2 mt-3 bg-gray-100 border-radius-lg">
                  <div class="d-flex flex-column">
                    <h6 class="mb-3 text-sm">Informations comptables</h6>
                    <span class="mb-2 text-xs">Devise de tenue de compte: <span class="text-dark font-weight-bold ms-sm-2"><?php echo $comptabilite['tenue_compte'];?></span></span>
                    <span class="mb-2 text-xs">Exercice comptable actuel: <span class="text-dark ms-sm-2 font-weight-bold"><?php echo $comptabilite['ExerciceDebut'].' - '.$comptabilite['ExcerciceFin'];?> </span></span>
                    <span class="text-xs">Capital: <span class="text-dark ms-sm-2 font-weight-bold"></span><?php echo format_number($comptabilite['Capital']).' '.$comptabilite['tenue_compte'];?></span>
                  </div>
                </li>
                <li class="list-group-item border-0 d-flex p-4 mb-2 mt-3 bg-gray-100 border-radius-lg">
                  <div class="d-flex flex-column">
                    <h6 class="mb-3 text-sm">Contact et siege</h6>
                    <span class="mb-2 text-xs">Siege: <span class="text-dark font-weight-bold ms-sm-2"><?php echo $info['siege']; ?></span></span>
                    <span class="mb-2 text-xs">Courriel: <span class="text-dark ms-sm-2 font-weight-bold"><?php echo $info['email']; ?></span></span>
                    <span class="text-xs">Contact: <span class="text-dark ms-sm-2 font-weight-bold"><?php echo $info['telephone'].' - '.$info['telecopie']; ?></span></span>
                  </div>

                  
                </li>
              </ul>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card card-profile">
            <img src="<?php echo base_url(); ?>assets/img/<?php echo $societe['logo']; ?> " alt="logo" class="card-img-top">
            <div class="row justify-content-center">
              <div class="col-4 col-lg-4 order-lg-2">
                <div class="mt-n4 mt-lg-n6 mb-4 mb-lg-0">
                  <a href="javascript:;">
                    <img src="<?php echo base_url();?>assets/img/2503707.png" class="rounded-circle img-fluid border border-2 border-white">
                  </a>
                </div>
              </div>
            </div>
            
            <div class="card-body pt-0">

              <div class="text-center mt-4">
                <h5>
                  <?php echo $dirigeant['nom']; ?> 
                </h5>
                <div class="h6 font-weight-300">
                  <span class="font-weight-light mb-2 text-xs">Dirigeant depuis: </span> <span class="text-dark ms-sm-2 font-weight-bold"><?php echo $dirigeant['Date']; ?></span>
                </div>
                <div class="h6 mt-4">
                  <span class="font-weight-light mb-2 text-xs">Courriel: </span><span class="text-dark ms-sm-2 font-weight-bold"><?php echo $dirigeant['email']; ?></span>
                </div>
                <div>
                  <a href="modif/dirigeantform" style="font-size:smaller; text-decoration: underline;">
                    Changer de dirigeant
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      </div>
  </div>
</div>
