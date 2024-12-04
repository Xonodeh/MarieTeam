<?php

function connexionBDD()
{
$bdd = 'mysql:dbname=mariteam;host=localhost';
$user ='mariteam';
$password = 'mariteam';

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