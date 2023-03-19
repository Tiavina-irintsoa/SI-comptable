
                <h1>
                    <?php echo $section1; ?>
                </h1>
                <a href="#two"><?php echo $button; ?></a>
            </div>
            <div id='two' class="slide two">
            <div id="formulaire">
                <h1><?php echo $description; ?></h1>
                <form method="post" action="<?php echo base_url() . $lien ; ?>">
                <?php if (isset($success)){ ?>
                    <div class="succes"><?php echo $success; ?></div>
                <?php } ?>
                <?php if (isset($error)){ ?>
                    <div class="alert alert-danger"><?php echo $error; ?></div>
                <?php } ?>
                    <div class="form-group">
                        <?php echo form_error('nom'); ?>
                        <label for="username">Nom d'utilisateur :</label>
                        <input type="text" id="username" name="username" value="<?php echo set_value('username') ; ?>" required>
                    </div>
                    <div class="form-group">
                        <?php echo form_error('mdp'); ?>    
                        <label for="password">Mot de passe :</label>
                        <input type="password" id="password" name="password" value="<?php echo set_value('password') ; ?>" required>
                    </div>
                    <div class="form-group">
                        <input type="submit" class="submit" value="Se connecter">
                    </div>
                </form>
            </div>
            </div>
        </div>
    </div>
    
</body>
</html>