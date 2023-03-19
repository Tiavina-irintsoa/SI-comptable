<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $title ; ?></title>
    <link rel="stylesheet" href="<?php echo base_url();?>assets\css\creation.css">
    <style>
        .none{
            pointer-events: none;
            opacity: 0.5;
        }
    </style>
</head>
<body>
    <header>
            <div class="logo">AccountWork</div>
            <div class="blank"></div>
        </header>
        <div class="container">
            <div class="formulaire">
                <div class="page">
                <?php echo $etape;?>/4
                </div>
                <div class="title">
                    <?php echo $titreEtape; ?>
                </div>
                <div class="description">
                    <?php echo $description; ?>
                </div>
