<?php
session_start();
include 'db.php';

$login = trim($_POST['txtLogin']);
$pwd   = trim($_POST['txtPassword']);
$pdo   = connexionBDD();

if ($pdo) {
    // 1) Recherche dans utilisateur
    $stmt = $pdo->prepare("SELECT * FROM utilisateur WHERE LogUtilisateur = :login");
    $stmt->execute(['login' => $login]);
    $user  = $stmt->fetch(PDO::FETCH_ASSOC);

    // 2) Recherche dans gestionnaire
    $stmt = $pdo->prepare("SELECT * FROM gestionnaire WHERE LogGestionnaire = :login");
    $stmt->execute(['login' => $login]);
    $admin = $stmt->fetch(PDO::FETCH_ASSOC);

    // 3) Si utilisateur normal
    if ($user && password_verify($pwd, $user['MdpUtilisateur'])) {
        session_regenerate_id(true);               // 👈 Empêche fixation de session
        $_SESSION['login'] = $user['LogUtilisateur'];
        $_SESSION['role']  = 'utilisateur';
        header('Location: ../../Front/index.php');
        exit;
    }
    // 4) Si gestionnaire (mot de passe stocké en clair)
    elseif ($admin && hash_equals($admin['MdpGestionnaire'], $pwd)) {
        session_regenerate_id(true);
        $_SESSION['login'] = $admin['LogGestionnaire'];
        $_SESSION['role']  = 'admin';
        header('Location: ../../Front/admin.php');
        exit;
    }

    // 5) Échec
    echo "Identifiants incorrects."; 
    exit;
} else {
    echo "Erreur de connexion à la BDD.";
    exit;
}
