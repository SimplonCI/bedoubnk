<?php
    include '../config/database.php';
    $id = 0;
    $email = '';
    $montant = 0;
    $numeroEmetteur = '0';
    $numeroRecepteur = '0';
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

    // validation du numeroEmetteur
    if(isset($_POST['numeroEmetteur'])){
        if(!empty($_POST['numeroEmetteur'])){
            $numeroEmetteur = $_POST['numeroEmetteur'];
        }else {
            array_push($errors,'Votre numeroEmetteur ne pas etre vide');
        }
    }else {
        array_push($errors,'Votre numeroEmetteur ne pas etre vide');
    }

    // validation du numeroRecepteur
    if(isset($_POST['numeroRecepteur'])){
        if(!empty($_POST['numeroRecepteur'])){
            $numeroRecepteur = $_POST['numeroRecepteur'];
        }else {
            array_push($errors,'le  numero de recepeteur ne pas etre vide');
        }
    }else {
        array_push($errors,'Votre numero de recepteur ne pas etre vide');
    }

     // validation du password
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
        
        // verifier si l'utilisateur Recepteur existe
        $queryRecepteurCheck = "SELECT * FROM utilisateur WHERE telephone='$numeroRecepteur'";
        $resultRecepteur = mysqli_query($db,$queryRecepteurCheck);
        $recepteur= array();

        if(mysqli_num_rows($resultRecepteur) != 0){
            $recepteurTel = '';
            while($row = mysqli_fetch_assoc($resultRecepteur)){
                $recepteur[] = $row;
                $recepteurTel = $row['telephone'];
            }
            // die(var_dump($user[0]['id']));

            // verification du numero du Emetteur
            $queryEmetteurCheck = "SELECT * FROM utilisateur WHERE telephone='$numeroEmetteur' AND password='$password'";
            $resultEmetteur = mysqli_query($db,$queryEmetteurCheck);
            $emetteur = array();
            
            if(mysqli_num_rows($resultEmetteur) != 0){
                
                while($row = mysqli_fetch_assoc($resultEmetteur)){
                    $emetteur[] = $row;
                }
                $recepteurId = $recepteur[0]['id'];
                $emetteurId = $emetteur[0]['id'];
                 

                // recuperation du solde emetteur
                $queryGetSoldeEmetteur = "SELECT montant FROM solde WHERE idUtilisateur='$emetteurId'";
                $resultGetSoldeEmetteur = mysqli_query($db,$queryGetSoldeEmetteur);
                $soldeEmetteur = array();

                // recuperation du solde recepteur
                $queryGetSoldeRecepteur = "SELECT montant FROM solde WHERE idUtilisateur='$recepteurId'";
                $resultGetSoldeRecepteur = mysqli_query($db,$queryGetSoldeRecepteur);
                $soldeRecepteur= array();
                
                if(mysqli_num_rows($resultGetSoldeEmetteur) != 0){
                    while($row = mysqli_fetch_assoc($resultGetSoldeEmetteur)){
                        $soldeEmetteur[] = $row;
                    }
                    while($row = mysqli_fetch_assoc($resultGetSoldeRecepteur)){
                        $soldeRecepteur[] = $row;
                    }

                    // comparaison du solde

                    if($soldeEmetteur[0]['montant'] >=  $montant){
                        $soldeTotalEmetteur = $soldeEmetteur[0]['montant'] - $montant;
                        $soldeTotalRecepteur = $soldeRecepteur[0]['montant'] + $montant;

                        // mise a jour du solde Emetteur
                        $queryUpdateSoldeEmetteur = "UPDATE solde SET montant='$soldeTotalEmetteur'  WHERE idUtilisateur = '$emetteurId'";
                        $resultUpdateSoldeEmetteur = mysqli_query($db,$queryUpdateSoldeEmetteur);

                        // mise a jour du solde recepteur
                        $queryUpdateSoldeRecepteur = "UPDATE solde SET montant='$soldeTotalRecepteur'  WHERE idUtilisateur = '$recepteurId'";
                        $resultUpdateSoldeRecepteur = mysqli_query($db,$queryUpdateSoldeRecepteur);

                        // si la mise a jour du solde a ete bien effectue
                        if($resultUpdateSoldeEmetteur){
                            
                            $libelle = "Bonjour,votre  transfert du montant de  ".$montant." vers ".$recepteurTel." est effectué avec succes. Votre nouveau solde est ".$soldeTotalEmetteur;
                            $typeTransaction = "transfert";
                            $valider = true;

                            // sauvegarde de la transaction 
                            $queryTransaction = "INSERT INTO transaction (emetteurId,recepteurId,montant,libelle,typeTransaction,dateValidation,valider)
                            VALUES('$emetteurId','$recepteurId','$montant','$libelle','$typeTransaction','$datepost','$valider')";

                        
                            $resultTransaction = mysqli_query($db,$queryTransaction);
                            

                            if($resultTransaction){
                                $message = "Transfert de ".$montant." vers ".$numeroRecepteur." a ete effectue avec success . Votre nouveau solde est ".$soldeTotalEmetteur;
                                echo(
                                    json_encode(
                                        array(
                                            "code"=>1,
                                            "message"=> $message,
                                           
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
                                    "message"=>"Solde insuffisant"
                                )
                            )
                        );
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
                            "message"=>"Mot de passe incorrect"
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
        // verification si l'Recepteur existe

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