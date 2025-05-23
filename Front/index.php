<?php
session_start();
?>


<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MarieTeam - Accueil</title>
    <link rel="stylesheet" href="style.css">
    <link rel="shortcut icon" href="img/logoOnglet.png" type="imgOnglet">
</head>
<body>
    <div class="container">
        <header class="header">
            <div class="logo">
                <img src="img/logo.png" alt="Marie Team Logo" />
            </div>
            <nav class="navigation">
            </nav>
            <div class="search-bar">
                <input type="text" placeholder="Rechercher...">
                <button type="submit">
                    <img src="img/loupe.png" alt="Loupe">
                </button>
            </div>
            <div class="user-profile">
            <img src="img/compte.png" alt="Profile Picture" />
            <?php if (isset($_SESSION['login'])): ?>
                <span><?php echo htmlspecialchars($_SESSION['login']); ?></span>
                    <a href="../Back/scripts/deconnexion.php" class="btn-deconnexion">Déconnexion</a>
            <?php else: ?>
                <a href="connexion.html" class="btn-connexion">Se connecter</a>
            <?php endif; ?>
            </div>
        </header>
        <div class="boat-image-container">
            <img src="img/bateau.png" alt="Bateau" class="boat-image">
        </div>
        <main class="main">
            <section class="hero">
                <h1>Voyagez en mer grâce à MarieTeam!</h1>
                <p>
                    MarieTeam simplifie vos réservations pour des escapades maritimes inoubliables.                    
                    <br>Choisissez votre destination, sélectionnez votre traversée,
                    <br> et profitez d’une expérience unique à bord. 🌊✨
                </p>
                <a href="reservation.html" class="button">Réserver</a>
            </section>

            <section class="features">
                <div class="feature">
                    <div class="text">
                        <h2>Préparez-vous à l'aventure avec MarieTeam!</h2>
                        <br>
                        <p>
                            Rendez-vous sur notre onglet <a href="/">Réservations</a> pour découvrir nos itinéraires, <br>choisir la traversée qui vous inspire, <br>et réserver votre voyage en quelques clics ! 🚢✨
                        </p>
                    </div>
                    <div class="image">
                        <img src="img/bateau2.png" alt="Cruise Ship" />
                    </div>
                </div>

                <div class="feature">
                    <div class="image">
                        <img src="img/detente.png" alt="Night Sky" />
                    </div>
                    <div class="text">
                        <p>
                            Une fois votre réservation effectuée, 
                            <br>celle-ci sera disponible sur votre compte MarieTeam 🛳️✨
                            <br>Vous y trouverez un historique détaillé de vos réservations, avec toutes les informations nécessaires pour votre traversée.
                            <br>                             
                            <br>Besoin de modifier ou consulter votre trajet ? 
                            <br>Tout est à portée de clic dans votre espace, conçu pour vous offrir une gestion simple et rapide.
                        </p>
                        <br>
                        <br>            
                        <h2>Avec MarieTeam, embarquez l’esprit tranquille ! 🌊</h2>
                    </div>
                </div>
            </section>
        </main>
        <footer class="footer">
            <p>&copy; 2024 MarieTeam. Tous droits réservés.</p>
        </footer>
    </div>
</body>
</html>


