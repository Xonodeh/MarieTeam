<?php
// admin.php (Front)
session_start();

// 1) Vérification basique de session
if (
    ! isset($_SESSION['login'])
 || ! isset($_SESSION['role'])
 || $_SESSION['role'] !== 'admin'
) {
    header('Location: index.php');
    exit;
}

// 2) Optionnel : re-validation en BDD
require_once '../Back/scripts/db.php';
try {
    $pdo = connexionBDD();
    $stmt = $pdo->prepare(
      "SELECT 1 FROM gestionnaire WHERE LogGestionnaire = :login"
    );
    $stmt->execute(['login' => $_SESSION['login']]);
    if (! $stmt->fetch()) {
        // Si le login en session n'est plus un gestionnaire
        session_unset();
        session_destroy();
        header('Location: index.php');
        exit;
    }
} catch (PDOException $e) {
    // En cas d’erreur BDD, on refuse l’accès
    session_unset();
    session_destroy();
    header('Location: index.php');
    exit;
}

// À partir d’ici, l’utilisateur est bien un gestionnaire.
// Vos calculs et l’affichage continuent…

try {
    // Connexion BDD
    $pdo = connexionBDD();

    // Nombre total de passagers
    $stmt = $pdo->query("SELECT SUM(NbPassager) AS total_passagers FROM enregistrer");
    $row = $stmt->fetch();
    $totalPassagers = $row['total_passagers'] ?? 0;

    // Chiffre d’affaires total (passagers + véhicules)
    $sql = "SELECT
    -- CA Passagers
    SUM(e.NbPassager       * tp.Prix)      AS CA_Passagers,
    -- CA Véhicules inférieurs à 2 m
    SUM(e.NbVehiculeInf2m  * tv_inf.Prix)  AS CA_VehiculesInf2m,
    -- CA Véhicules supérieurs à 2 m
    SUM(e.NbVehiculeSup2m  * tv_sup.Prix)  AS CA_VehiculesSup2m,
    -- CA Total
    SUM(
      e.NbPassager       * tp.Prix
    + e.NbVehiculeInf2m  * tv_inf.Prix
    + e.NbVehiculeSup2m  * tv_sup.Prix
    )                               
    AS ChiffreAffaires

  FROM reservation r
    JOIN enregistrer e
      ON e.IDReservation = r.IDReservation

    JOIN traversee tr
      ON tr.IDTraversee = r.IDTraversee

    JOIN liaison l
      ON l.IDLiaison = tr.IDLiaison

    -- On récupère la période tarifaire correspondante
    JOIN periode p
      ON tr.DateTraversee
         BETWEEN p.DateDebutPeriode
             AND p.DateFinPeriode

    -- Tarif général « passager » (IDType = 1)
    JOIN tarif tp
      ON tp.IDLiaison = l.IDLiaison
     AND tp.IDPeriode = p.IDPeriode
     AND tp.IDType    = 1

    -- Tarif véhicules inf. 2 m (IDType = 4)
    JOIN tarif tv_inf
      ON tv_inf.IDLiaison = l.IDLiaison
     AND tv_inf.IDPeriode = p.IDPeriode
     AND tv_inf.IDType    = 4

    -- Tarif véhicules sup. 2 m (IDType = 5)
    JOIN tarif tv_sup
      ON tv_sup.IDLiaison = l.IDLiaison
     AND tv_sup.IDPeriode = p.IDPeriode
     AND tv_sup.IDType    = 5";

    $stmt = $pdo->query($sql);
    $row = $stmt->fetch();
    $CA_passagers  = $row['CA_Passagers']  ?? 0;
    $CA_vehicules  = $row['CA_Vehicules']  ?? 0;
    $chiffreAffaires = $row['ChiffreAffaires'] ?? 0;

    // Passagers par catégorie
    $stmt = $pdo->query("SELECT SUM(NBPassager) AS TotalPassagers, 
                            SUM(NbVehiculeInf2m) AS TotalVehiculeInf2m, 
                            SUM(NbVehiculeSup2m) AS TotalVehiculeSup2m
                    FROM enregistrer");

$totaux = [];
if ($row = $stmt->fetch()) {
    $totaux = [
        'passagers' => $row['TotalPassagers'],
        'vehicules_inferieurs_2m' => $row['TotalVehiculeInf2m'],
        'vehicules_superieurs_2m' => $row['TotalVehiculeSup2m']
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
                <h1 class="page-title">Bienvenue, <?php echo htmlspecialchars($_SESSION['login']); ?></h1>
                <div class="avatar">
                    <?php echo strtoupper(substr(htmlspecialchars($_SESSION['login']), 0, 2)); ?>
                </div>
            </div>

            <!-- Grille du tableau de bord -->
            <div class="dashboard-grid">
                <div class="stat-card blue">
                    <div class="stat-title">Passagers transportés</div>
                    <div class="stat-value"><?php echo $totalPassagers; ?></div>
                </div>
                <div class="stat-card green">
                    <div class="stat-title">Chiffre d'affaires €</div>
                    <div class="stat-value"><?php echo $chiffreAffaires . '€' ?></div>
                </div>
            </div>

            <!-- Activité récente (dynamisée avec les catégories) -->
            <!-- Activité récente (dynamisée avec les catégories) -->
            <div class="activity-card">
                <div class="activity-title">Nombre total de passagers et véhicules</div>
                <div class="activity-item">
                    <span class="activity-text">Passagers</span>
                    <span class="activity-time"><?php echo htmlspecialchars($totaux['passagers'] ?? 0); ?> passagers</span>
                </div>
                <div class="activity-item">
                    <span class="activity-text">Véhicules inférieurs à 2 m</span>
                    <span class="activity-time"><?php echo htmlspecialchars($totaux['vehicules_inferieurs_2m'] ?? 0); ?> véhicules</span>
                </div>
                <div class="activity-item">
                    <span class="activity-text">Véhicules supérieurs à 2 m</span>
                    <span class="activity-time"><?php echo htmlspecialchars($totaux['vehicules_superieurs_2m'] ?? 0); ?> véhicules</span>
                </div>
    </div>

        </div>
    </div>
</div>

</body>
</html>
