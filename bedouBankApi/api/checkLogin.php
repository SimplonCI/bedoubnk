<?php 
	

	$email = addslashes($_POST['email']);
	$iduser = addslashes($_POST['iduser']);
    $devisename = addslashes($_POST['devisename']);
    $deviseId = $_POST['deviseId'];

	// tableau contenant les erreurs 
	$errors = array();



    if (isset($_COOKIE['email'])) {

    	if($email != $_COOKIE['email']){
    		array_push($errors, 'email invalid');
    	}
    }else{
    	array_push($errors, 'email invalid');
    }

    if (isset($_COOKIE['iduser'])) {
    	
    	if($iduser != $_COOKIE['iduser']){
    		array_push($errors, 'iduser invalid');
    	}
    }else{
    	array_push($errors, 'iduser invalid');
    }

    if (isset($_COOKIE['devisename'])) {

    	if($devisename != $_COOKIE['devisename']){
    		array_push($errors, 'devisename invalid');
    	}else{

    	}
    }else{
    	array_push($errors, 'devisename invalid');
    }

    if (isset($_COOKIE['deviseId'])) {
    	

    	if(!(trim($deviseId) === trim($_COOKIE['deviseId']))){
    		array_push($errors, 'deviseId invalid');
    	}
    }else{
    	array_push($errors, 'deviseId invalid');
    }


	if (isset($_COOKIE['isbedou']) && $_COOKIE['isbedou']==true) {
		
	}else{
    	array_push($errors, 'isbedou invalid');
    }

   
    if (count($errors) == 0) {
    	
    	echo(
            json_encode(
                array(
                    "code"=>1,
                    "message"=>'isconnect',
                    
                )
            )
        );
    }else{
    	echo(
            json_encode(
                array(
                    "code"=>0,
                    "message"=>'noconnect'
                )
            )
        );
    }
?>