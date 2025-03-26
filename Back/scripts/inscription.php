<?php

include_once 'db.php' ;

$login = trim($_POST['email']);
$mdp = trim($_POST['mdp']);
$nom = trim($_POST['nom']);
$prenom = trim($_POST['prenom']);
$nomPrenom = $nom.' '.$prenom  ; 
$mdpHash = password_hash($mdp, PASSWORD_DEFAULT);

        
function inscription ($pdo,$nomPrenom,$login,$mdpHash){

        $sql = "INSERT INTO utilisateur (NomUtilisateur, LogUtilisateur, MdpUtilisateur) VALUES (:leNom, :leLogin, :leMdp)";
        $stmt = $pdo->prepare($sql);

// Bind les valeurs 
        $bvc = $stmt->bindValue(':leNom',$nomPrenom, PDO::PARAM_STR);
        $bvc1 = $stmt->bindValue(':leLogin', $login, PDO::PARAM_STR); 
        $bvc2 = $stmt->bindValue(':leMdp', $mdpHash, PDO::PARAM_STR);

// Exécution de la requête
        $executionOK = $stmt->execute(); 

        return $executionOK ;

        
}

function verifInscription($pdo,$login) {

        $sql = "SELECT COUNT(*) FROM utilisateur WHERE LogUtilisateur = :leLogin";
        $stmt = $pdo->prepare($sql);
        
        $stmt->bindParam(':leLogin', $login, PDO::PARAM_STR);
        $stmt->execute();
    
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        
        return $result;

}

// Envoie des données via le formulaire

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // Récupérer les données du formulaire
        $nom = $_POST['nom'];
        $prenom = $_POST['prenom'];
        $login = $_POST['email'];
        $mdp = $_POST['mdp'];
        $nomPrenom = $nom . ' ' . $prenom;
    
        // Connexion à la base de données
        $pdo = connexionBDD();
    
        // Appel de la fonction d'inscription
        $resultat = inscription($pdo, $nomPrenom, $login, $mdpHash);
        
        // Vérification du résultat
        if ($resultat === true) {
                // Redirection vers l'accueil si réussite
                session_start();
                $_SESSION['utilisateur'] = $nomPrenom;
                header('Location: ../../Front/index.php');
                exit;
            } else {
                // Redirection vers la page d'inscription si échec
                header('Location: ../../Front/inscription.html');
                exit;
        }
}        
?>

