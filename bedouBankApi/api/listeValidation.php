<?php
    include '../config/database.php';

    $id = 0;
    $email = '';

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
            
            $queryTransaction = " SELECT * FROM transaction WHERE emetteurId='$id' AND typeTransaction='retrait' AND valider='false'";
            $resultatTransaction = mysqli_query($db,$queryTransaction);

            $validations = array();
            if($resultatTransaction){
                while($row = mysqli_fetch_assoc($resultatTransaction)){
                    $validations[] = $row;
                }

                echo(
                    json_encode(
                        array(
                            "code"=>0,
                            "historique"=>$validations
                        )
                    )
                );

            }else {
                echo(
                    json_encode(
                        array(
                            "code"=>0,
                            "message"=>"Aucune validation"
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