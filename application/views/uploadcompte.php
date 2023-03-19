<div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mx-auto">
              <div class="card card-plain">
                <div class="card-header pb-0 text-start">
                  <h4 class="font-weight-bolder">Importer un fichier csv</h4>
                
                    <?php if(isset($erreur)){  ?>
                        <p style="color:red;font-size:smaller;">
                        <?php echo $erreur; ?>
                        </p>
                <?php   } 
                if(isset($message)){
                    ?>
                        <p style="color:green;font-size:smaller;">
                        <?php echo $message; ?>
                        </p>
                <?php   
                }
                ?>
                
                </div>
                <div class="card-body">
                <?php echo form_open_multipart('compte/upload', array( 'method'=>'post')); ?>
                    <div class="mb-3">
                    <?php echo form_input(array(
                          'name'          => 'file',
                          'id'            => 'file',
                          'class'         => 'form-control form-control-lg',
                          'type'=>'file'
                      )) ;
                      echo form_error('file');
                      ?> 
                    </div>
                    </div>
                    <div class="text-center">
                      <button type="submit" class="btn btn-lg btn-primary btn-lg w-100 mt-4 mb-0">Valider</button>
                    </div>
                  </form>
                </div>
                <div style="display:flex;justify-content:center;align-items:center;">
                  <a style="text-decoration:underline;" href="<?php
                   echo site_url("compte/addform"); ?>">
                    Ajouter un compte
                   </a>
                </div>
              </div>
            </div>

          </div>
        </div>
      </div>
    </section>
  </main>
  