<?php
require_once '../Back/scripts/db.php';
session_start();

// Redirection si l'utilisateur n'est pas admin
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: index.php');
    exit;
}

try {
    // Connexion BDD
    $pdo = connexionBDD();

    // Nombre total de passagers
    $stmt = $pdo->query("SELECT SUM(NbPassager) AS total_passagers FROM enregistrer");
    $row = $stmt->fetch();
    $totalPassagers = $row['total_passagers'] ?? 0;

    // Chiffre d'affaires (optionnel ici, décommenter si besoin)
    $stmt = $pdo->query("SELECT 
    SUM(e.NbPassager * t.Prix) AS ChiffreAffairesPassagers
FROM 
    reservation r
JOIN 
    enregistrer e ON e.IDReservation = r.IDReservation
JOIN 
    traversee tr ON r.IDTraversee = tr.IDTraversee
JOIN 
    liaison l ON tr.IDLiaison = l.IDLiaison
JOIN 
    tarifer tf ON tf.IDLiaison = l.IDLiaison
JOIN 
    tarif t ON t.IdTarif = tf.IdTarif
WHERE 
    t.IDType = e.IDType;");
    
    $row = $stmt->fetch();
    $chiffreAffaires = $row['ChiffreAffairesPassagers'] ?? 0;

    // Passagers par catégorie
    $stmt = $pdo->query("SELECT 
    c.NomCategorie,
    SUM(e.NbPassager) AS TotalPassagers
FROM 
    enregistrer e
JOIN 
    type t ON e.IDType = t.IDType
JOIN 
    categorie c ON t.IDCategorie = c.IDCategorie
GROUP BY 
    c.NomCategorie");

    // Initialisation d'un tableau pour stocker les données
    $passagersParCategories = [];
    while ($row = $stmt->fetch()) {
        $passagersParCategories[] = [
            'categorie' => $row['NomCategorie'],
            'passagers' => $row['TotalPassagers']
        ];
    }
} catch (PDOException $e) {
    $totalPassagers = 0;
    $chiffreAffaires = 0;
    $passagersParCategories = [];
    echo 'Erreur de requête : ' . $e->getMessage();
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - MarieTeam</title>
    <link rel="stylesheet" href="admin.css">
</head>
<body>

<div class="app-container">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="brand">
                <span class="brand-text">MarieTeam Admin</span>
            </div>
        </div>
        <nav>
            <ul class="nav-list">
                <li class="nav-item">
                    <a href="gestion_liaisons.php" class="nav-button">Gérer les Liaisons</a>
                </li>
                <li class="nav-item">
                    <a href="gestion_traversées.php" class="nav-button">Gérer les Traversées</a>
                </li>
            </ul>
        </nav>
        <a href="../Back/scripts/deconnexion.php" class="logout-button">Déconnexion</a>
    </div>

    <!-- Contenu Principal -->
    <div class="main-content">
        <div class="content-container">
            <!-- Barre supérieure -->
            <div class="top-bar">
                <h1 class="page-title">Bienvenue, <?php echo htmlspecialchars($_SESSION['utilisateur']); ?></h1>
                <div class="avatar">
                    <?php echo strtoupper(substr(htmlspecialchars($_SESSION['utilisateur']), 0, 2)); ?>
                </div>
            </div>

            <!-- Grille du tableau de bord -->
            <div class="dashboard-grid">
                <div class="stat-card blue">
                    <div class="stat-title">Passagers transportés</div>
                    <div class="stat-value"><?php echo $totalPassagers; ?></div>
                </div>
                <div class="stat-card green">
                    <div class="stat-title">Chiffre d'affaire €</div>
                    <div class="stat-value"><?php echo $chiffreAffaires . '€' ?></div>
                </div>
            </div>

            <!-- Activité récente (dynamisée avec les catégories) -->
            <div class="activity-card">
                <div class="activity-title">Nombre de passagers par catégories</div>
                <?php foreach ($passagersParCategories as $data): ?>
                    <div class="activity-item">
                        <span class="activity-text"><?php echo htmlspecialchars($data['categorie']); ?></span>
                        <span class="activity-time"><?php echo htmlspecialchars($data['passagers']); ?> passagers</span>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</div>

</body>
</html>
