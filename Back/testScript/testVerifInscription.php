<?php

include_once '../scripts/db.php';         
include_once '../scripts/inscription.php';

$pdo = connexionBDD() ; 
$login = 'mkjg@gmail.com' ; 

var_dump(verifInscription($pdo,$login)) ; 