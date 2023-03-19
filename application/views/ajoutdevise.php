<div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mx-auto">
              <div class="card card-plain">
                <div class="card-header pb-0 text-start">
                  <h4 class="font-weight-bolder">Ajouter une devise</h4>
                  <p class="mb-0">Entrez une monnaie</p>
                  <p id="erreur"><?php if(isset ($erreur)){echo $erreur;} ?></p><p id="message"><?php if(isset ($message)){echo $message;} ?></p>
                </div>
                <div class="card-body">
                <?php echo form_open('devise/add', array( 'method'=>'post')); ?>
                    <div class="mb-3">
                      <?php echo form_input(array(
                          'name'          => 'nom',
                          'id'            => 'nom',
                          'class'         => 'form-control form-control-lg',
                          'placeholder'   => 'Nom de devise',
                          'aria-label'    => 'Nom',
                        //   'required' => true,
                          'value'=>set_value('nom')
                      )) ;
                      
                      ?> 
                      <p id="erreur">
                        <?php echo form_error('nom'); ?>
                      </p>
                      </div>
                      <div class="mb-3">
                      <?php echo form_input(array(
                          'name'          => 'taux',
                          'id'            => 'taux',
                          'class'         => 'form-control form-control-lg',
                          'placeholder'   => 'Taux de devise',
                          'aria-label'    => 'Taux',
                        //   'required' => true,
                          'value'=>set_value('taux')
                      )) ;
                      
                      ?> 
                      <p id="erreur">
                        <?php echo form_error('taux'); ?>
                      </p>
                      </div>
                      <div class="mb-3">
                      <?php echo form_input(array(
                          'name'          => 'date',
                          'id'            => 'date',
                          'class'         => 'form-control form-control-lg',
                          'placeholder'   => 'Date',
                          'aria-label'    => 'Date',
                          'type'=>'date',
                           'required' => true,
                          'value'=>set_value('date')
                      )) ;
                      ?> 
                      <p id="erreur">
                        <?php echo form_error('date'); ?>
                      </p>
                      </div>
                    <div class="text-center">
                      <button type="submit" class="btn btn-lg btn-primary btn-lg w-100 mt-4 mb-0">Valider</button>
                    </div>
                    <?php
                        echo form_close();
                    ?>
                </div>
              </div>
            </div>

          </div>
        </div>
      </div>
    </section>
  </main>
  