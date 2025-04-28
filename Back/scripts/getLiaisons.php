<?php
require 'db.php';
$pdo = connexionBDD();
header('Content-Type: application/json');

$secteur = $_GET['secteur'] ?? '';
$sql = "SELECT l.IDLiaison, 
               CONCAT(p1.LibPort, ' - ', p2.LibPort) AS description 
        FROM liaison l
        JOIN port p1 ON l.IDPort = p1.IDPort
        JOIN port p2 ON l.IDPort_1 = p2.IDPort
        WHERE l.IDSecteur = :secteur";
$stmt = $pdo->prepare($sql);
$stmt->execute([':secteur' => $secteur]);
echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
