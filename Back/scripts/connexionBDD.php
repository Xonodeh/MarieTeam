<?php

function connexionBDD()
{
$bdd = 'mysql:dbname=marieteam;host=localhost';
$user ='marieteam';
$password = 'NNL';

try {
   
    $ObjConnexion=new PDO($bdd,$user,$password) ; 
    //echo 'vous êtes connecté à la base de données' ; 
           
}
 catch (PDOException $e)
 {
     echo $e->getMessage();
 }
return $ObjConnexion;
}

function deconnexionBDD($cnx)
{
    $cnx=null;
}


?>