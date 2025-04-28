<?php
include "db.php";

$pdo = connexionBDD();

session_start();
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: ../../index.php');
    exit;
}
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $distance = $_POST['distance'];
    $depart = $_POST['depart'];
    $arrivee = $_POST['arrivee'];
    $secteur = $_POST['secteur'];

    $stmt = $pdo->prepare("INSERT INTO liaison (Distance, IDPort, IDPort_1, IDSecteur) VALUES (?, ?, ?, ?)");
    $stmt->execute([$distance, $depart, $arrivee, $secteur]);
    header("Location: ../../Front/gestion_liaisons.php");

    exit;
}
?>
