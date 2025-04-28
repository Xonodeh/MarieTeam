-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : lun. 28 avr. 2025 à 12:39
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
(2, 1, 15),
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
  `IDReservation` int(11) NOT NULL,
  `NbPassager` int(11) DEFAULT 0,
  `NbVehiculeInf2m` int(11) DEFAULT 0,
  `NbVehiculeSup2m` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `enregistrer`
--

INSERT INTO `enregistrer` (`IDReservation`, `NbPassager`, `NbVehiculeInf2m`, `NbVehiculeSup2m`) VALUES
(108, 25, 5, 10),
(109, 5, 6, 15),
(110, 0, 3, 26),
(111, 1, 2, 0);

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
(4, 450, 4, 5, 4),
(5, 200, 1, 3, 2),
(12, 150, 6, 7, 4),
(14, 100, 1, 1, 1),
(15, 100, 2, 3, 1);

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
(5, 'Cannes'),
(6, 'Port-Navalo'),
(7, 'Le Palais');

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
(100, 'Test Client', '123 Rue Test', 75000, 'Paris', 1, 100),
(101, 'haddadi nael', 'haddadi.nael@gmail.com', 59150, 'wattrelos', 22, 1),
(102, 'haddadi nael', 'haddadi.nael@gmail.com', 59150, 'wattrelos', 22, 1),
(103, 'Moignon Moi', 'test', 59200, 'test', 19, 2),
(105, 'Léo Makongue', 'test', 59000, 'tourcoing', 5, 2),
(106, 'Léo Makongue', 'test', 59000, 'test', 5, 2),
(107, 'Léo Makongue', 'test', 59000, 'test', 5, 2),
(108, 'Benault Lucas', 'test', 59000, 'test', 18, 2),
(109, 'Moi Moignon', '59100', 59100, 'Roubaix', 23, 2),
(110, 'Moi Moignon', 'montargie', 54677, 'Annecy', 23, 2),
(111, 'haddadi nael', 'rue du zeub', 59100, 'ZGEG', 22, 104);

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
  `IDLiaison` int(11) NOT NULL,
  `IDType` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `tarif`
--

INSERT INTO `tarif` (`IdTarif`, `Prix`, `IDPeriode`, `IDLiaison`, `IDType`) VALUES
(100, 20.00, 1, 1, 1),
(101, 18.00, 2, 1, 1),
(102, 19.00, 3, 1, 1),
(103, 13.10, 1, 1, 2),
(104, 11.10, 2, 1, 2),
(105, 12.10, 3, 1, 2),
(106, 7.00, 1, 1, 3),
(107, 5.60, 2, 1, 3),
(108, 6.40, 3, 1, 3),
(109, 95.00, 1, 1, 4),
(110, 86.00, 2, 1, 4),
(111, 91.00, 3, 1, 4),
(112, 142.00, 1, 1, 5),
(113, 129.00, 2, 1, 5),
(114, 136.00, 3, 1, 5),
(115, 208.00, 1, 1, 6),
(116, 189.00, 2, 1, 6),
(117, 199.00, 3, 1, 6),
(118, 226.00, 1, 1, 7),
(119, 205.00, 2, 1, 7),
(120, 216.00, 3, 1, 7),
(121, 295.00, 1, 1, 8),
(122, 268.00, 2, 1, 8),
(123, 282.00, 3, 1, 8),
(124, 28.00, 1, 4, 1),
(125, 26.00, 2, 4, 1),
(126, 27.00, 3, 4, 1),
(127, 19.60, 1, 4, 2),
(128, 16.60, 2, 4, 2),
(129, 17.60, 3, 4, 2),
(130, 11.00, 1, 4, 3),
(131, 9.60, 2, 4, 3),
(132, 10.40, 3, 4, 3),
(133, 118.00, 1, 4, 4),
(134, 109.00, 2, 4, 4),
(135, 114.00, 3, 4, 4),
(136, 176.00, 1, 4, 5),
(137, 163.00, 2, 4, 5),
(138, 170.00, 3, 4, 5),
(139, 257.00, 1, 4, 6),
(140, 238.00, 2, 4, 6),
(141, 248.00, 3, 4, 6),
(142, 282.00, 1, 4, 7),
(143, 261.00, 2, 4, 7),
(144, 272.00, 3, 4, 7),
(145, 369.00, 1, 4, 8),
(146, 342.00, 2, 4, 8),
(147, 356.00, 3, 4, 8),
(148, 20.00, 1, 2, 1),
(149, 18.00, 2, 2, 1),
(150, 19.00, 3, 2, 1),
(151, 13.10, 1, 2, 2),
(152, 11.10, 2, 2, 2),
(153, 12.10, 3, 2, 2),
(154, 7.00, 1, 2, 3),
(155, 5.60, 2, 2, 3),
(156, 6.40, 3, 2, 3),
(157, 103.00, 1, 2, 4),
(158, 94.00, 2, 2, 4),
(159, 99.00, 3, 2, 4),
(160, 154.00, 1, 2, 5),
(161, 140.00, 2, 2, 5),
(162, 147.00, 3, 2, 5),
(163, 226.00, 1, 2, 6),
(164, 205.00, 2, 2, 6),
(165, 216.00, 3, 2, 6),
(166, 247.00, 1, 2, 7),
(167, 225.00, 2, 2, 7),
(168, 236.00, 3, 2, 7),
(169, 322.00, 1, 2, 8),
(170, 293.00, 2, 2, 8),
(171, 308.00, 3, 2, 8),
(172, 23.00, 1, 3, 1),
(173, 21.00, 2, 3, 1),
(174, 22.00, 3, 3, 1),
(175, 15.10, 1, 3, 2),
(176, 13.10, 2, 3, 2),
(177, 14.10, 3, 3, 2),
(178, 8.00, 1, 3, 3),
(179, 6.60, 2, 3, 3),
(180, 7.40, 3, 3, 3),
(181, 109.00, 1, 3, 4),
(182, 99.00, 2, 3, 4),
(183, 104.00, 3, 3, 4),
(184, 164.00, 1, 3, 5),
(185, 149.00, 2, 3, 5),
(186, 156.00, 3, 3, 5),
(187, 239.00, 1, 3, 6),
(188, 216.00, 2, 3, 6),
(189, 227.00, 3, 3, 6),
(190, 263.00, 1, 3, 7),
(191, 240.00, 2, 3, 7),
(192, 251.00, 3, 3, 7),
(193, 342.00, 1, 3, 8),
(194, 311.00, 2, 3, 8),
(195, 326.00, 3, 3, 8),
(196, 28.00, 1, 4, 1),
(197, 26.00, 2, 4, 1),
(198, 27.00, 3, 4, 1),
(199, 19.60, 1, 4, 2),
(200, 16.60, 2, 4, 2),
(201, 17.60, 3, 4, 2),
(202, 11.00, 1, 4, 3),
(203, 9.60, 2, 4, 3),
(204, 10.40, 3, 4, 3),
(205, 118.00, 1, 4, 4),
(206, 109.00, 2, 4, 4),
(207, 114.00, 3, 4, 4),
(208, 176.00, 1, 4, 5),
(209, 163.00, 2, 4, 5),
(210, 170.00, 3, 4, 5),
(211, 257.00, 1, 4, 6),
(212, 238.00, 2, 4, 6),
(213, 248.00, 3, 4, 6),
(214, 282.00, 1, 4, 7),
(215, 261.00, 2, 4, 7),
(216, 272.00, 3, 4, 7),
(217, 369.00, 1, 4, 8),
(218, 342.00, 2, 4, 8),
(219, 356.00, 3, 4, 8);

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
-- Structure de la table `traversee`
--

CREATE TABLE `traversee` (
  `IDTraversee` int(11) NOT NULL,
  `DateTraversee` date DEFAULT NULL,
  `HeureTraversee` time DEFAULT NULL,
  `IDBateau` int(11) NOT NULL,
  `IDLiaison` int(11) NOT NULL,
  `places_passagers` int(11) DEFAULT NULL,
  `veh_inf_2m` int(11) DEFAULT NULL,
  `veh_sup_2m` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `traversee`
--

INSERT INTO `traversee` (`IDTraversee`, `DateTraversee`, `HeureTraversee`, `IDBateau`, `IDLiaison`, `places_passagers`, `veh_inf_2m`, `veh_sup_2m`) VALUES
(1, '2025-06-15', '12:00:00', 1, 1, NULL, 500, 400),
(2, '2025-07-10', '14:00:00', 2, 2, 0, 2946, 449),
(3, '2025-06-20', '16:30:00', 3, 3, NULL, 2800, 350),
(4, '2025-08-05', '10:00:00', 4, 4, NULL, 2200, 300),
(100, '2025-12-05', '10:00:00', 1, 1, NULL, 500, 400),
(102, '2025-04-29', '18:12:00', 2, 12, 15, 3000, 500),
(104, '2025-04-27', '17:01:00', 3, 4, 364, 18, 30);

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
(22, 'haddadi nael', 'haddadi.nael@gmail.com', '$2y$12$gXI4XkZCuF/tLtdquJIjruX8EZl5x7/cDoJnSvbuwOj/QlrJifeRK'),
(23, 'Moi Moignon', 'moignon@moignon', '$2y$10$uIGX6LBdpE7th9aDDiF5MeQPhHAsFEjtFwbmNKDF3b1SxHy3Rj.4i'),
(24, 'test test', 'test@test.com', '$2y$10$3Sk4ubDASX4j5z8cygIhDe0DUG1Ufj4ixhDcO839uMMuCmf.Juuou');

-- --------------------------------------------------------


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
  ADD PRIMARY KEY (`IDReservation`);

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
  ADD KEY `IDType` (`IDType`),
  ADD KEY `tarif_ibfk_3` (`IDLiaison`);

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
-- AUTO_INCREMENT pour la table `enregistrer`
--
ALTER TABLE `enregistrer`
  MODIFY `IDReservation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

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
  MODIFY `IDLiaison` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `periode`
--
ALTER TABLE `periode`
  MODIFY `IDPeriode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `port`
--
ALTER TABLE `port`
  MODIFY `IDPort` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `IDReservation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT pour la table `secteur`
--
ALTER TABLE `secteur`
  MODIFY `IDSecteur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `tarif`
--
ALTER TABLE `tarif`
  MODIFY `IdTarif` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=220;

--
-- AUTO_INCREMENT pour la table `traversee`
--
ALTER TABLE `traversee`
  MODIFY `IDTraversee` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT pour la table `type`
--
ALTER TABLE `type`
  MODIFY `IDType` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `IdUtilisateur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

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
  ADD CONSTRAINT `enregistrer_ibfk_1` FOREIGN KEY (`IDReservation`) REFERENCES `reservation` (`IDReservation`);

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
  ADD CONSTRAINT `tarif_ibfk_2` FOREIGN KEY (`IDType`) REFERENCES `type` (`IDType`),
  ADD CONSTRAINT `tarif_ibfk_3` FOREIGN KEY (`IDLiaison`) REFERENCES `liaison` (`IDLiaison`);

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
