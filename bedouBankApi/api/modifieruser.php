<?php
include '../config/database.php';

    if(isset($_POST['id'])){ 
        $id = $_POST['id'];
        $nom = addslashes($_POST['nom']);
        $prenom = addslashes($_POST['prenom']);
        $dateNaissance = addslashes($_POST['dateNaissance']);
        $sexe = addslashes($_POST['sexe']);
        $email = addslashes($_POST['email']);
        $telephone = addslashes($_POST['telephone']);
        $passwordcurrent = $_POST['password'];
       
        if(empty($passwordcurrent)){
            $updateUtilisateur = "UPDATE utilisateur SET nom = '$nom',prenom = '$prenom',dateNaissance = '$dateNaissance',sexe ='$sexe',
            email = '$email', telephone = '$telephone' WHERE id = '$id' ";
        }else{
            $passwordcurrent = md5($_POST['password']);
            $updateUtilisateur = "UPDATE utilisateur SET nom = '$nom',prenom = '$prenom',dateNaissance = '$dateNaissance',sexe ='$sexe',
            password ='$passwordcurrent',email = '$email', telephone = '$telephone' WHERE id = '$id' ";
        }

       
        $resultatUpdate = mysqli_query($db,$updateUtilisateur);

       
        if($resultatUpdate){
    
            echo(
                json_encode(
                    array(
                        "code"=>1,
                        "message"=>'Mise a jour avec success'
                    )
                )
            );
    
        }else{
            echo(
                json_encode(
                    array(
                        "code"=>0,
                        "message"=>"Echec de mise a jour"
                    )
                )
            );
        }
        
    }


?>