    <nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl " id="navbarBlur" data-scroll="false">
      <div class="container-fluid py-1 px-3">

        <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
          <div class="ms-md-auto pe-md-3 d-flex align-items-center">
          <form action="<?php echo site_url('tiers/search'); ?>"> 
          <div class="input-group">
              <span class="input-group-text text-body"><i class="fas fa-search" aria-hidden="true"></i></span>
              <input type="text" class="form-control" placeholder="Type here..." name="recherche">
            </div>
            </form>
            <div class="input-group">
            <form action="<?php echo site_url('tiers/addform'); ?>" method="get">
              <input type="submit" class="form-control" value="Ajouter un compte tiers" style="margin-left:1vh;">
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
              <h6>Les comptes tiers</h6>
            </div>
            <div class="card-body px-0 pt-0 pb-2">
              <div class="table-responsive p-0">
                <table class="table align-items-center mb-0">
                  <thead>
                    <tr>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Compte</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Libelle</th>
                      <th class="text-secondary opacity-7"></th>
                      <th class="text-secondary opacity-7"></th>
                    </tr>
                  </thead>
                  <tbody>
                   
                   <?php foreach ($list as $tiers) { ?>
                    <tr>
                      <td>
                        <div class="d-flex px-2 py-1">
                          <div class="d-flex flex-column justify-content-center">
                            <h6 class="mb-0 text-sm"><?php echo $tiers['numero']; ?></h6>
                          </div>
                        </div>
                      </td>
                      <td>
                        <p class="text-xs font-weight-bold mb-0"><?php echo $tiers['nom']; ?></p>
                      </td>
                      <td class="align-middle">
                        <a href="<?php echo site_url('tiers/editform'.'?id='.$tiers['idtiers']); ?>" class="text-secondary font-weight-bold text-xs" data-toggle="tooltip" data-original-title="Edit user">
                          Edit
                        </a>
                      </td>
                      <td class="align-middle">
                      <a href="" onclick="return confirmDelete('<?php echo $tiers['idtiers']; ?>','<?php echo $tiers['nom']; ?>');" class="text-secondary font-weight-bold text-xs" data-toggle="tooltip" data-original-title="Delete user">
                         Delete
                    </a>
                      </td>
                    </tr>
                  <?php } ?>
                    
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
  document.body.style.filter = 'blur(0.3px)';
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
    window.location.href = '<?php echo site_url('tiers/delete'); ?>' + '?id=' + itemId;
  };
  
  var cancelButton = document.createElement('button');
  cancelButton.textContent = 'Non';
  cancelButton.classList.add('cancel-button');
  cancelButton.onclick = function() {
    // Remove the confirmation message box and unblur the page
    document.body.style.filter = '';
    confirmBox.parentNode.removeChild(confirmBox);
  };
  var buttonWrapper = document.createElement('div');
  buttonWrapper.classList.add('button-wrapper');
  buttonWrapper.appendChild(confirmButton);
  buttonWrapper.appendChild(cancelButton);
  confirmBox.appendChild(buttonWrapper);
  
  
  // Add the confirmation message box to the page
  document.body.appendChild(confirmBox);
  
  // Prevent the link from redirecting automatically
  return false;
}
</script>
     