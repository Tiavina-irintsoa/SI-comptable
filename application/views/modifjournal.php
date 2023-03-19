<div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mx-auto">
              <div class="card card-plain">
                <div class="card-header pb-0 text-start">
                  <h4 class="font-weight-bolder">Modifier un journal</h4>
                  <p class="mb-0">Modifier le code ou le nom du journal</p>
                  <p id="erreur"><?php if(isset ($erreur)){echo $erreur;} ?></p><p id="message"><?php if(isset ($message)){echo $message;} ?></p>
                </div>
                <div class="card-body">
                <?php echo form_open('journal/edit', array( 'method'=>'post')); ?>
                    <div class="mb-3">
                      <?php echo form_input(array(
                          'name'          => 'code',
                          'id'            => 'code',
                          'class'         => 'form-control form-control-lg',
                          'placeholder'   => 'Code',
                          'aria-label'    => 'Code',
                          'required' => true,
                          'value'=> $code
                      )) ;
                      echo form_error('code');
                      ?> 
                      </div>
                      <input type="hidden" name="id" value="<?php echo $id; ?>">
                      <div class="mb-3">
                        <?php
                        echo form_input(array(
                          'name' => 'nom',
                          'id' => 'nom',
                          'class' => 'form-control form-control-lg',
                          'placeholder' => 'Nom',
                          'aria-label' => 'Nom',
                          'required' => true,
                          'value'=>$nom
                      ));
                      echo form_error('nom')
                    ?>
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
  