<?php
    include('../config/database.php');
    $username = '';
    $password = '';
    $devisename = '';
    $deviseId = '';
    
    // tableau contenant les erreurs
    $errors = array();

    // validation de l'adresse  email
    if (isset($_POST['username'])) {
        if(!empty($_POST['username'])){
            $username = addslashes($_POST['username']);
        }else {
            array_push($errors,"Le username ne peut pas etre vide");
        }
    }else {
        array_push($errors,"Le username est obligatoire");
    }

    // validation du mot de passe
    if (isset($_POST['password'])) {
        if(!empty($_POST['password'])){
            $password = md5($_POST['password']);
        }else {
            array_push($errors,"Le password ne peut pas etre vide");
        }
    }else {
        array_push($errors,"Le password est obligatoire");
    }

    // validation des infos du devise
    if (isset($_POST['devisename'])) {
        if(!empty($_POST['devisename'])){
            $devisename = addslashes($_POST['devisename']);
        }else {
            array_push($errors,"impossible de recuperer certains informations");
        }
    }else {
        array_push($errors,"impossible de recuperer certains informations");
    }

    // validation des infos du devise
    if (isset($_POST['deviseId'])) {
        if(!empty($_POST['deviseId'])){
            $deviseId = addslashes($_POST['deviseId']);
        }else {
            array_push($errors,"impossible de recuperer certains informations");
        }
    }else {
        array_push($errors,"impossible de recuperer certains informations");
    }




    // verification du tableau des erreurs
    if(count($errors) == 0){
        
        // verifier si l'email de l'utilisateur existe
        $queryCheck = "SELECT * FROM utilisateur WHERE 
                            email='$username' OR telephone='$username' 
                            AND password='$password'";

        // execution de la requete
        $resultatCheck = mysqli_query($db,$queryCheck);
        $rowCheck = mysqli_num_rows($resultatCheck);
        $user = array();
        $deviseInfo = array();

        if($rowCheck !=0 ){
            while($row = mysqli_fetch_assoc($resultatCheck)){
               $user[] = $row;
               
            }

            $iduser = $user[0]['id'];
            
            // recuperation des informations du devise l'utilisateur
            $deviseResultat = mysqli_query($db,"SELECT * FROM telephoneInfo 
                WHERE  idutilisateur = '$iduser' ");


            // verification si le devise existe
            if(mysqli_num_rows($deviseResultat) != 0){
                while($row = mysqli_fetch_assoc($deviseResultat)){
                   $deviseInfo[] = $row; 
                }
            }

            // verifier si le devise actuel de l'utilisateur est enregistrer dans la base de donne
            if ($devisename == $deviseInfo[0]['devisename']) {
                

               if (trim($deviseId)==trim($deviseInfo[0]['deviseId'])) {
                   // session_start();
                   // $_SESSION['isbedou'] = true;
                   // $_SESSION['email'] = $user[0]['email'];
                   // $_SESSION['iduser'] = $user[0]['id'];
                   // $_SESSION['deviseId'] = $deviseInfo[0]['deviseId'];
                   // $_SESSION['devisename'] = $deviseInfo[0]['devisename'];

                   setcookie('isbedou', true, time() + 365*24*3600, null, null, false, true);

                   setcookie('email', $user[0]['email'], time() + 365*24*3600, null, null, false, true);


                   setcookie('iduser', $user[0]['id'], time() + 365*24*3600, null, null, false, true);

                   setcookie('deviseId', $deviseInfo[0]['deviseId'], time() + 365*24*3600, null, null, false, true);


                   setcookie('devisename', $deviseInfo[0]['devisename'], time() + 365*24*3600, null, null, false, true);


                    echo(
                        json_encode(
                            array(
                                "code"=>1,
                                "user"=>$user
                            )
                        )
                    );
               }else {
                    echo(
                        json_encode(
                            array(
                                "code"=>0,
                                "message"=>"Echec de connexion , tentative de connexion depuis un autre téléphone ..."
                            )
                        )
                    );
                   
               }
            }else {
                    echo(
                        json_encode(
                            array(
                                "code"=>0,
                                "message"=>"Echec de connexion , tentative de connexion depuis un autre téléphone"
                            )
                        )
                    );
                   
               }
           



        }else{
            echo(
                json_encode(
                    array(
                        "code"=>0,
                        "message"=>"Identifiant ou mot passe incorrect"
                    )
                )
            );
        }
        

    }else{
        echo(
            json_encode(
                array(
                    "code"=>0,
                    "message"=>"Veuillez remplir tout les champs du formulaire"
                )
            )
        );
    }



?>