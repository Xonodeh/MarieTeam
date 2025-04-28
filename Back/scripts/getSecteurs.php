<?php
require_once 'db.php';
$pdo = connexionBDD() ;
header('Content-Type: application/json');

$res = $pdo->query("SELECT * FROM secteur");
echo json_encode($res->fetchAll(PDO::FETCH_ASSOC));
