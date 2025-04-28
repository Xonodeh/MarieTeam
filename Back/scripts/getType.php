<?php
require_once 'db.php';
$pdo = connexionBDD();
header('Content-Type: application/json');

// On récupère tous les types
$stmt = $pdo->query("SELECT IDType, LibelleType FROM type");
echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
