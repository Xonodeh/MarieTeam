<?php
session_start();    // Important de démarrer la session avant destruction
session_unset();    // Vide les variables de session
session_destroy();  // Détruit complètement la session

// Redirection immédiate vers la page de connexion (adapte selon ton cas précis)
header('Location: ../../Front/connexion.html');
exit;
?>
