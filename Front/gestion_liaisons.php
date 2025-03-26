<?php
session_start();
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: index.php'); 
    exit;
}
include '../Back/scripts/db.php';
$pdo = connexionBDD();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $distance = $_POST['distance'];
    $idPortDepart = $_POST['port_depart'];
    $idPortArrivee = $_POST['port_arrivee'];
    $idSecteur = $_POST['secteur'];

    $stmt = $pdo->prepare("INSERT INTO liaison (Distance, IDPort, IDPort_1, IDSecteur) VALUES (?, ?, ?, ?)");
    $stmt->execute([$distance, $idPortDepart, $idPortArrivee, $idSecteur]);

    echo "Nouvelle liaison ajoutée !";
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des Liaisons</title>
</head>
<body>
    <h1>Ajouter une nouvelle liaison</h1>
    <form method="POST">
        Distance: <input type="number" name="distance" required><br>
        Port de départ: <input type="number" name="port_depart" required><br>
        Port d'arrivée: <input type="number" name="port_arrivee" required><br>
        Secteur: <input type="number" name="secteur" required><br>
        <input type="submit" value="Ajouter">
    </form>
    <a href="admin.php">Retour</a>
</body>
</html>
