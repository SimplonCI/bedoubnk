<?php
    include '../config/database.php';
    $id = 0;
    $email = '';
    $montant = 0;
    $numeroClient = '0';
    $numeroAgent = '0';
    $password = '0';

    // tableau contenant des erreurs
    $errors = array();

    // validation de l'id
    if(isset($_POST['id'])){
        if(!empty($_POST['id'])){
            $id = $_POST['id'];
        }else {
            array_push($errors,'Votre Id ne pas etre vide');
        }
    }else {
        array_push($errors,'Votre Id ne pas etre vide');
    }

    // validation du email
    if(isset($_POST['email'])){
        if(!empty($_POST['email'])){
            $email = $_POST['email'];
        }else {
            array_push($errors,'Votre email ne pas etre vide');
        }
    }else {
        array_push($errors,'Votre email ne pas etre vide');
    }

    // validation du montant
    if(isset($_POST['montant'])){
        if(!empty($_POST['montant'])){
            $montant = $_POST['montant'];
        }else {
            array_push($errors,'le montant ne pas etre vide');
        }
    }else {
        array_push($errors,'le montant ne pas etre vide');
    }

    // validation du numeroClient
    if(isset($_POST['numeroClient'])){
        if(!empty($_POST['numeroClient'])){
            $numeroClient = $_POST['numeroClient'];
        }else {
            array_push($errors,'Votre numeroClient ne pas etre vide');
        }
    }else {
        array_push($errors,'Votre numeroClient ne pas etre vide');
    }

    // validation du numeroAgent
    if(isset($_POST['numeroAgent'])){
        if(!empty($_POST['numeroAgent'])){
            $numeroAgent = $_POST['numeroAgent'];
        }else {
            array_push($errors,'le  numero de Agence ne pas etre vide');
        }
    }else {
        array_push($errors,'Votre numero de Agence ne pas etre vide');
    }

     // validation du numeroAgent
     if(isset($_POST['password'])){
        if(!empty($_POST['password'])){
            $password = md5($_POST['password']);
        }else {
            array_push($errors,'le  mot de passe ne pas etre vide');
        }
    }else {
        array_push($errors,'le mot de passe  ne pas etre vide');
    }


    // verification du tableau  d'erreur

    if(count($errors) == 0){
        
        // verifier si l'utilisateur existe
        $queryUserCheck = "SELECT id FROM utilisateur WHERE telephone='$numeroClient'";
        $resultUser = mysqli_query($db,$queryUserCheck);
        $user = array();

        if($resultUser){
            
            while($row = mysqli_fetch_assoc($resultUser)){
                $user[] = $row;
            }
            // die(var_dump($user[0]['id']));

            // verification du numero de l'agence
            $queryAgentCheck = "SELECT * FROM utilisateur WHERE telephone='$numeroAgent' AND password='$password'";
            $resultAgent = mysqli_query($db,$queryAgentCheck);
            $agence = array();
            
            if($resultAgent){
                
                while($row = mysqli_fetch_assoc($resultAgent)){
                    $agence[] = $row;
                }
                $emetteurId = $user[0]['id'];
                $recepteurId = $agence[0]['id'];
                // recuperation du solde
                $queryGetSolde = "SELECT montant FROM solde WHERE idUtilisateur='$emetteurId'";
                $resultGetSolde = mysqli_query($db,$queryGetSolde);
                $solde = array();
                
                if($resultGetSolde){
                    while($row = mysqli_fetch_assoc($resultGetSolde)){
                        $solde[] = $row;
                    }

                    $soldeTotal = $solde[0]['montant'] + $montant;

                    // mise a jour du solde
                    $queryUpdateSolde = "UPDATE solde SET montant='$soldeTotal'  WHERE idUtilisateur = '$emetteurId'";
                    $resultUpdateSolde = mysqli_query($db,$queryUpdateSolde);

                    // si la mise a jour du solde a ete bien effectue
                    if($resultUpdateSolde){
                        
                        $libelle = "Bonjour,votre  depot du montant de  ".$montant." par ".$agence[0]['telephone']." est effectué avec succes. Votre nouveau solde est ".$soldeTotal;
                        $typeTransaction = "depot";
                        $valider = true;

                        // sauvegarde de la transaction 
                        $queryTransaction = "INSERT INTO transaction (emetteurId,recepteurId,montant,libelle,typeTransaction,dateValidation,valider)
                        VALUES('$emetteurId','$recepteurId','$montant','$libelle','$typeTransaction','$datepost','$valider')";

                    
                        $resultTransaction = mysqli_query($db,$queryTransaction);
                        
                        if($resultTransaction){
                            echo(
                                json_encode(
                                    array(
                                        "code"=>1,
                                        "message"=>"Transaction effectue avec succes",
                                        "libelle"=> $libelle
                                    )
                                )
                            );
                        }
                    }
                }else {
                    echo(
                        json_encode(
                            array(
                                "code"=>0,
                                "message"=>"Transaction a échoué"
                            )
                        )
                    );
                }
               
            }else{
                echo(
                    json_encode(
                        array(
                            "code"=>0,
                            "message"=>"Numero de l'agence inconnu"
                        )
                    )
                );
            }


        }else {
            echo(
                json_encode(
                    array(
                        "code"=>0,
                        "message"=>"Numero du beneficiaire inconnu"
                    )
                )
            );
        }
        // verification si l'agent existe

        // recuperation du solde

        // mise a jour du solde

    }else {
        echo(
            json_encode(
                array(
                    "code"=>0,
                    "message"=>"Veuillez remplir correctement tout les champs du formulaire"
                )
            )
        );
    }