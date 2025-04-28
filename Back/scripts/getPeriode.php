<?php
require_once 'db.php';
$pdo = connexionBDD();
header('Content-Type: application/json');

if (isset($_GET['idTraversee'])) {
    $idTraversee = intval($_GET['idTraversee']);
    $stmt = $pdo->prepare("
        SELECT p.IDPeriode
        FROM periode p
        JOIN traversee t ON t.DateTraversee BETWEEN p.DateDebutPeriode AND p.DateFinPeriode
        WHERE t.IDTraversee = :id
    ");
    $stmt->execute(['id' => $idTraversee]);
    $periode = $stmt->fetch(PDO::FETCH_ASSOC);
    echo json_encode($periode ?: []);
} else {
    echo json_encode(['error' => 'Paramètre idTraversee manquant']);
}
