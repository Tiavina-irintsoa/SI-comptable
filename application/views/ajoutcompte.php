      <div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mx-auto">
              
      <div class="card card-plain">
                <div class="card-header pb-0 text-start">
                  <h4 class="font-weight-bolder">Ajouter un compte</h4>
                  <p class="mb-0">Entrez un numero de compte et un libelle</p>
                  <?php 
                    if(isset($erreur)){ ?>
                      <p id="erreur">
                        <?php echo $erreur; ?>
                      </p>
               <?php     }
               if(isset($numero)){
                $value=$numero;
              }
              else{
                $value=set_value('numero');
              }
                  ?>
                  <?php 
                    if(isset($message)){ ?>
                      <p id="message">
                        <?php echo $message; ?>
                      </p>
               <?php     }
                  ?>
                </div>
                <div class="card-body">
                <?php echo form_open('compte/add', array( 'method'=>'post')); ?>
                    <div class="mb-3">
                    <?php echo form_input(array(
                          'name'          => 'numero',
                          'id'            => 'numero',
                          'class'         => 'form-control form-control-lg',
                          'placeholder'   => 'Numero de compte',
                          'aria-label'    => 'Numero ',
                          'required' => true,
                          'maxlength' => '5',
                          'value'=>$value
                      )) ;
                      
                      ?> 
                      <p class="erreur">
                      <?php echo form_error('numero'); ?>
                      </p>
                    </div>
                    <div class="mb-3">
                    <?php
                        echo form_input(array(
                          'name' => 'libelle',
                          'id' => 'libelle',
                          'class' => 'form-control form-control-lg',
                          'placeholder' => 'Libelle',
                          'required' => true,
                          'value'=>set_value('libelle')
                      ));
                      
                    ?>
                    <p class="erreur">
                      <?php echo form_error('libelle'); ?>
                      </p>
                    </div>
                    <div class="text-center">
                      <button type="submit" class="btn btn-lg btn-primary btn-lg w-100 mt-4 mb-0">Valider</button>
                    </div>
                  </form>
                </div>
                <div style="display:flex;justify-content:center;align-items:center;">
                  <a style="text-decoration:underline;" href="<?php
                   echo site_url("compte/uploadform"); ?>">
                    Importer un fichier CSV
                   </a>
                </div>
              </div>
            </div>

          </div>
        </div>
      </div>
    </section>
  </main>
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/parsleyjs@2.9.2/dist/parsley.min.js"></script>
  <script type="text/javascript">
$(function () {
  $('#demo-form').parsley().on('field:validated', function() {
    var ok = $('.parsley-error').length === 0;
    $('.bs-callout-info').toggleClass('hidden', !ok);
    $('.bs-callout-warning').toggleClass('hidden', ok);
  })
  .on('form:submit', function() {
    return false; // Don't submit form for this demo
  });
});
</script>
  