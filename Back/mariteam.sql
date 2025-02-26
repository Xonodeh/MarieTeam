-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 26 fév. 2025 à 11:07
-- Version du serveur : 10.4.24-MariaDB
-- Version de PHP : 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `mariteam`
--

-- --------------------------------------------------------

--
-- Structure de la table `bateau`
--

CREATE TABLE `bateau` (
  `IDBateau` int(11) NOT NULL,
  `nomBateau` varchar(50) DEFAULT NULL,
  `LongueurBateau` decimal(15,2) DEFAULT NULL,
  `VitesseBateau` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `bateau`
--

INSERT INTO `bateau` (`IDBateau`, `nomBateau`, `LongueurBateau`, `VitesseBateau`) VALUES
(1, 'Titanic', '269.10', '24.00'),
(2, 'Queen Mary', '311.00', '28.00'),
(3, 'Costa Concordia', '290.00', '25.00'),
(4, 'Normandie', '245.00', '30.00'),
(5, 'Oasis of the Seas', '360.00', '22.00');

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE `categorie` (
  `IdCategorie` int(11) NOT NULL,
  `NomCategorie` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`IdCategorie`, `NomCategorie`) VALUES
(1, 'Cargo'),
(2, 'Passager'),
(3, 'Mixte'),
(4, 'Vente');

-- --------------------------------------------------------

--
-- Structure de la table `categoriser`
--

CREATE TABLE `categoriser` (
  `IDBateau` int(11) NOT NULL,
  `IdCategorie` int(11) NOT NULL,
  `Capacite` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `enregistrer`
--

CREATE TABLE `enregistrer` (
  `IDType` int(11) NOT NULL,
  `IDReservation` int(11) NOT NULL,
  `NbPassager` int(11) DEFAULT 0,
  `NbVehicule` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `gestionnaire`
--

CREATE TABLE `gestionnaire` (
  `IDGestionnaire` int(11) NOT NULL,
  `NomGestionnaire` varchar(50) DEFAULT NULL,
  `LogGestionnaire` varchar(50) DEFAULT NULL,
  `MdpGestionnaire` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `gestionnaire`
--

INSERT INTO `gestionnaire` (`IDGestionnaire`, `NomGestionnaire`, `LogGestionnaire`, `MdpGestionnaire`) VALUES
(1, 'John Doe', 'jdoe', 'password123'),
(2, 'Jane Smith', 'jsmith', 'pass456'),
(3, 'Carlos Garcia', 'cgarcia', 'mypassword789');

-- --------------------------------------------------------

--
-- Structure de la table `liaison`
--

CREATE TABLE `liaison` (
  `IDLiaison` int(11) NOT NULL,
  `Distance` int(11) DEFAULT NULL,
  `IDPort` int(11) NOT NULL,
  `IDPort_1` int(11) NOT NULL,
  `IDSecteur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `liaison`
--

INSERT INTO `liaison` (`IDLiaison`, `Distance`, `IDPort`, `IDPort_1`, `IDSecteur`) VALUES
(1, 150, 1, 2, 1),
(2, 300, 2, 3, 2),
(3, 200, 3, 4, 3),
(4, 450, 4, 5, 4);

-- --------------------------------------------------------

--
-- Structure de la table `periode`
--

CREATE TABLE `periode` (
  `IDPeriode` int(11) NOT NULL,
  `NomPeriode` varchar(50) DEFAULT NULL,
  `DateDebutPeriode` date DEFAULT NULL,
  `DateFinPeriode` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `periode`
--

INSERT INTO `periode` (`IDPeriode`, `NomPeriode`, `DateDebutPeriode`, `DateFinPeriode`) VALUES
(1, 'Haute saison', '2025-06-01', '2025-08-31'),
(2, 'Basse saison', '2025-09-01', '2025-12-31'),
(3, 'Moyenne saison', '2025-03-01', '2025-05-31');

-- --------------------------------------------------------

--
-- Structure de la table `port`
--

CREATE TABLE `port` (
  `IDPort` int(11) NOT NULL,
  `LibPort` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `port`
--

INSERT INTO `port` (`IDPort`, `LibPort`) VALUES
(1, 'Marseille'),
(2, 'Nice'),
(3, 'Paris'),
(4, 'Toulon'),
(5, 'Cannes');

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

CREATE TABLE `reservation` (
  `IDReservation` int(11) NOT NULL,
  `NomClient` varchar(50) DEFAULT NULL,
  `AdresseClient` varchar(50) DEFAULT NULL,
  `CPClient` int(11) DEFAULT NULL,
  `VilleClient` varchar(50) DEFAULT NULL,
  `IdUtilisateur` int(11) NOT NULL,
  `IDTraversee` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `secteur`
--

CREATE TABLE `secteur` (
  `IDSecteur` int(11) NOT NULL,
  `LibSecteur` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `secteur`
--

INSERT INTO `secteur` (`IDSecteur`, `LibSecteur`) VALUES
(1, 'Méditerranée'),
(2, 'Atlantique'),
(3, 'Mer du Nord'),
(4, 'Mer des Caraïbes');

-- --------------------------------------------------------

--
-- Structure de la table `tarif`
--

CREATE TABLE `tarif` (
  `IdTarif` int(11) NOT NULL,
  `Prix` decimal(15,2) DEFAULT NULL,
  `IDPeriode` int(11) NOT NULL,
  `IDType` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `tarif`
--

INSERT INTO `tarif` (`IdTarif`, `Prix`, `IDPeriode`, `IDType`) VALUES
(1, '100.00', 1, 1),
(2, '50.00', 2, 2),
(3, '200.00', 3, 3),
(4, '70.00', 1, 4),
(5, '150.00', 2, 5);

-- --------------------------------------------------------

--
-- Structure de la table `tarifer`
--

CREATE TABLE `tarifer` (
  `IDLiaison` int(11) NOT NULL,
  `IdTarif` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `traversee`
--

CREATE TABLE `traversee` (
  `IDTraversee` int(11) NOT NULL,
  `DateTraversee` date DEFAULT NULL,
  `HeureTraversee` time DEFAULT NULL,
  `IDBateau` int(11) NOT NULL,
  `IDLiaison` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `traversee`
--

INSERT INTO `traversee` (`IDTraversee`, `DateTraversee`, `HeureTraversee`, `IDBateau`, `IDLiaison`) VALUES
(1, '2025-06-15', '12:00:00', 1, 1),
(2, '2025-07-10', '14:00:00', 2, 2),
(3, '2025-06-20', '16:30:00', 3, 3),
(4, '2025-08-05', '10:00:00', 4, 4);

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

CREATE TABLE `type` (
  `IDType` int(11) NOT NULL,
  `TypePassager` varchar(50) DEFAULT NULL,
  `TypeVehicule` varchar(50) DEFAULT NULL,
  `IdCategorie` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `type`
--

INSERT INTO `type` (`IDType`, `TypePassager`, `TypeVehicule`, `IdCategorie`) VALUES
(1, 'Adultes', 'Voiture', 2),
(2, 'Enfants', 'Vélo', 2),
(3, 'Camion', 'Camion', 1),
(4, 'Personnes âgées', 'Scooter', 2),
(5, 'Livraisons', 'Fourgon', 3);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `IdUtilisateur` int(11) NOT NULL,
  `NomUtilisateur` varchar(50) DEFAULT NULL,
  `LogUtilisateur` varchar(50) DEFAULT NULL,
  `MdpUtilisateur` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`IdUtilisateur`, `NomUtilisateur`, `LogUtilisateur`, `MdpUtilisateur`) VALUES
(1, 'Alice Dupont', 'alice123', 'alicepass'),
(2, 'Bob Lefevre', 'bob456', 'bobpass'),
(3, 'Catherine Martin', 'catherine789', 'catherinepass'),
(4, 'David Moreau', 'david321', 'davidpass');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `bateau`
--
ALTER TABLE `bateau`
  ADD PRIMARY KEY (`IDBateau`);

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`IdCategorie`);

--
-- Index pour la table `categoriser`
--
ALTER TABLE `categoriser`
  ADD PRIMARY KEY (`IDBateau`,`IdCategorie`),
  ADD KEY `IdCategorie` (`IdCategorie`);

--
-- Index pour la table `enregistrer`
--
ALTER TABLE `enregistrer`
  ADD PRIMARY KEY (`IDType`,`IDReservation`),
  ADD KEY `IDReservation` (`IDReservation`);

--
-- Index pour la table `gestionnaire`
--
ALTER TABLE `gestionnaire`
  ADD PRIMARY KEY (`IDGestionnaire`);

--
-- Index pour la table `liaison`
--
ALTER TABLE `liaison`
  ADD PRIMARY KEY (`IDLiaison`),
  ADD KEY `IDPort` (`IDPort`),
  ADD KEY `IDPort_1` (`IDPort_1`),
  ADD KEY `IDSecteur` (`IDSecteur`);

--
-- Index pour la table `periode`
--
ALTER TABLE `periode`
  ADD PRIMARY KEY (`IDPeriode`);

--
-- Index pour la table `port`
--
ALTER TABLE `port`
  ADD PRIMARY KEY (`IDPort`);

--
-- Index pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`IDReservation`),
  ADD KEY `IdUtilisateur` (`IdUtilisateur`),
  ADD KEY `IDTraversee` (`IDTraversee`);

--
-- Index pour la table `secteur`
--
ALTER TABLE `secteur`
  ADD PRIMARY KEY (`IDSecteur`);

--
-- Index pour la table `tarif`
--
ALTER TABLE `tarif`
  ADD PRIMARY KEY (`IdTarif`),
  ADD KEY `IDPeriode` (`IDPeriode`),
  ADD KEY `IDType` (`IDType`);

--
-- Index pour la table `tarifer`
--
ALTER TABLE `tarifer`
  ADD PRIMARY KEY (`IDLiaison`,`IdTarif`),
  ADD KEY `IdTarif` (`IdTarif`);

--
-- Index pour la table `traversee`
--
ALTER TABLE `traversee`
  ADD PRIMARY KEY (`IDTraversee`),
  ADD KEY `IDBateau` (`IDBateau`),
  ADD KEY `IDLiaison` (`IDLiaison`);

--
-- Index pour la table `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`IDType`),
  ADD KEY `IdCategorie` (`IdCategorie`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`IdUtilisateur`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `bateau`
--
ALTER TABLE `bateau`
  MODIFY `IDBateau` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `IdCategorie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `gestionnaire`
--
ALTER TABLE `gestionnaire`
  MODIFY `IDGestionnaire` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `liaison`
--
ALTER TABLE `liaison`
  MODIFY `IDLiaison` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `periode`
--
ALTER TABLE `periode`
  MODIFY `IDPeriode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `port`
--
ALTER TABLE `port`
  MODIFY `IDPort` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `IDReservation` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `secteur`
--
ALTER TABLE `secteur`
  MODIFY `IDSecteur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `tarif`
--
ALTER TABLE `tarif`
  MODIFY `IdTarif` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `traversee`
--
ALTER TABLE `traversee`
  MODIFY `IDTraversee` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `type`
--
ALTER TABLE `type`
  MODIFY `IDType` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `IdUtilisateur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `categoriser`
--
ALTER TABLE `categoriser`
  ADD CONSTRAINT `categoriser_ibfk_1` FOREIGN KEY (`IDBateau`) REFERENCES `bateau` (`IDBateau`),
  ADD CONSTRAINT `categoriser_ibfk_2` FOREIGN KEY (`IdCategorie`) REFERENCES `categorie` (`IdCategorie`);

--
-- Contraintes pour la table `enregistrer`
--
ALTER TABLE `enregistrer`
  ADD CONSTRAINT `enregistrer_ibfk_1` FOREIGN KEY (`IDType`) REFERENCES `type` (`IDType`),
  ADD CONSTRAINT `enregistrer_ibfk_2` FOREIGN KEY (`IDReservation`) REFERENCES `reservation` (`IDReservation`);

--
-- Contraintes pour la table `liaison`
--
ALTER TABLE `liaison`
  ADD CONSTRAINT `liaison_ibfk_1` FOREIGN KEY (`IDPort`) REFERENCES `port` (`IDPort`),
  ADD CONSTRAINT `liaison_ibfk_2` FOREIGN KEY (`IDPort_1`) REFERENCES `port` (`IDPort`),
  ADD CONSTRAINT `liaison_ibfk_3` FOREIGN KEY (`IDSecteur`) REFERENCES `secteur` (`IDSecteur`);

--
-- Contraintes pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`IdUtilisateur`) REFERENCES `utilisateur` (`IdUtilisateur`),
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`IDTraversee`) REFERENCES `traversee` (`IDTraversee`);

--
-- Contraintes pour la table `tarif`
--
ALTER TABLE `tarif`
  ADD CONSTRAINT `tarif_ibfk_1` FOREIGN KEY (`IDPeriode`) REFERENCES `periode` (`IDPeriode`),
  ADD CONSTRAINT `tarif_ibfk_2` FOREIGN KEY (`IDType`) REFERENCES `type` (`IDType`);

--
-- Contraintes pour la table `tarifer`
--
ALTER TABLE `tarifer`
  ADD CONSTRAINT `tarifer_ibfk_1` FOREIGN KEY (`IDLiaison`) REFERENCES `liaison` (`IDLiaison`),
  ADD CONSTRAINT `tarifer_ibfk_2` FOREIGN KEY (`IdTarif`) REFERENCES `tarif` (`IdTarif`);

--
-- Contraintes pour la table `traversee`
--
ALTER TABLE `traversee`
  ADD CONSTRAINT `traversee_ibfk_1` FOREIGN KEY (`IDBateau`) REFERENCES `bateau` (`IDBateau`),
  ADD CONSTRAINT `traversee_ibfk_2` FOREIGN KEY (`IDLiaison`) REFERENCES `liaison` (`IDLiaison`);

--
-- Contraintes pour la table `type`
--
ALTER TABLE `type`
  ADD CONSTRAINT `type_ibfk_1` FOREIGN KEY (`IdCategorie`) REFERENCES `categorie` (`IdCategorie`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
