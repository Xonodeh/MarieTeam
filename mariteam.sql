-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : ven. 18 avr. 2025 à 16:07
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

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
-- Structure de la table `archive_traversee`
--

CREATE TABLE `archive_traversee` (
  `IDTraversee` int(11) NOT NULL,
  `DateTraversee` date DEFAULT NULL,
  `HeureTraversee` time DEFAULT NULL,
  `IDBateau` int(11) DEFAULT NULL,
  `IDLiaison` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `bateau`
--

CREATE TABLE `bateau` (
  `IDBateau` int(11) NOT NULL,
  `nomBateau` varchar(50) DEFAULT NULL,
  `LongueurBateau` decimal(15,2) DEFAULT NULL,
  `VitesseBateau` decimal(15,2) DEFAULT NULL,
  `largeurBat` decimal(15,2) NOT NULL,
  `imageBat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `bateau`
--

INSERT INTO `bateau` (`IDBateau`, `nomBateau`, `LongueurBateau`, `VitesseBateau`, `largeurBat`, `imageBat`) VALUES
(1, 'Titanic', 269.10, 24.00, 0.00, ''),
(2, 'Queen Mary', 311.00, 28.00, 0.00, ''),
(3, 'Costa Concordia', 290.00, 25.00, 0.00, ''),
(4, 'Normandie', 245.00, 30.00, 0.00, ''),
(5, 'Oasis of the Seas', 360.00, 22.00, 0.00, '');

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE `categorie` (
  `IdCategorie` int(11) NOT NULL,
  `NomCategorie` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`IdCategorie`, `NomCategorie`) VALUES
(1, 'Passager'),
(2, 'Veh.inf.2m'),
(3, 'Veh.sup.2m');

-- --------------------------------------------------------

--
-- Structure de la table `categoriser`
--

CREATE TABLE `categoriser` (
  `IDBateau` int(11) NOT NULL,
  `IdCategorie` int(11) NOT NULL,
  `Capacite` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `categoriser`
--

INSERT INTO `categoriser` (`IDBateau`, `IdCategorie`, `Capacite`) VALUES
(1, 2, 500),
(1, 3, 400),
(2, 2, 3000),
(2, 3, 500),
(3, 2, 2800),
(3, 3, 350),
(4, 2, 2200),
(4, 3, 300),
(5, 2, 5400),
(5, 3, 600);

-- --------------------------------------------------------

--
-- Structure de la table `disposer`
--

CREATE TABLE `disposer` (
  `IDBateau` int(11) NOT NULL,
  `idEquip` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `enregistrer`
--

CREATE TABLE `enregistrer` (
  `IDType` int(11) NOT NULL,
  `IDReservation` int(11) NOT NULL,
  `NbPassager` int(11) DEFAULT 0,
  `NbVehicule` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `enregistrer`
--

INSERT INTO `enregistrer` (`IDType`, `IDReservation`, `NbPassager`, `NbVehicule`) VALUES
(1, 100, 5, 0),
(4, 100, 5, 1),
(6, 1, 3, 2);

-- --------------------------------------------------------

--
-- Structure de la table `equipement`
--

CREATE TABLE `equipement` (
  `idEquipement` int(20) NOT NULL,
  `libEquipement` varchar(125) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gestionnaire`
--

CREATE TABLE `gestionnaire` (
  `IDGestionnaire` int(11) NOT NULL,
  `NomGestionnaire` varchar(50) DEFAULT NULL,
  `LogGestionnaire` varchar(50) DEFAULT NULL,
  `MdpGestionnaire` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `gestionnaire`
--

INSERT INTO `gestionnaire` (`IDGestionnaire`, `NomGestionnaire`, `LogGestionnaire`, `MdpGestionnaire`) VALUES
(1, 'John Doe', 'jdoe', 'password123'),
(2, 'Jane Smith', 'jsmith', 'pass456'),
(3, 'Carlos Garcia', 'cgarcia', 'mypassword789'),
(4, ' Nael Haddadi', 'Nael@admin.fr', 'nael'),
(5, 'Leo', 'leo@leo', 'leo'),
(6, 'Nael Haddadi', 'nael@admin', 'nael');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `reservation`
--

INSERT INTO `reservation` (`IDReservation`, `NomClient`, `AdresseClient`, `CPClient`, `VilleClient`, `IdUtilisateur`, `IDTraversee`) VALUES
(1, 'NAEL HADDADI', '9 RUE DU TEST', 59150, 'LILLE', 19, 3),
(100, 'Test Client', '123 Rue Test', 75000, 'Paris', 1, 100);

-- --------------------------------------------------------

--
-- Structure de la table `secteur`
--

CREATE TABLE `secteur` (
  `IDSecteur` int(11) NOT NULL,
  `LibSecteur` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `tarif`
--

INSERT INTO `tarif` (`IdTarif`, `Prix`, `IDPeriode`, `IDType`) VALUES
(1, 100.00, 1, 1),
(2, 50.00, 2, 2),
(3, 200.00, 3, 3),
(4, 70.00, 1, 4),
(5, 150.00, 2, 5),
(99, 150.00, 1, 1);

--
-- Déclencheurs `tarif`
--
DELIMITER $$
CREATE TRIGGER `check_prix_before_insert` BEFORE INSERT ON `tarif` FOR EACH ROW BEGIN
    IF NEW.Prix <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erreur : Le prix doit être supérieur à zéro.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `tarifer`
--

CREATE TABLE `tarifer` (
  `IDLiaison` int(11) NOT NULL,
  `IdTarif` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `tarifer`
--

INSERT INTO `tarifer` (`IDLiaison`, `IdTarif`) VALUES
(1, 1),
(1, 5),
(1, 99);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `traversee`
--

INSERT INTO `traversee` (`IDTraversee`, `DateTraversee`, `HeureTraversee`, `IDBateau`, `IDLiaison`) VALUES
(1, '2025-06-15', '12:00:00', 1, 1),
(2, '2025-07-10', '14:00:00', 2, 2),
(3, '2025-06-20', '16:30:00', 3, 3),
(4, '2025-08-05', '10:00:00', 4, 4),
(100, '2025-12-05', '10:00:00', 1, 1);

--
-- Déclencheurs `traversee`
--
DELIMITER $$
CREATE TRIGGER `check_capacité_avant_insert` BEFORE INSERT ON `traversee` FOR EACH ROW BEGIN
    DECLARE total_capacity INT;
    
    SELECT SUM(Capacite) INTO total_capacity
    FROM categoriser
    WHERE IDBateau = NEW.IDBateau;
    
    IF total_capacity IS NULL OR total_capacity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insertion impossible : la capacité du bateau est non définie ou égale à zéro.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_reservation_after_delete` AFTER DELETE ON `traversee` FOR EACH ROW BEGIN
    DELETE FROM reservation WHERE IDTraversee = OLD.IDTraversee;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

CREATE TABLE `type` (
  `IDType` int(11) NOT NULL,
  `IdCategorie` int(11) NOT NULL,
  `LibelleType` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `type`
--

INSERT INTO `type` (`IDType`, `IdCategorie`, `LibelleType`) VALUES
(1, 1, 'A1 - Adulte'),
(2, 1, 'A2 - Junior 8 à 18 ans'),
(3, 1, 'A3 - Enfant 0 à 7 ans'),
(4, 2, 'B1 - Voiture long.inf.4m'),
(5, 3, 'B2 - Voiture long.inf.5m'),
(6, 3, 'C1 - Fourgon'),
(7, 3, 'C2 - Camping Car'),
(8, 3, 'C3 - Camion');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `IdUtilisateur` int(11) NOT NULL,
  `NomUtilisateur` varchar(50) DEFAULT NULL,
  `LogUtilisateur` varchar(50) DEFAULT NULL,
  `MdpUtilisateur` varchar(70) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`IdUtilisateur`, `NomUtilisateur`, `LogUtilisateur`, `MdpUtilisateur`) VALUES
(1, 'Alice Dupont', 'alice123', 'alicepass'),
(2, 'Bob Lefevre', 'bob456', 'bobpass'),
(3, 'Catherine Martin', 'catherine789', 'catherinepass'),
(4, 'David Moreau', 'david321', 'davidpass'),
(5, 'Léo Makongue', 'mkg', 'fzhufzufhz'),
(6, 'Mouoloud mimousse', NULL, NULL),
(7, 'ghfuiatfghoehpfg ugzhgfoiaifj', NULL, NULL),
(8, 'grhogphz jgrzijgriz', 'ihgrzigrhzeioj@gfirehgri', 'ogjkrezogrjgrezp'),
(9, 'LEOOOO LEOOOOOOOOOO', 'LZEOZOZOO@fhfuiufh', 'ufghaufhuiuahiuf'),
(10, 'NBNL NBBBBBB', 'fujfjupfpj@dfahfu', 'fjiafhfoihafhahfu'),
(11, 'gfzaihjgfiaj hjgaigiuhj', 'gizgjgrijzg@gughru', 'gjzigjrjghzihjz'),
(12, 'gfzaihjgfiaj hjgaigiuhjghgg', 'gizgjgrijzg@gughruddd', 'gagiujaàçgua_gur_afhjfeaphfr'),
(13, 'gfzaihjgfiaj hjgaigiuhjghggddd', 'gizgjgrijzg@gughrudddddd', 'gagiujaàçgua_gur_afhjfeaphfr'),
(14, 'gfzaihjgfiaj hjgaigiuhjghggdddfzgzgz', 'gizgjgrijzg@gughrudddddd', 'gagiujaàçgua_gur_afhjfeaphfr'),
(15, 'Makongue Leo', 'olio@pm.com', 'NAGI SAEICHIRO'),
(16, 'Makongue Leo', 'olio@pm.com', 'NAGI SAEICHIRO'),
(17, 'Léo Makongue', 'mkjg@gmail.com', 'ifghzfioezfgz'),
(18, 'Benault Lucas', 'lulu@gmmail.com', 'ifgzhgoizhgi'),
(19, 'Moignon Moi', 'moignon@Com', 'leofhuauhsjdkfk'),
(20, ' ', NULL, NULL),
(21, ' ', NULL, NULL),
(22, 'haddadi nael', 'haddadi.nael@gmail.com', '$2y$12$gXI4XkZCuF/tLtdquJIjruX8EZl5x7/cDoJnSvbuwOj/QlrJifeRK');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `archive_traversee`
--
ALTER TABLE `archive_traversee`
  ADD PRIMARY KEY (`IDTraversee`);

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
-- Index pour la table `disposer`
--
ALTER TABLE `disposer`
  ADD KEY `IDBateau` (`IDBateau`,`idEquip`),
  ADD KEY `idEquip` (`idEquip`);

--
-- Index pour la table `enregistrer`
--
ALTER TABLE `enregistrer`
  ADD PRIMARY KEY (`IDType`,`IDReservation`),
  ADD KEY `IDReservation` (`IDReservation`);

--
-- Index pour la table `equipement`
--
ALTER TABLE `equipement`
  ADD PRIMARY KEY (`idEquipement`);

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
-- AUTO_INCREMENT pour la table `equipement`
--
ALTER TABLE `equipement`
  MODIFY `idEquipement` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gestionnaire`
--
ALTER TABLE `gestionnaire`
  MODIFY `IDGestionnaire` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  MODIFY `IDReservation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT pour la table `secteur`
--
ALTER TABLE `secteur`
  MODIFY `IDSecteur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `tarif`
--
ALTER TABLE `tarif`
  MODIFY `IdTarif` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT pour la table `traversee`
--
ALTER TABLE `traversee`
  MODIFY `IDTraversee` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT pour la table `type`
--
ALTER TABLE `type`
  MODIFY `IDType` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `IdUtilisateur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

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
-- Contraintes pour la table `disposer`
--
ALTER TABLE `disposer`
  ADD CONSTRAINT `disposer_ibfk_1` FOREIGN KEY (`IDBateau`) REFERENCES `bateau` (`IDBateau`),
  ADD CONSTRAINT `disposer_ibfk_2` FOREIGN KEY (`idEquip`) REFERENCES `equipement` (`idEquipement`);

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
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`IDTraversee`) REFERENCES `traversee` (`IDTraversee`) ON DELETE CASCADE;

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
