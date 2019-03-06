<?php
    include '../config/database.php';

    $nom = '';
    $prenom = '';
    $password = '';
    $email = '';
    $telephone = '';
    $deviseId = '';
    $deviseName = '';
 
    if(isset($_POST['deviseId'])){
        $deviseId = $_POST['deviseId'];
    }
    if (isset($_POST['deviseName'])) {
        $deviseName = $_POST['deviseName'];
    }
    
    

    // tableau contenant les erreurs
    $errors = array();


    // validation du nom
    if (isset($_POST['nom'])) {
        if(!empty($_POST['nom'])){
            $nom = addslashes($_POST['nom']);
        }else {
            array_push($errors,"Le nom ne peut pas etre vide");
        }
    }else {
        array_push($errors,"Le nom est obligatoire");
    }

    // validation du prenom
    if (isset($_POST['prenom'])) {
        if(!empty($_POST['prenom'])){
            $prenom = addslashes($_POST['prenom']);
        }else {
            array_push($errors,"Le prenom ne peut pas etre vide");
        }
    }else {
        array_push($errors,"Le prenom est obligatoire");
    }


    // validation de l'adresse  email
    if (isset($_POST['email'])) {
        if(!empty($_POST['email'])){
            $email = addslashes($_POST['email']);
        }else {
            array_push($errors,"Le email ne peut pas etre vide");
        }
    }else {
        array_push($errors,"Le email est obligatoire");
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


    // validation du telephone
    if (isset($_POST['telephone'])) {
        if(!empty($_POST['telephone'])){
            $telephone = addslashes($_POST['telephone']);
        }else {
            array_push($errors,"Le telephone ne peut pas etre vide");
        }
    }else {
        array_push($errors,"Le telephone est obligatoire");
    }


    // verification du tableau des erreurs
    if(count($errors) == 0){
        
        // verifier si l'email de l'utilisateur existe
        $queryCheckEmail = "SELECT * FROM utilisateur WHERE email='$email'";
        // execution de la requete
        $resultatCheckEmail = mysqli_query($db,$queryCheckEmail);
        $rowCheckEmail = mysqli_num_rows($resultatCheckEmail);

        if($rowCheckEmail !=0 ){
            array_push($errors,"Adresse email deja utilise");
        }
        

         // verifier si le telephone de l'utilisateur existe
         $queryCheckTelephone = "SELECT * FROM utilisateur WHERE telephone='$telephone'";
         // execution de la requete
         $resultatCheckTelephone = mysqli_query($db,$queryCheckTelephone);
         $rowCheckTelephone = mysqli_num_rows($resultatCheckTelephone);
 
         if($rowCheckTelephone !=0 ){
            
             array_push($errors,"Le téléphone deja utilise");
           
         }

        
        //  verification et insertion de l'utilisateur
       
        if(count($errors) == 0){
            
            $query = "INSERT INTO utilisateur (nom,prenom,email,password,telephone)
            VALUES('$nom','$prenom','$email','$password','$telephone')";

            $resultat = mysqli_query($db,$query);
           
           
           
            if($resultat){
               
                echo(
                    json_encode(
                        array(
                            "code"=>1,
                            "message"=>"Inscription reussie"
                        )
                    )
                );
                
                
                
                $getUser = mysqli_query($db,"SELECT id FROM utilisateur WHERE email='$email'");
                // $iduser = 0;
                while($row = mysqli_fetch_assoc($getUser)){
                    $iduser = $row['id'];
                    $queryDevise = "INSERT INTO telephoneInfo (idutilisateur,devisename,deviseId)
                        VALUES('$iduser','$deviseName','$deviseId')";
                    mysqli_query($db,$queryDevise);

                    // initialisation du montant
                    $montant = 0;
                    $querySolde = "INSERT INTO solde(idutilisateur,montant,dateUpdate)
                        VALUES('$iduser','$montant','$datepost')";
                    mysqli_query($db,$querySolde);
                }
            }else {
                
                echo(
                    json_encode(
                        array(
                            "code"=>0,
                            "message"=>"Echec d'inscription, veuillez reessayer"
                        )
                    )
                 );
            }
        }else{
            echo(
                json_encode(
                    array(
                        "code"=>0,
                        "errors"=>$errors
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