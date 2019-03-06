<?php
    include '../config/database.php';

    $id = 0;
    $email = '';
    $password = '';
    $idTransaction = 0;

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

    // validation de l'id
    if(isset($_POST['idTransaction'])){
        if(!empty($_POST['idTransaction'])){
            $idTransaction = $_POST['idTransaction'];
        }else {
            array_push($errors,'Votre idTransaction ne pas etre vide');
        }
    }else {
        array_push($errors,'Votre idTransaction ne pas etre vide');
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

     // validation pasword
     if(isset($_POST['password'])){
        if(!empty($_POST['password'])){
            $password = md5($_POST['password']);
        }else {
            array_push($errors,'le  mot de passe ne pas etre vide');
        }
    }else {
        array_push($errors,'le mot de passe  ne pas etre vide');
    }


    if(count($errors) == 0){
        $queryUser= "SELECT * FROM utilisateur where id='$id' AND email='$email' AND password='$password'";
        $resultatUser = mysqli_query($db,$queryUser);

        

        if($resultatUser){
            // recuperation du solde
            $querySolde= "SELECT * FROM solde where idUtilisateur='$id'";
            $resultatSolde = mysqli_query($db,$querySolde);
            $solde = array();

            while($row = mysqli_fetch_assoc($resultatSolde)){
                $solde[] = $row;
            }

            $valider = false;
            $queryGetTransaction = "SELECT * FROM transaction WHERE id='$idTransaction' AND valider='$valider' AND emetteurId='$id' AND typeTransaction='retrait'";
            $resultatGetTransaction = mysqli_query($db,$queryGetTransaction);
            $transaction = array();
            

           
            if(mysqli_num_rows($resultatGetTransaction) != 0){
                while($row = mysqli_fetch_assoc($resultatGetTransaction)){
                    $transaction[] = $row;
                }

                if($solde[0]['montant'] >= $transaction[0]['montant'] ){

                    $idSolde = $solde[0]['id'];
                    
                    $montant = $solde[0]['montant'] - $transaction[0]['montant'];

                    $queryUpdateSolde= "UPDATE solde SET montant='$montant', dateUpdate='$datepost'
                                        WHERE id='$idSolde'";
                    $resultatUpdateSolde = mysqli_query($db,$queryUpdateSolde);
                   

                    
                    if($resultatUpdateSolde){
                        $valider = true;
                        $queryTransaction = "UPDATE transaction SET valider='$valider', dateValidation='$datepost'
                        WHERE id='$idTransaction'";
                        $resultatTransaction = mysqli_query($db,$queryTransaction);
                        // die(mysqli_error($db));
                        if($resultatTransaction){
                            echo(
                                json_encode(
                                    array(
                                        "code"=>1,
                                        "message"=>"Transaction reussi"
                                    )
                                )
                            );
                        }else {
                            echo(
                                json_encode(
                                    array(
                                        "code"=>0,
                                        "message"=>"la transaction a echoue"
                                    )
                                )
                            );
                        }

                    }else {
                        echo(
                            json_encode(
                                array(
                                    "code"=>0,
                                    "message"=>"Echec de retrait"
                                )
                            )
                        );
                    }
                }else {
                    echo(
                        json_encode(
                            array(
                                "code"=>0,
                                "message"=>"Votre solde est insuffisant"
                            )
                        )
                    );
                }
                
            }else {
                echo(
                    json_encode(
                        array(
                            "code"=>0,
                            "message"=>"Transaction deja valide"
                        )
                    )
                );
            }


            
        }else {
            echo(
                json_encode(
                    array(
                        "code"=>0,
                        "message"=>"erreur de recuperation de vos validation"
                    )
                )
            );
        }
    }else {
        echo(
            json_encode(
                array(
                    "code"=>0,
                    "message"=>"echec de recuperation de vos validation"
                )
            )
        );
    }