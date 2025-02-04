<?php

include_once '../scripts/connexionBDD.php';

$lePdo = connexionBDD();

$result = inscription($lePdo,"U003" ,"Léo Makongue", "mkg","fzhufzufhz");

if ($result) {
    echo "Inscription réussie !";
} else {
    echo "Échec de l'inscription.";
}
