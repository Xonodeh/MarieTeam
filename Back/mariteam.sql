-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mer. 15 jan. 2025 à 10:48
-- Version du serveur : 10.3.39-MariaDB-0+deb10u1
-- Version de PHP : 8.2.7

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
-- Structure de la table `Bateau`
--

CREATE TABLE `Bateau` (
  `IDBateau` varchar(50) NOT NULL,
  `nomBateau` varchar(50) DEFAULT NULL,
  `LongueurBateau` decimal(15,2) DEFAULT NULL,
  `VitesseBateau` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Bateau`
--

INSERT INTO `Bateau` (`IDBateau`, `nomBateau`, `LongueurBateau`, `VitesseBateau`) VALUES
('B001', 'Maëllys', 45.50, 20.50),
('B002', 'Kor Ant', 50.00, 25.00),
('B003', 'Ar Solen', 30.00, 18.00);

-- --------------------------------------------------------

--
-- Structure de la table `Categorie`
--

CREATE TABLE `Categorie` (
  `IdCategorie` varchar(50) NOT NULL,
  `NomCategorie` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Categorie`
--

INSERT INTO `Categorie` (`IdCategorie`, `NomCategorie`) VALUES
('A', 'Passager'),
('B', 'Véh.inf.2m'),
('C', 'Véh.sup.2m');

-- --------------------------------------------------------

--
-- Structure de la table `Categoriser`
--

CREATE TABLE `Categoriser` (
  `IDBateau` varchar(50) NOT NULL,
  `IdCategorie` varchar(50) NOT NULL,
  `Capacite` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Categoriser`
--

INSERT INTO `Categoriser` (`IDBateau`, `IdCategorie`, `Capacite`) VALUES
('B001', 'A', 250),
('B001', 'B', 30),
('B001', 'C', 10);

-- --------------------------------------------------------

--
-- Structure de la table `Enregistrer`
--

CREATE TABLE `Enregistrer` (
  `IDType` varchar(50) NOT NULL,
  `IDReservation` varchar(50) NOT NULL,
  `nb` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Enregistrer`
--

INSERT INTO `Enregistrer` (`IDType`, `IDReservation`, `nb`) VALUES
('A1', 'R001', 2),
('B1', 'R002', 1);

-- --------------------------------------------------------

--
-- Structure de la table `Gestionnaire`
--

CREATE TABLE `Gestionnaire` (
  `IDGestionnaire` varchar(50) NOT NULL,
  `NomGestionnaire` varchar(50) DEFAULT NULL,
  `LogGestionnaire` varchar(50) DEFAULT NULL,
  `MdpGestionnaire` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Gestionnaire`
--

INSERT INTO `Gestionnaire` (`IDGestionnaire`, `NomGestionnaire`, `LogGestionnaire`, `MdpGestionnaire`) VALUES
('G001', 'Admin1', 'admin1', 'password123'),
('G002', 'Admin2', 'admin2', 'securePass456');

-- --------------------------------------------------------

--
-- Structure de la table `Liaison`
--

CREATE TABLE `Liaison` (
  `IDLiaison` varchar(50) NOT NULL,
  `CodeLiaison` varchar(50) DEFAULT NULL,
  `Distance` int(11) DEFAULT NULL,
  `IDPort` varchar(50) NOT NULL,
  `IDPort_1` varchar(50) NOT NULL,
  `IDSecteur` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Liaison`
--

INSERT INTO `Liaison` (`IDLiaison`, `CodeLiaison`, `Distance`, `IDPort`, `IDPort_1`, `IDSecteur`) VALUES
('L001', '15', 8, 'P001', 'P002', 'S001'),
('L002', '19', 23, 'P003', 'P002', 'S001');

-- --------------------------------------------------------

--
-- Structure de la table `Periode`
--

CREATE TABLE `Periode` (
  `IDPeriode` varchar(50) NOT NULL,
  `NomPeriode` varchar(50) DEFAULT NULL,
  `DateDebutPeriode` date DEFAULT NULL,
  `DateFinPeriode` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Periode`
--

INSERT INTO `Periode` (`IDPeriode`, `NomPeriode`, `DateDebutPeriode`, `DateFinPeriode`) VALUES
('P001', '01/09/2023 - 15/06/2024', '2023-09-01', '2024-06-15'),
('P002', '16/06/2024 - 15/09/2024', '2024-06-16', '2024-09-15'),
('P003', '16/09/2024 - 31/05/2025', '2024-09-16', '2025-05-31');

-- --------------------------------------------------------

--
-- Structure de la table `Port`
--

CREATE TABLE `Port` (
  `IDPort` varchar(50) NOT NULL,
  `LibPort` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Port`
--

INSERT INTO `Port` (`IDPort`, `LibPort`) VALUES
('P001', 'Quiberon'),
('P002', 'Le Palais'),
('P003', 'Vannes');

-- --------------------------------------------------------

--
-- Structure de la table `Reservation`
--

CREATE TABLE `Reservation` (
  `IDReservation` varchar(50) NOT NULL,
  `NomClient` varchar(50) DEFAULT NULL,
  `AdresseClient` varchar(50) DEFAULT NULL,
  `CPClient` int(11) DEFAULT NULL,
  `VilleClient` varchar(50) DEFAULT NULL,
  `IdUtilisateur` varchar(50) NOT NULL,
  `IDTraversee` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Reservation`
--

INSERT INTO `Reservation` (`IDReservation`, `NomClient`, `AdresseClient`, `CPClient`, `VilleClient`, `IdUtilisateur`, `IDTraversee`) VALUES
('R001', 'Jean Dupont', '123 Rue de Paris', 75001, 'Paris', 'U001', 'T001'),
('R002', 'Marie Curie', '456 Avenue de Lyon', 69001, 'Lyon', 'U002', 'T002');

-- --------------------------------------------------------

--
-- Structure de la table `Secteur`
--

CREATE TABLE `Secteur` (
  `IDSecteur` varchar(50) NOT NULL,
  `LibSecteur` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Secteur`
--

INSERT INTO `Secteur` (`IDSecteur`, `LibSecteur`) VALUES
('S001', 'Belle-Île-en-Mer'),
('S002', 'Ile de Groix');

-- --------------------------------------------------------

--
-- Structure de la table `Tarif`
--

CREATE TABLE `Tarif` (
  `IdTarif` varchar(50) NOT NULL,
  `Prix` decimal(15,2) DEFAULT NULL,
  `IDPeriode` varchar(50) NOT NULL,
  `IDType` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Tarif`
--

INSERT INTO `Tarif` (`IdTarif`, `Prix`, `IDPeriode`, `IDType`) VALUES
('TA001', 18.00, 'P001', 'A1'),
('TA002', 11.10, 'P001', 'A2'),
('TA003', 5.60, 'P001', 'A3'),
('TA004', 20.00, 'P002', 'A1'),
('TA005', 13.10, 'P002', 'A2'),
('TA006', 7.00, 'P002', 'A3'),
('TA007', 19.00, 'P003', 'A1'),
('TA008', 12.10, 'P003', 'A2'),
('TA009', 6.40, 'P003', 'A3'),
('TB001', 86.00, 'P001', 'B1'),
('TB002', 129.00, 'P001', 'B2'),
('TB003', 95.00, 'P002', 'B1'),
('TB004', 142.00, 'P002', 'B2'),
('TB005', 91.00, 'P003', 'B1'),
('TB006', 136.00, 'P003', 'B2'),
('TC001', 189.00, 'P001', 'C1'),
('TC002', 205.00, 'P001', 'C2'),
('TC003', 268.00, 'P001', 'C3'),
('TC004', 208.00, 'P002', 'C1'),
('TC005', 226.00, 'P002', 'C2'),
('TC006', 295.00, 'P002', 'C3'),
('TC007', 199.00, 'P003', 'C1'),
('TC008', 216.00, 'P003', 'C2'),
('TC009', 282.00, 'P003', 'C3');

-- --------------------------------------------------------

--
-- Structure de la table `Tarifer`
--

CREATE TABLE `Tarifer` (
  `IDLiaison` varchar(50) NOT NULL,
  `IdTarif` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Tarifer`
--

INSERT INTO `Tarifer` (`IDLiaison`, `IdTarif`) VALUES
('L001', 'TA001'),
('L001', 'TA002'),
('L001', 'TA003'),
('L001', 'TB001'),
('L001', 'TB002'),
('L001', 'TC001'),
('L001', 'TC002'),
('L001', 'TC003'),
('L002', 'TA004'),
('L002', 'TB003'),
('L002', 'TC004');

-- --------------------------------------------------------

--
-- Structure de la table `Traversee`
--

CREATE TABLE `Traversee` (
  `IDTraversee` varchar(50) NOT NULL,
  `DateTraversee` date DEFAULT NULL,
  `HeureTraversee` time DEFAULT NULL,
  `IDBateau` varchar(50) NOT NULL,
  `IDLiaison` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Traversee`
--

INSERT INTO `Traversee` (`IDTraversee`, `DateTraversee`, `HeureTraversee`, `IDBateau`, `IDLiaison`) VALUES
('T001', '2024-07-10', '07:45:00', 'B001', 'L001'),
('T002', '2024-07-10', '10:00:00', 'B002', 'L002');

-- --------------------------------------------------------

--
-- Structure de la table `Type`
--

CREATE TABLE `Type` (
  `IDType` varchar(50) NOT NULL,
  `TypePassager` varchar(50) DEFAULT NULL,
  `TypeVehicule` varchar(50) DEFAULT NULL,
  `IdCategorie` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Type`
--

INSERT INTO `Type` (`IDType`, `TypePassager`, `TypeVehicule`, `IdCategorie`) VALUES
('A1', 'Adulte', NULL, 'A'),
('A2', 'Junior 8 à 18 ans', NULL, 'A'),
('A3', 'Enfant 0 à 7 ans', NULL, 'A'),
('B1', NULL, 'Voiture long.inf.4m', 'B'),
('B2', NULL, 'Voiture long.inf.5m', 'B'),
('C1', NULL, 'Fourgon', 'C'),
('C2', NULL, 'Camping Car', 'C'),
('C3', NULL, 'Camion', 'C');

-- --------------------------------------------------------

--
-- Structure de la table `Utilisateur`
--

CREATE TABLE `Utilisateur` (
  `IdUtilisateur` varchar(50) NOT NULL,
  `NomUtilisateur` varchar(50) DEFAULT NULL,
  `LogUtilisateur` varchar(50) DEFAULT NULL,
  `MdpUtilisateur` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Utilisateur`
--

INSERT INTO `Utilisateur` (`IdUtilisateur`, `NomUtilisateur`, `LogUtilisateur`, `MdpUtilisateur`) VALUES
('U001', 'Jean Dupont', 'jeandupont', 'pass1234'),
('U002', 'Marie Curie', 'mariecurie', 'securepass');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Bateau`
--
ALTER TABLE `Bateau`
  ADD PRIMARY KEY (`IDBateau`);

--
-- Index pour la table `Categorie`
--
ALTER TABLE `Categorie`
  ADD PRIMARY KEY (`IdCategorie`);

--
-- Index pour la table `Categoriser`
--
ALTER TABLE `Categoriser`
  ADD PRIMARY KEY (`IDBateau`,`IdCategorie`),
  ADD KEY `IdCategorie` (`IdCategorie`);

--
-- Index pour la table `Enregistrer`
--
ALTER TABLE `Enregistrer`
  ADD PRIMARY KEY (`IDType`,`IDReservation`),
  ADD KEY `IDReservation` (`IDReservation`);

--
-- Index pour la table `Gestionnaire`
--
ALTER TABLE `Gestionnaire`
  ADD PRIMARY KEY (`IDGestionnaire`);

--
-- Index pour la table `Liaison`
--
ALTER TABLE `Liaison`
  ADD PRIMARY KEY (`IDLiaison`),
  ADD KEY `IDPort` (`IDPort`),
  ADD KEY `IDPort_1` (`IDPort_1`),
  ADD KEY `IDSecteur` (`IDSecteur`);

--
-- Index pour la table `Periode`
--
ALTER TABLE `Periode`
  ADD PRIMARY KEY (`IDPeriode`);

--
-- Index pour la table `Port`
--
ALTER TABLE `Port`
  ADD PRIMARY KEY (`IDPort`);

--
-- Index pour la table `Reservation`
--
ALTER TABLE `Reservation`
  ADD PRIMARY KEY (`IDReservation`),
  ADD KEY `IdUtilisateur` (`IdUtilisateur`),
  ADD KEY `IDTraversee` (`IDTraversee`);

--
-- Index pour la table `Secteur`
--
ALTER TABLE `Secteur`
  ADD PRIMARY KEY (`IDSecteur`);

--
-- Index pour la table `Tarif`
--
ALTER TABLE `Tarif`
  ADD PRIMARY KEY (`IdTarif`),
  ADD KEY `IDPeriode` (`IDPeriode`),
  ADD KEY `IDType` (`IDType`);

--
-- Index pour la table `Tarifer`
--
ALTER TABLE `Tarifer`
  ADD PRIMARY KEY (`IDLiaison`,`IdTarif`),
  ADD KEY `IdTarif` (`IdTarif`);

--
-- Index pour la table `Traversee`
--
ALTER TABLE `Traversee`
  ADD PRIMARY KEY (`IDTraversee`),
  ADD KEY `IDBateau` (`IDBateau`),
  ADD KEY `IDLiaison` (`IDLiaison`);

--
-- Index pour la table `Type`
--
ALTER TABLE `Type`
  ADD PRIMARY KEY (`IDType`),
  ADD KEY `IdCategorie` (`IdCategorie`);

--
-- Index pour la table `Utilisateur`
--
ALTER TABLE `Utilisateur`
  ADD PRIMARY KEY (`IdUtilisateur`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Categoriser`
--
ALTER TABLE `Categoriser`
  ADD CONSTRAINT `Categoriser_ibfk_1` FOREIGN KEY (`IDBateau`) REFERENCES `Bateau` (`IDBateau`),
  ADD CONSTRAINT `Categoriser_ibfk_2` FOREIGN KEY (`IdCategorie`) REFERENCES `Categorie` (`IdCategorie`);

--
-- Contraintes pour la table `Enregistrer`
--
ALTER TABLE `Enregistrer`
  ADD CONSTRAINT `Enregistrer_ibfk_1` FOREIGN KEY (`IDType`) REFERENCES `Type` (`IDType`),
  ADD CONSTRAINT `Enregistrer_ibfk_2` FOREIGN KEY (`IDReservation`) REFERENCES `Reservation` (`IDReservation`);

--
-- Contraintes pour la table `Liaison`
--
ALTER TABLE `Liaison`
  ADD CONSTRAINT `Liaison_ibfk_1` FOREIGN KEY (`IDPort`) REFERENCES `Port` (`IDPort`),
  ADD CONSTRAINT `Liaison_ibfk_2` FOREIGN KEY (`IDPort_1`) REFERENCES `Port` (`IDPort`),
  ADD CONSTRAINT `Liaison_ibfk_3` FOREIGN KEY (`IDSecteur`) REFERENCES `Secteur` (`IDSecteur`);

--
-- Contraintes pour la table `Reservation`
--
ALTER TABLE `Reservation`
  ADD CONSTRAINT `Reservation_ibfk_1` FOREIGN KEY (`IdUtilisateur`) REFERENCES `Utilisateur` (`IdUtilisateur`),
  ADD CONSTRAINT `Reservation_ibfk_2` FOREIGN KEY (`IDTraversee`) REFERENCES `Traversee` (`IDTraversee`);

--
-- Contraintes pour la table `Tarif`
--
ALTER TABLE `Tarif`
  ADD CONSTRAINT `Tarif_ibfk_1` FOREIGN KEY (`IDPeriode`) REFERENCES `Periode` (`IDPeriode`),
  ADD CONSTRAINT `Tarif_ibfk_2` FOREIGN KEY (`IDType`) REFERENCES `Type` (`IDType`);

--
-- Contraintes pour la table `Tarifer`
--
ALTER TABLE `Tarifer`
  ADD CONSTRAINT `Tarifer_ibfk_1` FOREIGN KEY (`IDLiaison`) REFERENCES `Liaison` (`IDLiaison`),
  ADD CONSTRAINT `Tarifer_ibfk_2` FOREIGN KEY (`IdTarif`) REFERENCES `Tarif` (`IdTarif`);

--
-- Contraintes pour la table `Traversee`
--
ALTER TABLE `Traversee`
  ADD CONSTRAINT `Traversee_ibfk_1` FOREIGN KEY (`IDBateau`) REFERENCES `Bateau` (`IDBateau`),
  ADD CONSTRAINT `Traversee_ibfk_2` FOREIGN KEY (`IDLiaison`) REFERENCES `Liaison` (`IDLiaison`);

--
-- Contraintes pour la table `Type`
--
ALTER TABLE `Type`
  ADD CONSTRAINT `Type_ibfk_1` FOREIGN KEY (`IdCategorie`) REFERENCES `Categorie` (`IdCategorie`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
