
    <nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl " id="navbarBlur" data-scroll="false">
      <div class="container-fluid py-1 px-3">

        <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
          <div class="ms-md-auto pe-md-3 d-flex align-items-center">
          <form action="<?php echo site_url('compte/search'); ?>"> 
          <div class="input-group">
              <span class="input-group-text text-body"><i class="fas fa-search" aria-hidden="true"></i></span>
              <input type="text" class="form-control" placeholder="Type here..." name="recherche">
            </div>
            </form>
            <div class="input-group"style="margin-left:1vh;">
              <form action="<?php echo site_url('compte/addform'); ?>">
                <input type="submit" class="form-control" value="Ajouter un compte">
              </form>
            </div>
            
          </div>

        </div>
      </div>
    </nav>
    <!-- End Navbar -->
    <div class="container-fluid py-4">
      <div class="row">
        <div class="col-12">
          <div class="card mb-4">
            <div class="card-header pb-0">
              <h6>Plan comptable general</h6>
              <?php 
                    if(isset($erreur)){ ?>
                      <p id="erreur">
                        <?php echo $erreur; ?>
                      </p>
               <?php     }
                  ?>
                  <?php 
                    if(isset($message)){ ?>
                      <p id="message">
                        <?php echo $message; ?>
                      </p>
               <?php     }
                  ?>
            </div>
            <div class="card-body px-0 pt-0 pb-2">
              <div class="table-responsive p-0">
                <table class="table align-items-center mb-0">
                  <thead>
                    <tr>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Numero de compte</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Libelle</th>
                      <th class="text-secondary opacity-7"></th>
                      <th class="text-secondary opacity-7"></th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php
                      foreach($list as $compte){ ?>
                          <tr>
                      <td>
                        <div class="d-flex px-2 py-1">
                          <div class="d-flex flex-column justify-content-center">
                            <h6 class="mb-0 text-sm"><?php echo $compte['numero']; ?></h6>
                          </div>
                        </div>
                      </td>
                      <td>
                        <p class="text-xs font-weight-bold mb-0"><?php echo $compte['libelle']; ?></p>
                      </td>
                      <td class="align-middle">
                        <a href="<?php echo site_url('compte/editform'.'?id='.$compte['idcompte']); ?>" class="text-secondary font-weight-bold text-xs" data-toggle="tooltip" data-original-title="Edit user">
                          Edit
                        </a>
                      </td>
                      <td class="align-middle">
                        <a href="" onclick="return confirmDelete('<?php echo $compte['idcompte']; ?>','<?php echo $compte['libelle']; ?>');" class="text-secondary font-weight-bold text-xs" data-toggle="tooltip">
                          Delete
                        </a>
                      </td>
                    </tr>  
                    <?php  }
                    ?>              
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
      <script>
function confirmDelete(itemId,nom) {
  // Blur the page
  // var page=document.getElementsByClassName('main-content')[0];
  // var sidenav=document.getElementById('sidenav-main');
  // sidenav.style.opacity=0.7;
  // page.style.opacity = 0.7;
  // Create the confirmation message box
  var confirmBox = document.createElement('div');
  confirmBox.classList.add('confirm-box');
  var message = document.createElement('p');
  message.textContent = 'Etes vous sur de vouloir supprimer '+nom;
  confirmBox.appendChild(message);
  
  // Create the confirm and cancel buttons
  var confirmButton = document.createElement('button');
  confirmButton.textContent = 'Oui';
  confirmButton.classList.add('confirm-button');
  confirmButton.onclick = function() {
    // Redirect to the delete URL with the item ID
    window.location.href = '<?php echo site_url('compte/delete'); ?>' + '?id=' + itemId;
  };
  
  var cancelButton = document.createElement('button');
  cancelButton.textContent = 'Non';
  cancelButton.classList.add('cancel-button');
  cancelButton.onclick = function() {
    // Remove the confirmation message box and unblur the page
    document.body.style.filter = '';
    sidenav.style.opacity=1;
    page.style.opacity = 1;
    confirmBox.parentNode.removeChild(confirmBox);
  };
  var buttonWrapper = document.createElement('div');
  buttonWrapper.classList.add('button-wrapper');
  buttonWrapper.appendChild(confirmButton);
  buttonWrapper.appendChild(cancelButton);
  confirmBox.appendChild(buttonWrapper);
  confirmBox.style.opacity='inherit';
  // Add the confirmation message box to the page
  document.body.appendChild(confirmBox);
  
  // Prevent the link from redirecting automatically
  return false;
}
</script>