<?php
require_once 'db.php';
$pdo = connexionBDD();
$data = json_decode(file_get_contents("php://input"), true);

if (!empty($data)) {
    $nomClient = htmlspecialchars($data['nomClient']);
    $adresseClient = htmlspecialchars($data['adresseClient']);
    $cpClient = htmlspecialchars($data['cpClient']);
    $villeClient = htmlspecialchars($data['villeClient']);
    $idTraversee = intval($data['idTraversee']);

    try {
        $stmt = $pdo->prepare("
            SELECT IdUtilisateur 
            FROM utilisateur 
            WHERE NomUtilisateur = :nom
        ");
        $stmt->execute([':nom' => $nomClient]);
        $utilisateur = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($utilisateur) {
            $idUtilisateur = $utilisateur['IdUtilisateur'];

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

            echo json_encode(['success' => true]);
        } else {
            echo json_encode([
                'success' => false,
                'error' => 'Utilisateur non trouvé. Veuillez vous inscrire.',
                'redirect' => 'inscription.html'
            ]);
        }
    } catch (PDOException $e) {
        echo json_encode(['success' => false, 'error' => 'Erreur SQL : ' . $e->getMessage()]);
    }
} else {
    echo json_encode(['success' => false, 'error' => 'Données invalides.']);
}
?>
