<?php
require_once 'db.php';
$pdo = connexionBDD();

if (isset($_GET['idTraversee'])) {
    $idTraversee = intval($_GET['idTraversee']);

    $stmt = $pdo->prepare("
        SELECT t.TypePassager, t.TypeVehicule, tarif.Prix, e.NbPassager, e.NbVehicule
        FROM type t
        JOIN tarif ON tarif.IDType = t.IDType
        LEFT JOIN enregistrer e ON e.IDType = t.IDType
        LEFT JOIN reservation r ON r.IDReservation = e.IDReservation
        WHERE r.IDTraversee = :idTraversee
    ");
    $stmt->execute([':idTraversee' => $idTraversee]);
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($result);
} else {
    echo json_encode(['error' => 'idTraversee manquant']);
}
?>
