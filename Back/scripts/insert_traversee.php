<?php
header('Content-Type: application/json');

require_once 'db.php';
$pdo = connexionBDD();

// Lecture du JSON
$input = json_decode(file_get_contents('php://input'), true);

// Vérifie que toutes les données sont présentes
if (!isset($input['date'], $input['heure'], $input['bateau'], $input['liaison'], 
          $input['places_passagers'], $input['veh_inf_2m'], $input['veh_sup_2m'])) {
    echo json_encode(['success' => false, 'error' => 'Données manquantes.']);
    exit;
}

$date = $input['date'];
$heure = $input['heure'];
$idBateau = (int)$input['bateau'];
$idLiaison = (int)$input['liaison'];
$placesPassagers = (int)$input['places_passagers'];
$vehInf2m = (int)$input['veh_inf_2m'];
$vehSup2m = (int)$input['veh_sup_2m'];

try {
    $stmt = $pdo->prepare("INSERT INTO traversee (DateTraversee, HeureTraversee, IDBateau, IDLiaison, places_passagers, veh_inf_2m, veh_sup_2m) 
                           VALUES (?, ?, ?, ?, ?, ?, ?)");
    $stmt->execute([$date, $heure, $idBateau, $idLiaison, $placesPassagers, $vehInf2m, $vehSup2m]);
    echo json_encode(['success' => true]);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
