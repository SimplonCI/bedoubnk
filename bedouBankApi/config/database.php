<?php
    $servername = 'localhost';
    $username = 'root';
    $password = 'python92';
    $dbname = 'bedoubank';
    $datepost = date('Y-m-d');

    // connexion a la base de donnee
    $db = mysqli_connect($servername,$username,$password,$dbname);

    // verification de la connexion
    if(!$db){
        print('Fatal error');
        die('Fatal error : '.mysqli_connect_error());
    }
?>