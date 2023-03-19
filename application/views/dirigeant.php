<div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mx-auto">
              <div class="card card-plain">
                <div class="card-header pb-0 text-start">
                  <h4 class="font-weight-bolder">Modifier le dirigeant</h4>
                  <p class="mb-0">Entrez le nom du nouveau dirigeant, son email et la date depuis laquelle il/elle dirige</p>

                  <p id="erreur"><?php if(isset ($erreur)){echo $erreur;} ?></p><p id="message"><?php if(isset ($message)){echo $message;} ?></p>
                </div>
                <div class="card-body">
                <?php echo form_open('modif/newdirigeant', array( 'method'=>'post')); ?>
                    <div class="mb-3">
                    <?php echo form_input(array(
                          'name'          => 'nom',
                          'id'            => 'nom',
                          'class'         => 'form-control form-control-lg',
                          'placeholder'   => 'Nom',
                          'aria-label'    => 'nom',
                          'required' => true,
                          'value'=>set_value('nom')
                      )) ;
                      ?>
                      <p id="erreur">
                        <?php echo form_error('nom');?>
                      </p>
                    </div>
                    <div class="mb-3">
                    <?php echo form_input(array(
                          'name'          => 'email',
                          'id'            => 'email',
                          'class'         => 'form-control form-control-lg',
                          'placeholder'   => 'Email',
                          'aria-label'    => 'email',
                          'required' => true,
                          'type'=>'email',
                          'value'=>set_value('email')
                      )) ;
                      ?>
                      <p id="erreur">
                        <?php echo form_error('email');?>
                      </p>
                    </div>
                    <div class="mb-3">
                    <?php echo form_input(array(
                          'name'          => 'date',
                          'id'            => 'date',
                          'class'         => 'form-control form-control-lg',
                          'placeholder'   => 'Date',
                          'aria-label'    => 'Date',
                          'required' => true,
                          'type'=>'date',
                          'value'=>set_value('date')
                      )) ;
                      ?>
                      <p id="erreur">
                        <?php echo form_error('date');?>
                      </p>
                    </div>
                    </div>
                    <div class="text-center">
                      <button type="submit" class="btn btn-lg btn-primary btn-lg w-100 mt-4 mb-0">Valider</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>

          </div>
        </div>
      </div>
    </section>
  </main>
  