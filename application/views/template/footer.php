
                        <?php 
                            $class = ' retour ';
                            if( $etape == 1 )   $class .= ' none';
                        ?>
                        <div class="form-buttons">
                            <?php
                                echo anchor( $retour, 'Retour', array(
                                    'id' => 'back',
                                    'class' => 'btn btn-secondary '.$class
                                ));
                                echo form_submit(array(
                                    'name' => 'submit',
                                    'id' => 'next',
                                    'value' => 'Suivant, description',
                                    'class' => 'btn btn-primary'
                                ));

                            ?>
                        </div>
                    <?php
                        echo form_close();
                    ?>
                </div>
            </form>       
        </div>
    </div>
</body>
</html>