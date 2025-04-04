<?php
session_start();
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: index.php');
    exit;
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
                    <div class="stat-title">Liaisons Actives</div>
                    <div class="stat-value">12</div>
                </div>
                <div class="stat-card green">
                    <div class="stat-title">Traversées du Jour</div>
                    <div class="stat-value">8</div>
                </div>
                <div class="stat-card purple">
                    <div class="stat-title">Équipages Disponibles</div>
                    <div class="stat-value">24</div>
                </div>
            </div>

            <!-- Activité récente (exemple statique, à dynamiser si nécessaire) -->
            <div class="activity-card">
                <div class="activity-title">Activité récente</div>
                <div class="activity-item">
                    <span class="activity-text">Nouvelle traversée ajoutée</span>
                    <span class="activity-time">Il y a 5 minutes</span>
                </div>
                <div class="activity-item">
                    <span class="activity-text">Modification horaire liaison Marseille-Ajaccio</span>
                    <span class="activity-time">Il y a 2 heures</span>
                </div>
                <div class="activity-item">
                    <span class="activity-text">Mise à jour équipage MS Riviera</span>
                    <span class="activity-time">Il y a 3 heures</span>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>