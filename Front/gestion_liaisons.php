<?php
session_start();
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: index.php');
    exit;
}

require_once '../Back/scripts/db.php';
$pdo = connexionBDD();

$liaisons = $pdo->query("
    SELECT l.IDLiaison, l.Distance, s.IDSecteur, s.LibSecteur,
           p1.IDPort AS IDDepart, p1.LibPort AS PortDepart,
           p2.IDPort AS IDArrivee, p2.LibPort AS PortArrivee
    FROM liaison l
    JOIN port p1 ON l.IDPort = p1.IDPort
    JOIN port p2 ON l.IDPort_1 = p2.IDPort
    JOIN secteur s ON l.IDSecteur = s.IDSecteur
")->fetchAll(PDO::FETCH_ASSOC);

$ports = $pdo->query("SELECT IDPort, LibPort FROM port")->fetchAll(PDO::FETCH_ASSOC);
$secteurs = $pdo->query("SELECT IDSecteur, LibSecteur FROM secteur")->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion dynamique des liaisons</title>
    <link rel="stylesheet" href="adminReservation.css">
    <script>
        function editLiaison(id) {
            const row = document.querySelector(`#liaison-${id}`);
            const dist = row.querySelector('.dist').textContent.trim();
            const depart = row.dataset.depart;
            const arrivee = row.dataset.arrivee;
            const secteur = row.dataset.secteur;

            row.innerHTML = `
                <td>${id}</td>
                <td><input type="number" id="dist-${id}" value="${dist}"></td>
                <td>
                    <select id="depart-${id}">
                        <?php foreach ($ports as $p): ?>
                            <option value="<?= $p['IDPort'] ?>"><?= $p['LibPort'] ?></option>
                        <?php endforeach; ?>
                    </select>
                </td>
                <td>
                    <select id="arrivee-${id}">
                        <?php foreach ($ports as $p): ?>
                            <option value="<?= $p['IDPort'] ?>"><?= $p['LibPort'] ?></option>
                        <?php endforeach; ?>
                    </select>
                </td>
                <td>
                    <select id="secteur-${id}">
                        <?php foreach ($secteurs as $s): ?>
                            <option value="<?= $s['IDSecteur'] ?>"><?= $s['LibSecteur'] ?></option>
                        <?php endforeach; ?>
                    </select>
                </td>
                <td><button onclick="saveLiaison(${id})">💾</button></td>
            `;

            document.querySelector(`#depart-${id}`).value = depart;
            document.querySelector(`#arrivee-${id}`).value = arrivee;
            document.querySelector(`#secteur-${id}`).value = secteur;
        }

        function saveLiaison(id) {
            const dist = document.querySelector(`#dist-${id}`).value;
            const depart = document.querySelector(`#depart-${id}`).value;
            const arrivee = document.querySelector(`#arrivee-${id}`).value;
            const secteur = document.querySelector(`#secteur-${id}`).value;

            fetch('../Back/scripts/update_liaisons.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ id, dist, depart, arrivee, secteur })
            })
            .then(res => res.json())
            .then(data => {
                console.log(data);
                if (data.success) location.reload();
                else alert("Erreur : " + data.error);
            })
            .catch(error => console.error("Erreur AJAX : ", error));
        }
    </script>
</head>
<body>
    <h1>Gestion des Liaisons</h1>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th><th>Distance (km)</th><th>Port départ</th><th>Port arrivée</th><th>Secteur</th><th>Action</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($liaisons as $l): ?>
                <tr id="liaison-<?= $l['IDLiaison'] ?>"
                    data-depart="<?= $l['IDDepart'] ?>"
                    data-arrivee="<?= $l['IDArrivee'] ?>"
                    data-secteur="<?= $l['IDSecteur'] ?>">
                    <td><?= $l['IDLiaison'] ?></td>
                    <td class="dist"><?= $l['Distance'] ?></td>
                    <td><?= $l['PortDepart'] ?></td>
                    <td><?= $l['PortArrivee'] ?></td>
                    <td><?= $l['LibSecteur'] ?></td>
                    <td><button onclick="editLiaison(<?= $l['IDLiaison'] ?>)">✏️</button></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    <a href="admin.php">⬅ Retour</a>
</body>
</html>
