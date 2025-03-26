<?php
session_start();
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: index.php'); // Redirection si non admin
    exit;
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Gestion des liaisons et traversées</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Bienvenue, <?php echo $_SESSION['utilisateur']; ?> (Gestionnaire)</h1>
    <p>Ici, vous pouvez gérer les liaisons et traversées.</p>

    <h2>Gestion des Liaisons</h2>
    <a href="gestion_liaisons.php">Gérer les liaisons</a>

    <h2>Gestion des Traversées</h2>
    <a href="gestion_traversees.php">Gérer les traversées</a>

    <br><br>
    <a href="../Back/scripts/deconnexion.php">Déconnexion</a>
</body>
</html>
