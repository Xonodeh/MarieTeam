⚓ MarieTeam - Gestion de Liaisons Maritimes
MarieTeam est une application web de gestion de réservations pour une compagnie de transports maritimes. Ce projet a été développé pour permettre la gestion des traversées, des navires, des ports et des réservations clients au sein d'une interface centralisée.

🚀 Fonctionnalités
👤 Côté Client
Consultation des horaires : Visualisation des liaisons et des traversées disponibles par secteur.

Réservation en ligne : Possibilité de réserver des places pour passagers et véhicules.

Gestion de compte : Inscription, connexion et historique des réservations.

🔐 Côté Administration
Gestion du catalogue : Ajout, modification et suppression de ports, de liaisons et de navires.

Planification : Configuration des horaires et des fréquences de traversées.

Tarification : Gestion des catégories de tarifs selon les périodes et les types de transport.

🛠️ Stack Technique
Backend : PHP (Architecture MVC)

Frontend : HTML5, CSS3, JavaScript

Base de données : MySQL / MariaDB

Outils : PDO pour la sécurité des requêtes SQL

📂 Structure du Projet
Plaintext

MarieTeam/
├── Controllers/   # Logique métier et contrôle des flux

├── Models/        # Interactions avec la base de données

├── Views/         # Fichiers d'affichage (Templates)

├── Public/        # Assets (CSS, JS, Images)

├── Config/        # Configuration de la base de données

└── index.php      # Point d'entrée de l'application

⚙️ Installation
Cloner le dépôt :

Bash

git clone https://github.com/Xonodeh/MarieTeam.git
Configuration de la base de données :

Importer le fichier SQL fourni (généralement dans un dossier sql/ ou database/) dans votre gestionnaire de base de données (phpMyAdmin).

Modifier le fichier de configuration (ex: Config/db.php) avec vos identifiants locaux.

Lancement :

Placer le dossier dans votre répertoire htdocs (XAMPP) ou www (WAMP).

Accéder à l'application via http://localhost/MarieTeam.
