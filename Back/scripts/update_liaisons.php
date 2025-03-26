<?php
header('Content-Type: application/json');
require_once 'db.php';
$pdo = connexionBDD();

$data = json_decode(file_get_contents("php://input"), true);

if (!$pdo) {
    echo json_encode(['success' => false, 'error' => 'Connexion BDD échouée']);
    exit;
}

if (!isset($data['id'], $data['dist'], $data['depart'], $data['arrivee'], $data['secteur'])) {
    echo json_encode(['success' => false, 'error' => 'Données incomplètes']);
    exit;
}

try {
    $stmt = $pdo->prepare("UPDATE liaison SET Distance = ?, IDPort = ?, IDPort_1 = ?, IDSecteur = ? WHERE IDLiaison = ?");
    $success = $stmt->execute([
        $data['dist'],
        $data['depart'],
        $data['arrivee'],
        $data['secteur'],
        $data['id']
    ]);

    echo json_encode(['success' => $success]);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
