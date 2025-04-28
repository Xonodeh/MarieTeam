<?php 
require_once 'db.php';
$pdo = connexionBDD();
$data = json_decode(file_get_contents("php://input"), true);

if (!empty($data)) {
    $nomClient = htmlspecialchars($data['nomClient'] ?? '');
    $adresseClient = htmlspecialchars($data['adresseClient'] ?? '');
    $cpClient = htmlspecialchars($data['cpClient'] ?? '');
    $villeClient = htmlspecialchars($data['villeClient'] ?? '');
    $idTraversee = intval($data['idTraversee']);
    $types = $data['types'] ?? [];

    try {
        $stmt = $pdo->prepare("SELECT IdUtilisateur FROM utilisateur WHERE NomUtilisateur = :nom");
        $stmt->execute([':nom' => $nomClient]);
        $utilisateur = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$utilisateur) {
            echo json_encode([
                'success' => false,
                'error' => 'Utilisateur non trouvé. Veuillez vous inscrire.',
                'redirect' => 'inscription.html'
            ]);
            exit;
        }
        $idUtilisateur = $utilisateur['IdUtilisateur'];

        // 1. Récupérer places restantes
        $stmt = $pdo->prepare("SELECT places_passagers, veh_inf_2m, veh_sup_2m FROM traversee WHERE IDTraversee = ?");
        $stmt->execute([$idTraversee]);
        $places = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$places) {
            echo json_encode(['success' => false, 'error' => 'Traversée inconnue.']);
            exit;
        }
        // Cumul à réserver
        $reserve = ['passager' => 0, 'veh_inf_2m' => 0, 'veh_sup_2m' => 0];

        // Pour chaque type réservé, détecter la catégorie et additionner
        foreach ($types as $idType => $quantite) {
            $stmtType = $pdo->prepare("SELECT IdCategorie FROM type WHERE IDType = ?");
            $stmtType->execute([$idType]);
            $cat = $stmtType->fetchColumn();
            if ($cat == 1) $reserve['passager'] += $quantite;
            else if ($cat == 2) $reserve['veh_inf_2m'] += $quantite;
            else if ($cat == 3) $reserve['veh_sup_2m'] += $quantite;
        }

        // 2. Vérifier disponibilité
        if ($reserve['passager'] > $places['places_passagers']) {
            echo json_encode(['success' => false, 'error' => "Pas assez de places passager !"]);
            exit;
        }
        if ($reserve['veh_inf_2m'] > $places['veh_inf_2m']) {
            echo json_encode(['success' => false, 'error' => "Pas assez de places véhicule <2m !"]);
            exit;
        }
        if ($reserve['veh_sup_2m'] > $places['veh_sup_2m']) {
            echo json_encode(['success' => false, 'error' => "Pas assez de places véhicule >2m !"]);
            exit;
        }

        // 3. Créer la réservation principale
        $stmt = $pdo->prepare("
            INSERT INTO reservation (NomClient, AdresseClient, CPClient, VilleClient, IdUtilisateur, IDTraversee)
            VALUES (:nom, :adresse, :cp, :ville, :idUtilisateur, :idTraversee)
        ");
        $stmt->execute([
            ':nom' => $nomClient,
            ':adresse' => $adresseClient,
            ':cp' => $cpClient,
            ':ville' => $villeClient,
            ':idUtilisateur' => $idUtilisateur,
            ':idTraversee' => $idTraversee,
        ]);
        $idReservation = $pdo->lastInsertId();

       
      // 4. Calculer le total passagers, véhicules <2m et >2m à enregistrer
$totalPassagers = 0;
$totalVehiculesInf2m = 0;
$totalVehiculesSup2m = 0;

foreach ($types as $idType => $quantite) {
    $stmtType = $pdo->prepare("SELECT IdCategorie FROM type WHERE IDType = ?");
    $stmtType->execute([$idType]);
    $cat = $stmtType->fetchColumn();

    if ($cat == 1) {
        $totalPassagers += intval($quantite);
    } else if ($cat == 2) {
        $totalVehiculesInf2m += intval($quantite);
    } else if ($cat == 3) {
        $totalVehiculesSup2m += intval($quantite);
    }
}

// 5. Insérer UNE SEULE LIGNE dans enregistrer pour la réservation
$stmtInsert = $pdo->prepare("
    INSERT INTO enregistrer (IDReservation, NbPassager, NbVehiculeInf2m, NbVehiculeSup2m)
    VALUES (?, ?, ?, ?)
");
$stmtInsert->execute([
    $idReservation,
    $totalPassagers,
    $totalVehiculesInf2m,
    $totalVehiculesSup2m
]);



        // 5. Décrémenter les places disponibles
        $stmt = $pdo->prepare("
            UPDATE traversee
            SET places_passagers = places_passagers - :nbPassager,
                veh_inf_2m = veh_inf_2m - :nbVehInf2m,
                veh_sup_2m = veh_sup_2m - :nbVehSup2m
            WHERE IDTraversee = :idTraversee
        ");
        $stmt->execute([
            ':nbPassager' => $reserve['passager'],
            ':nbVehInf2m' => $reserve['veh_inf_2m'],
            ':nbVehSup2m' => $reserve['veh_sup_2m'],
            ':idTraversee' => $idTraversee
        ]);

        echo json_encode(['success' => true]);
    } catch (PDOException $e) {
        echo json_encode(['success' => false, 'error' => 'Erreur SQL : ' . $e->getMessage()]);
    }
} else {
    echo json_encode(['success' => false, 'error' => 'Données invalides.']);
}
?>
