<?php
// fonction de calcul du total
function calculerTarifTotal($pdo, $idTraversee, $panier) {
    // $panier = tableau associatif [{idType, quantite}, ...]
    $stmt = $pdo->prepare("
        SELECT t.IDLiaison, tr.IDPeriode
        FROM traversee tr
        JOIN liaison t ON tr.IDLiaison = t.IDLiaison
        WHERE tr.IDTraversee = :idTraversee
    ");
    $stmt->execute(['idTraversee' => $idTraversee]);
    $info = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$info) return false;

    $idLiaison = $info['IDLiaison'];
    $idPeriode = $info['IDPeriode'];
    $total = 0;
    $details = [];

    foreach ($panier as $ligne) {
        $idType = intval($ligne['idType']);
        $quantite = intval($ligne['quantite']);
        $stmt2 = $pdo->prepare("SELECT Prix FROM tarif WHERE IDType = :idType AND IDPeriode = :idPeriode AND IDLiaison = :idLiaison");
        $stmt2->execute([
            'idType' => $idType,
            'idPeriode' => $idPeriode,
            'idLiaison' => $idLiaison
        ]);
        $prix = $stmt2->fetchColumn();
        if ($prix === false) $prix = 0;
        $total += $prix * $quantite;
        $details[] = [
            'idType' => $idType,
            'quantite' => $quantite,
            'prix_unitaire' => $prix,
            'sous_total' => $prix * $quantite
        ];
    }
    return ['total' => $total, 'details' => $details];
}

?>
