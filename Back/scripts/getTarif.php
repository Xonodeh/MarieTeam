<?php
require_once 'db.php';
$pdo = connexionBDD();
header('Content-Type: application/json');

if (isset($_GET['idTraversee'])) {
    $idTraversee = intval($_GET['idTraversee']);

    // Récupérer la période correspondant à la date de traversée
    $stmt = $pdo->prepare("
        SELECT p.IDPeriode
        FROM periode p
        JOIN traversee t ON t.DateTraversee BETWEEN p.DateDebutPeriode AND p.DateFinPeriode
        WHERE t.IDTraversee = :id
    ");
    $stmt->execute(['id' => $idTraversee]);
    $periode = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($periode) {
        // Récupérer les tarifs liés à cette période
        $stmt = $pdo->prepare("
            SELECT t.TypePassager, t.TypeVehicule, tarif.Prix
            FROM type t
            JOIN tarif ON tarif.IDType = t.IDType
            WHERE tarif.IDPeriode = :idPeriode
        ");
        $stmt->execute(['idPeriode' => $periode['IDPeriode']]);
        $tarifs = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($tarifs);
    } else {
        echo json_encode(['error' => 'Aucune période trouvée pour cette traversée']);
    }
} else {
    echo json_encode(['error' => 'idTraversee manquant']);
}
