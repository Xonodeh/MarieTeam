<?php
session_start();
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: index.php'); 
    exit;
}
include '../Back/scripts/db.php';
$pdo = connexionBDD();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $date = $_POST['date'];
    $heure = $_POST['heure'];
    $idBateau = $_POST['bateau'];
    $idLiaison = $_POST['liaison'];

    $stmt = $pdo->prepare("INSERT INTO traversee (DateTraversee, HeureTraversee, IDBateau, IDLiaison) VALUES (?, ?, ?, ?)");
    $stmt->execute([$date, $heure, $idBateau, $idLiaison]);

    echo "Nouvelle traversée ajoutée !";
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des Traversées</title>
</head>
<body>
    <h1>Ajouter une nouvelle traversée</h1>
    <form method="POST">
        Date: <input type="date" name="date" required><br>
        Heure: <input type="time" name="heure" required><br>
        Bateau ID: <input type="number" name="bateau" required><br>
        Liaison ID: <input type="number" name="liaison" required><br>
        <input type="submit" value="Ajouter">
    </form>
    <a href="admin.php">Retour</a>
</body>
</html>
