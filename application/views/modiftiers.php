<div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mx-auto">
              <div class="card card-plain">
                <div class="card-header pb-0 text-start">
                  <h4 class="font-weight-bolder">Modifier un compte tiers</h4>
                  <p class="mb-0">Modifier le compte ou le libelle</p>
                </div>
                <div class="card-body">
                <?php echo form_open('tiers/edit', array( 'method'=>'post')); ?>
                    <div class="mb-3">
                      <?php echo form_input(array(
                          'name'          => 'nom',
                          'id'            => 'nom',
                          'class'         => 'form-control form-control-lg',
                          'placeholder'   => 'Libelle',
                          'aria-label'    => 'Nom',
                          'required' => true,
                          'value'=> $tiers['nom']
                      )) ;
                      echo form_error('nom');
                      ?> 
                      </div>
                      <input type="hidden" name="id" value="<?php echo $tiers['idtiers']; ?>">
                      <div class="mb-3">
                        <?php
                        echo form_input(array(
                          'name' => 'numero',
                          'id' => 'numero',
                          'class' => 'form-control form-control-lg',
                          'placeholder' => 'Numero de compte',
                          'aria-label' => 'Numero de compte',
                          'required' => true,
                          'value'=>$tiers['numero']
                      ));
                      echo form_error('numero')
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
  