<?php

function connexionBDD()
{
$bdd = 'mysql:dbname=MariTeam;host=localhost';
$user ='MariTeam';
$password = 'uOoVUvBCzGjSCsz';

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
    $cnx=null; //lol
}


?>