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




define('err_login', "Le login est incorrect.");
define('err_pwd', "Le mot de passe doit contenir au minimum 12 caractères, une minuscule et une majuscule.");
define('err_carac', "Le nom d'utilisateur ne doit contenir que des lettres.");

$login = trim($_POST['txtLogin']);
$pwd = trim($_POST['txtPassword']);

const password = '/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{12,}$/';

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
   
    $dsn = 'mysql:dbname=marieteam;host=localhost';
    $user = 'marieteam' ;
    $password = 'NNL'; 
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




      
        $sql = "INSERT INTO utilisateur (IdUtilisateur,NomUtilisateur,LogUtilisateur,MdpUtilisateur) VALUES (:leNom ,:leLogin, :leMdp)";

        $stmt=$dbh->prepare($sql); 
        
        $bvc=$stmt ->bindValue(param: ':leLogin',value: $nom,type: PDO::PARAM_STR); 

        $bvc1=$stmt ->bindValue(param: ':leLogin',value: $login,type: PDO::PARAM_STR); 
    
        $bvc2=$stmt ->bindValue(':leMdp',value: $pwdhash,type: PDO::PARAM_STR);
    
        $executionOK = $stmt->execute(); 

        echo 'votre inscription a été prise en compte' ; 
       
    }


    catch (PDOException $e) {
        echo 'Connexion echouée'. $e->getMessage();
    }
}


?>