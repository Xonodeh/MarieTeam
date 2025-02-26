<?php
// testInscription.php

// Activer l'affichage des erreurs PHP
error_reporting(E_ALL);
ini_set('display_errors', 1);

include_once '../scripts/db.php';         // Inclusion de la connexion AVANT l'inscription
include_once '../scripts/inscription.php';

// Appel de la fonction de connexion
$pdo = connexionBDD(); // Initialisation de $lePdo

// Vérification de la connexion
if ($pdo) {
    echo "Connexion réussie.<br>";

    // Test de var_dump pour s'assurer que $lePdo est un objet PDO
    var_dump($pdo); 

    // Appel de la fonction d'inscription en passant $lePdo
    $result = inscription($pdo,"Léo Makongue", "mkg", "fzhufzufhz");

    // Vérification du résultat de l'inscription
    if ($result) {
        echo "Inscription réussie !";
    } else {
        echo "Échec de l'inscription.";
    }
} else {
    echo "La connexion à la base de données a échoué.";
}
?>
