<div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mx-auto">
              <div class="card card-plain">
                <div class="card-header pb-0 text-start">
                  <h4 class="font-weight-bolder">Modification Informations Générales</h4>
                  <p class="mb-0">Entrez l'information à modifier</p>
                  <p id="erreur"><?php if(isset ($erreur)){echo $erreur;} ?></p><p id="message"><?php if(isset ($message)){echo $message;} ?></p>
                </div>
                <div class="card-body">
                <?php echo form_open_multipart('modif/save', array( 'method'=>'post')); ?>
                    <div class="mb-3">
                      <input type="hidden" name="link" value="<?php echo site_url("modif/getinput"); ?>" id="linkphp">
                    <select name="description" class="form-control form-control-lg">
                    <?php foreach ($descriptions as $description) { ?>
                        <option value="<?php echo $description->iddescription; ?>" <?php if($description->iddescription==set_value('description')){
                          echo "selected";
                        }?> > <?php echo $description->description; ?></option>
                        <?php } ?>
                    </select>
                      </div>
                      <div class="mb-3">
                        <input type="text" name="text" placeholder="Valeur" value="<?php echo set_value('valeur'); ?>"  class="form-control form-control-lg" id="inputchange" required>
                        <?php echo form_error('valeur'); ?>
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
  