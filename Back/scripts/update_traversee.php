<?php
require_once 'db.php';
$pdo = connexionBDD();
$data = json_decode(file_get_contents('php://input'), true);

if ($pdo && !empty($data)) {
    $id = $data['id'];
    $date = $data['date'];
    $heure = $data['heure'];
    $bateau = $data['bateau'];
    $liaison = $data['liaison'];

    $stmt = $pdo->prepare("UPDATE traversee SET DateTraversee = ?, HeureTraversee = ?, IDBateau = ?, IDLiaison = ? WHERE IDTraversee = ?");
    $success = $stmt->execute([$date, $heure, $bateau, $liaison, $id]);

    echo json_encode(['success' => $success]);
} else {
    echo json_encode(['success' => false, 'error' => 'Requête invalide.']);
}
?>
