<?php
function connexionBDD()
{
$bdd = 'mysql:dbname=mariteam;host=localhost';
$user ='leo';
$password = 'leo';

try {
    $ObjConnexion=new PDO($bdd,$user,$password) ; 
    echo 'vous êtes connecté à la base de données' ;   
}
 catch (PDOException $e)
 {
     echo $e->getMessage();
 }
}