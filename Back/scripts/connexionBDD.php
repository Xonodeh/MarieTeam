<?php
session_start(); //Création de la session utilisateur
include 'db.php';


define('err_login', "Le login est incorrect.");
define('err_pwd', "Le mot de passe doit contenir au minimum 12 caractères, une minuscule et une majuscule.");
define('err_carac', "Le nom d'utilisateur ne doit contenir que des lettres.");

$login = trim($_POST['txtLogin']);
$nom = trim($_POST['nom']) ;
$prenom = trim($_POST['prenom']) ;
$pwd = trim($_POST['txtPassword']);
$prenomNom = $nom.' '.$prenom ;

//const password = '/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{12,}$/';

function verifLogin($login) {
    return !empty($login) && preg_match('/^[a-zA-Z]+$/', $login);
}

// Inscription dans la base de donnée 

function verifMdp($pwd) {
    return preg_match(password, $pwd);
}



if (!verifLogin($login)) {
    echo err_login ;
} else if (!verifMdp($pwd)) {
    echo err_pwd ;
}
else {
   
    $dsn = 'mysql:dbname=mariteam;host=localhost';
    $user = 'leo' ;
    $password = 'leo'; 
    $pwdhash = password_hash($pwd,PASSWORD_DEFAULT) ;

    try {
        $dbh = new PDO($dsn,$user,$password); 

        // Vérifier si le login existe déjà dans la base de données
$stmt = $dbh->prepare("SELECT * FROM utilisateur WHERE LogUtilisateur = :login");
$stmt->bindParam(':login', $login);
$stmt->execute();
$result = $stmt->fetch();

if ($result) {
    echo "Le login existe déjà dans la base de données.";
    return;
}
     
        $sql = "INSERT INTO utilisateur (NomUtilisateur, LogUtilisateur, MdpUtilisateur) VALUES (:leNom, :leLogin, :leMdp)";

        $stmt = $dbh->prepare($sql);

// Bind les valeurs correctement sans le mot-clé 'param'
        
        $bvc = $stmt->bindValue(':leNom',$prenomNom, PDO::PARAM_STR);
        $bvc1 = $stmt->bindValue(':leLogin', $login, PDO::PARAM_STR); 
        $bvc2 = $stmt->bindValue(':leMdp', $pwdhash, PDO::PARAM_STR);

// Exécution de la requête
        $executionOK = $stmt->execute(); 

if ($executionOK) {
    echo 'Votre inscription a été prise en compte';
} else {
    echo 'Erreur lors de l\'inscription';
}
    }
    catch (PDOException $e) {
        echo 'Connexion echouée'. $e->getMessage();
    }
}

// noreddingue



?>