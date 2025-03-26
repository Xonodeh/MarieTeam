<?php
session_start();
include 'db.php';


$login = trim($_POST['txtLogin']);
$pwd = trim($_POST['txtPassword']);

$pdo = connexionBDD();

if ($pdo) {
    // Vérification dans la table `utilisateur`
    $stmt = $pdo->prepare("SELECT * FROM utilisateur WHERE LogUtilisateur = :login");
    $stmt->bindParam(':login', $login);
    $stmt->execute();
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    // Vérification dans la table `gestionnaire`
    $stmt_admin = $pdo->prepare("SELECT * FROM gestionnaire WHERE LogGestionnaire = :login");
    $stmt_admin->bindParam(':login', $login);
    $stmt_admin->execute();
    $admin = $stmt_admin->fetch(PDO::FETCH_ASSOC);

    if ($user && password_verify($pwd, $user['MdpUtilisateur'])) {
        // Connexion utilisateur normal
        $_SESSION['utilisateur'] = $user['NomUtilisateur'];
        $_SESSION['role'] = 'utilisateur';
        header('Location: ../../Front/index.php');
        exit;
    } elseif ($admin && $pwd === $admin['MdpGestionnaire']) { 
        // Connexion gestionnaire (mot de passe en clair)
        $_SESSION['utilisateur'] = $admin['NomGestionnaire'];
        $_SESSION['role'] = 'admin';
        header('Location: ../../Front/admin.php'); // Redirection admin
        exit;
    } else {
        echo "Identifiants incorrects.";
    }
} else {
    echo "Erreur de connexion à la base de données.";
}
?>
