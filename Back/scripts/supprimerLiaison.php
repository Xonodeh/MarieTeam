<?php
require_once 'db.php';
$pdo = connexionBDD();

$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['id'])) {
    $id = $data['id'];

    $stmt = $pdo->prepare("DELETE FROM liaison WHERE IDLiaison = ?");
    if ($stmt->execute([$id])) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'error' => 'Échec de la suppression']);
    }
} else {
    echo json_encode(['success' => false, 'error' => 'ID manquant']);
}
