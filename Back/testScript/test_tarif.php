<?php
require_once '../scripts/db.php' ; 

header('Content-Type: application/json');

$pdo = connexionBDD();

$stmt = $pdo->prepare("
    SELECT t.TypePassager, t.TypeVehicule, tarif.Prix
    FROM type t
    JOIN tarif ON tarif.IDType = t.IDType
    WHERE tarif.IDPeriode = 1
");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
