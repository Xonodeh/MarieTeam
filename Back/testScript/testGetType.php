<?php
// Met à jour ce chemin selon ton hébergement
$url = 'https://s5-4539.nuage-peda.fr/projets/MARIETEAM/Back/scripts/getType.php';

$response = file_get_contents($url);

if ($response === false) {
    echo "Erreur lors de la requête";
} else {
    echo "Réponse brute :<br><pre>$response</pre><br>";
    $data = json_decode($response, true);
    echo "Libellés trouvés :<br>";
    if (is_array($data)) {
        foreach ($data as $type) {
            echo "- " . htmlspecialchars($type['Libelle']) . "<br>";
        }
    } else {
        echo "Pas de tableau retourné !";
    }
}
?>
