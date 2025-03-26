<?php
// db.php

function connexionBDD() {
    $host = 'localhost';
    $dbname = 'mariteam';
    $username = 'root';
    $password = '';

    try {
        $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        echo "vous êtes connecté à la base de données<br>";
        return $pdo; // Assurez-vous de retourner $pdo
    } catch (PDOException $e) {
        echo "Erreur de connexion à la base de données : " . $e->getMessage();
        return null; // Retourne null en cas d'erreur
    }
}
?>
