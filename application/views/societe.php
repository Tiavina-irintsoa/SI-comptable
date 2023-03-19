
             <?php
                echo form_open_multipart($suivant);
            ?>
                        <div class="form-group">
                            <?php
                                echo form_label('Nom :', 'nom');
                                echo form_input(array(
                                    'name' => 'nom',
                                    'id' => 'nom',
                                    'value' => (set_value('nom'))? set_value('nom') : $this->session->userdata('nom'),
                                    'class' => 'form-control',
                                    'required' => true
                                ));
                            ?>
                        </div>
                        <div class="form-group">
                            <?php
                                echo form_label('Objet :', 'objet');
                                echo form_input(array(
                                    'name' => 'objet',
                                    'id' => 'objet',
                                    'value' => (set_value('objet'))? set_value('objet') : $this->session->userdata('objet'),
                                    'class' => 'form-control',
                                    'required' => true
                                ));
                                echo form_error('objet');
                            ?>
                        </div>
                        <div class="form-group">
                            <?php
                                echo form_label('Siège :', 'siege');
                                echo form_input(array(
                                    'name' => 'siege',
                                    'id' => 'siege',
                                    'value' => (set_value('siege'))? set_value('siege') : $this->session->userdata('siege'),
                                    'class' => 'form-control',
                                    'required' => true
                                ));
                                echo form_error('siege');
                            ?>
                        </div>
                        <div class="form-group">
                            <?php
                                echo form_label('Téléphone :', 'telephone');
                                echo form_input(array(
                                    'name' => 'telephone',
                                    'id' => 'telephone',
                                    'value' => (set_value('telephone'))? set_value('telephone') : $this->session->userdata('telephone'),
                                    'class' => 'form-control',
                                    'required' => true
                                ));
                                echo form_error('telephone');
                            ?>
                        </div>
                        <div class="form-group">
                            <?php
                                echo form_label('Télécopie :', 'telecopie');
                                echo form_input(array(
                                    'name' => 'telecopie',
                                    'id' => 'telecopie',
                                    'value' => (set_value('telecopie'))? set_value('telecopie') : $this->session->userdata('telecopie'),
                                    'class' => 'form-control',
                                    'required' => true
                                ));
                                echo form_error('telecopie');
                            ?>
                        </div>
                        <div class="form-group">
                            <?php
                                echo form_label('Date de création :', 'datecreation');
                                echo form_input(array(
                                    'name' => 'datecreation',
                                    'id' => 'datecreation',
                                    'type' => 'date',
                                    'value' => (set_value('datecreation'))? set_value('datecreation') : $this->session->userdata('datecreation'),
                                    'class' => 'form-control',
                                    'required' => true
                                ));
                                echo form_error('datecreation');
                            ?>
                        </div>
                        <div class="form-group">
                            <?php
                                echo form_label('Nombre de personne :', 'nbPersonne');
                                echo form_input(array(
                                    'name' => 'nbPersonne',
                                    'id' => 'nbPersonne',
                                    'type' => 'number',
                                    'value' => (set_value('nbPersonne'))? set_value('nbPersonne') : $this->session->userdata('nbPersonne'),
                                    'class' => 'form-control',
                                    'required' => true
                                ));
                                echo form_error('nbPersonne');
                            ?>
                        </div>
                        <div class="form-group">
                            <?php
                                echo form_label('Logo :', 'logo');
                                echo form_upload(array(
                                    'name' => 'logo',
                                    'id' => 'logo',
                                    'class' => 'form-control',
                                    'required' => true
                                ));
                                echo form_error('logo');
                            ?>
                        </div>