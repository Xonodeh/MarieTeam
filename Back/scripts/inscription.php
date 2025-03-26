<?php
include_once 'db.php';

function inscription($pdo, $nomPrenom, $login, $mdpHash) {
    $sql = "INSERT INTO utilisateur (NomUtilisateur, LogUtilisateur, MdpUtilisateur) VALUES (:leNom, :leLogin, :leMdp)";
    $stmt = $pdo->prepare($sql);

    $stmt->bindValue(':leNom', $nomPrenom, PDO::PARAM_STR);
    $stmt->bindValue(':leLogin', $login, PDO::PARAM_STR);
    $stmt->bindValue(':leMdp', $mdpHash, PDO::PARAM_STR);

    return $stmt->execute();
}

function verifInscription($pdo, $login) {
    $sql = "SELECT COUNT(*) FROM utilisateur WHERE LogUtilisateur = :leLogin";
    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(':leLogin', $login, PDO::PARAM_STR);
    $stmt->execute();

    return $stmt->fetchColumn();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Vérification des données POST
    if(isset($_POST['nom'], $_POST['prenom'], $_POST['email'], $_POST['mdp'])){

        $nom = trim($_POST['nom']);
        $prenom = trim($_POST['prenom']);
        $login = trim($_POST['email']);
        $mdp = trim($_POST['mdp']);
        $nomPrenom = $nom . ' ' . $prenom;

        $mdpHash = password_hash($mdp, PASSWORD_DEFAULT);

        $pdo = connexionBDD();

        if ($pdo) {

            if(verifInscription($pdo, $login) == 0) {
                $resultat = inscription($pdo, $nomPrenom, $login, $mdpHash);

                if ($resultat) {
                    session_start();
                    $_SESSION['utilisateur'] = $nomPrenom;
                    header('Location: ../../Front/index.php');
                    exit;
                } else {
                    echo "Erreur lors de l'inscription.";
                    exit;
                }

            } else {
                echo "Cet email est déjà utilisé.";
                exit;
            }

        } else {
            echo "Impossible de se connecter à la base de données.";
            exit;
        }

    } else {
        echo "Veuillez remplir tous les champs du formulaire.";
        exit;
    }
}
?>
