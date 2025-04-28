<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
require_once 'db.php';
header('Content-Type: application/json');

$pdo = connexionBDD();

if (!isset($_GET['idTraversee'])) {
    echo json_encode(['error' => 'idTraversee manquant']);
    exit;
}

$idTraversee = intval($_GET['idTraversee']);

// 1. Récupérer la liaison ET la date de la traversée
$stmt = $pdo->prepare("SELECT IDLiaison, DateTraversee FROM traversee WHERE IDTraversee = ?");
$stmt->execute([$idTraversee]);
$traversee = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$traversee) {
    echo json_encode(['error' => 'Traversée inconnue (IDTraversee inexistant)']);
    exit;
}
$idLiaison = $traversee['IDLiaison'];
$dateTraversee = $traversee['DateTraversee'];

// 2. Trouver la période de cette date
$stmt = $pdo->prepare("SELECT IDPeriode FROM periode WHERE ? BETWEEN DateDebutPeriode AND DateFinPeriode LIMIT 1");
$stmt->execute([$dateTraversee]);
$periode = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$periode) {
    echo json_encode(['error' => "Aucune période trouvée pour la date : $dateTraversee"]);
    exit;
}
$idPeriode = $periode['IDPeriode'];

// 3. Récupérer tous les types existants (passagers et véhicules)
$stmt = $pdo->query("SELECT IDType, LibelleType FROM type");
$types = $stmt->fetchAll(PDO::FETCH_ASSOC);

$result = [];
foreach ($types as $type) {
    $stmtTarif = $pdo->prepare("
        SELECT Prix 
        FROM tarif 
        WHERE IDLiaison = ? AND IDPeriode = ? AND IDType = ?
        LIMIT 1
    ");
    $stmtTarif->execute([$idLiaison, $idPeriode, $type['IDType']]);
    $tarif = $stmtTarif->fetch(PDO::FETCH_ASSOC);
    if ($tarif) {
        $result[] = [
            'IDType' => $type['IDType'],
            'LibelleType' => $type['LibelleType'],
            'Prix' => $tarif['Prix']
        ];
    }
}

if (empty($result)) {
    echo json_encode(['error' => 'Aucun tarif trouvé pour cette traversée']);
    exit;
}

echo json_encode($result);
