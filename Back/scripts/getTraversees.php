<?php
require_once 'db.php';
$pdo = connexionBDD();



if (isset($_GET['action'])) {
    $action = $_GET['action'];
    if ($action === 'getSecteurs') {
        $querySecteurs = $pdo->query("SELECT * FROM secteur");
        $secteurs = $querySecteurs->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($secteurs);
    } elseif ($action === 'getLiaisonsBySecteur' && isset($_GET['secteurId'])) {
        $secteurId = $_GET['secteurId'];
        $stmt = $pdo->prepare("
            SELECT l.IDLiaison, p1.LibPort AS port_depart, p2.LibPort AS port_arrivee 
            FROM liaison l
            JOIN port p1 ON l.IDPort = p1.IDPort
            JOIN port p2 ON l.IDPort_1 = p2.IDPort
            WHERE l.IDSecteur = :secteurId
            ORDER BY port_depart, port_arrivee;
        ");
        $stmt->execute(['secteurId' => $secteurId]);
        $liaisons = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($liaisons);
    } elseif ($action === 'getLiaisons') {
        $queryLiaisons = $pdo->query("
            SELECT l.IDLiaison, p1.LibPort AS port_depart, p2.LibPort AS port_arrivee 
            FROM liaison l
            JOIN port p1 ON l.IDPort = p1.IDPort
            JOIN port p2 ON l.IDPort_1 = p2.IDPort
            ORDER BY port_depart, port_arrivee
        ");
        $liaisons = $queryLiaisons->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($liaisons);
    
        
    } elseif ($action === 'getTraversees' && isset($_GET['liaison']) && isset($_GET['date'])) {
        $liaisonId = $_GET['liaison'];
        $date = $_GET['date'];
    
        $stmt = $pdo->prepare("
            SELECT t.IDTraversee, t.HeureTraversee, b.nomBateau,
                   t.places_passagers,
                   t.veh_inf_2m,
                   t.veh_sup_2m
            FROM traversee t
            JOIN bateau b ON t.IDBateau = b.IDBateau
            WHERE t.IDLiaison = :liaisonId AND DATE(t.DateTraversee) = :date
            ORDER BY t.HeureTraversee
        ");
        $stmt->execute(['liaisonId' => $liaisonId, 'date' => $date]);
        $traversees = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
        if (!empty($traversees)) {
            echo '<table class="traverse-table">';
            echo '<thead><tr><th>N°</th><th>Heure</th><th>Bateau</th><th>A Passager</th><th>B Véhic. inf. 2 m</th><th>C Véhic. sup. 2 m</th><th></th></tr></thead>';
            echo '<tbody>';
            foreach ($traversees as $traversee) {
                echo '<tr>';
                echo '<td>' . htmlspecialchars($traversee['IDTraversee']) . '</td>';
                echo '<td>' . htmlspecialchars($traversee['HeureTraversee']) . '</td>';
                echo '<td>' . htmlspecialchars($traversee['nomBateau']) . '</td>';
                echo '<td>' . htmlspecialchars($traversee['places_passagers'] ?? 0) . '</td>';
                echo '<td>' . htmlspecialchars($traversee['veh_inf_2m'] ?? 0) . '</td>';
                echo '<td>' . htmlspecialchars($traversee['veh_sup_2m'] ?? 0) . '</td>';
                echo '<td><button class="reserve-btn" data-id="' . htmlspecialchars($traversee['IDTraversee']) . '">Réserver</button></td>';
                echo '</tr>';
            }
            echo '</tbody></table>';
        } else {
            echo '<p>Aucune traversée disponible pour cette liaison et cette date.</p>';
        }
    }
    

}
?>
