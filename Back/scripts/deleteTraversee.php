<?php

require 'db.php';
$pdo = connexionBDD();
header('Content-Type: application/json');

$input = json_decode(file_get_contents('php://input'), true);

if (!isset($input['id'])) {
    echo json_encode(['success' => false, 'error' => 'ID manquant.']);
    exit;
}

$id = $input['id'];

try {
    $stmt = $pdo->prepare("DELETE FROM traversee WHERE IDTraversee = ?");
    $stmt->execute([$id]);
    echo json_encode(['success' => true]);
} catch (Exception $e) {
    echo json_encode(['success' => false, 'error' => "impossible de supprimer la traversee, elle est déjà liée a une réservation" .  $e->getMessage()]);
}
