<?php
session_start();
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: index.php');
    exit;
}
require_once '../Back/scripts/db.php';
$pdo = connexionBDD();

// Récupérer toutes les traversées
$traversees = $pdo->query("
    SELECT t.IDTraversee, t.DateTraversee, t.HeureTraversee, 
           b.nomBateau, l.IDLiaison, l.IDPort, l.IDPort_1,
           p1.LibPort AS PortDepart, p2.LibPort AS PortArrivee
    FROM traversee t
    JOIN bateau b ON b.IDBateau = t.IDBateau
    JOIN liaison l ON l.IDLiaison = t.IDLiaison
    JOIN port p1 ON p1.IDPort = l.IDPort
    JOIN port p2 ON p2.IDPort = l.IDPort_1
    ORDER BY t.DateTraversee, t.HeureTraversee
")->fetchAll(PDO::FETCH_ASSOC);

// Récupérer la liste des bateaux et liaisons pour la modification
$bateaux = $pdo->query("SELECT IDBateau, nomBateau FROM bateau")->fetchAll(PDO::FETCH_ASSOC);
$liaisons = $pdo->query("
    SELECT l.IDLiaison, p1.LibPort AS depart, p2.LibPort AS arrivee
    FROM liaison l
    JOIN port p1 ON l.IDPort = p1.IDPort
    JOIN port p2 ON l.IDPort_1 = p2.IDPort
")->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion dynamique des traversées</title>
    <link rel="stylesheet" href="adminReservation.css">
    <script>
        function editTraversee(id) {
            const row = document.querySelector(`#traversee-${id}`);
            const date = row.querySelector('.date').textContent.trim();
            const heure = row.querySelector('.heure').textContent.trim();
            const bateau = row.dataset.bateau;
            const liaison = row.dataset.liaison;

            row.innerHTML = `
                <td>${id}</td>
                <td><input type="date" id="date-${id}" value="${date}"></td>
                <td><input type="time" id="heure-${id}" value="${heure}"></td>
                <td>
                    <select id="bateau-${id}">
                        <?php foreach ($bateaux as $b): ?>
                            <option value="<?= $b['IDBateau'] ?>"><?= $b['nomBateau'] ?></option>
                        <?php endforeach; ?>
                    </select>
                </td>
                <td>
                    <select id="liaison-${id}">
                        <?php foreach ($liaisons as $l): ?>
                            <option value="<?= $l['IDLiaison'] ?>"><?= $l['depart'] ?> - <?= $l['arrivee'] ?></option>
                        <?php endforeach; ?>
                    </select>
                </td>
                <td><button onclick="saveTraversee(${id})">💾</button></td>
            `;

            document.querySelector(`#bateau-${id}`).value = bateau;
            document.querySelector(`#liaison-${id}`).value = liaison;
        }

        function saveTraversee(id) {
            const date = document.querySelector(`#date-${id}`).value;
            const heure = document.querySelector(`#heure-${id}`).value;
            const bateau = document.querySelector(`#bateau-${id}`).value;
            const liaison = document.querySelector(`#liaison-${id}`).value;

            fetch('../Back/scripts/update_traversee.php', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({ id, date, heure, bateau, liaison })
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) location.reload();
                else alert("Erreur : " + data.error);
            });
        }
    </script>
</head>
<body>
    <h1>Gestion des Traversées</h1>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th><th>Date</th><th>Heure</th><th>Bateau</th><th>Liaison</th><th>Action</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($traversees as $t): ?>
                <tr id="traversee-<?= $t['IDTraversee'] ?>" 
                    class="<?= (strtotime($t['DateTraversee']) < strtotime(date('Y-m-d'))) ? 'passee' : ((strtotime($t['DateTraversee']) == strtotime(date('Y-m-d'))) ? 'encours' : 'future') ?>"
                    data-bateau="<?= $t['IDBateau'] ?>" 
                    data-liaison="<?= $t['IDLiaison'] ?>">
                    <td><?= $t['IDTraversee'] ?></td>
                    <td class="date"><?= $t['DateTraversee'] ?></td>
                    <td class="heure"><?= substr($t['HeureTraversee'], 0, 5) ?></td>
                    <td><?= $t['nomBateau'] ?></td>
                    <td><?= $t['PortDepart'] ?> - <?= $t['PortArrivee'] ?></td>
                    <td><button onclick="editTraversee(<?= $t['IDTraversee'] ?>)">✏️</button></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    <a href="admin.php">⬅ Retour</a>
</body>
</html>
