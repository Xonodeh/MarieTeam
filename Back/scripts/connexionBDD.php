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

<<<<<<< HEAD
    // Vérification pour l'utilisateur (comparaison avec le hachage de mot de passe)
    if ($user && password_verify($pwd, $user['MdpUtilisateur'])) {
=======
    if ($user && $pwd === $user['MdpUtilisateur']) {
>>>>>>> cdfa3f354c61f50fece964d7a5d82f94ac7c30fc
        // Connexion utilisateur normal
        $_SESSION['utilisateur'] = $user['NomUtilisateur'];
        $_SESSION['role'] = 'utilisateur';
        header('Location: ../../Front/index.php');
        exit;
    } 
    // Vérification pour l'administrateur (mot de passe en clair)
    elseif ($admin && $pwd === $admin['MdpGestionnaire']) {
        // Connexion gestionnaire (mot de passe en clair)
        $_SESSION['utilisateur'] = $admin['NomGestionnaire'];
        $_SESSION['role'] = 'admin';
        header('Location: ../../Front/admin.php'); // Redirection admin
        exit;
    } 
    else {
        echo "Identifiants incorrects.";
        var_dump($user['MdpUtilisateur']);
    }
} else {
    echo "Erreur de connexion à la base de données.";
}
?>
