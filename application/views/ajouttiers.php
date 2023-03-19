            
            <div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mx-auto">
              <div class="card card-plain" >
                <div class="card-header pb-0 text-start" id='errorholder'>
                  <h4 class="font-weight-bolder">Ajouter un compte tiers</h4>
                  <p class="mb-0">Entrez un compte et un libelle</p>
                </div>
                <input id='linkhidden' type="hidden" name="link" value=<?php echo site_url('compte/addform'); ?>>
                <div class="card-body">
                <?php 
                
                echo form_open('tiers/add', array( 'method'=>'post','id'=>'formulaire')); ?>
                    <div class="mb-3">
                      <?php echo form_input(array(
                          'name'          => 'nom',
                          'id'            => 'nom',
                          'class'         => 'form-control form-control-lg',
                          'placeholder'   => 'Libelle',
                          'aria-label'    => 'Nom',
                          'required' => true,
                          'value'=>set_value('nom')
                      )) ;
                      echo form_error('nom');
                      ?> 
                      </div>
                      <div class="mb-3">
                        <?php
                        echo form_input(array(
                          'name' => 'numero',
                          'id' => 'numero',
                          'class' => 'form-control form-control-lg',
                          'placeholder' => 'Numero de compte',
                          'aria-label' => 'Numero de compte',
                          'required' => true,
                          'value'=>set_value('numero');
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
