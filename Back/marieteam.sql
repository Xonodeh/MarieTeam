-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 04 déc. 2024 à 09:22
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
-- Base de données : `marieteam`
--

-- --------------------------------------------------------

--
-- Structure de la table `bateau`
--

CREATE TABLE `bateau` (
  `IDBateau` varchar(50) NOT NULL,
  `nomBateau` varchar(50) DEFAULT NULL,
  `LongueurBateau` decimal(15,2) DEFAULT NULL,
  `VitesseBateau` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE `categorie` (
  `IdCategorie` varchar(50) NOT NULL,
  `NomCategorie` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `categoriser`
--

CREATE TABLE `categoriser` (
  `IDBateau` varchar(50) NOT NULL,
  `IdCategorie` varchar(50) NOT NULL,
  `Capacite` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `enregistrer`
--

CREATE TABLE `enregistrer` (
  `IDType` varchar(50) NOT NULL,
  `IDReservation` varchar(50) NOT NULL,
  `NbPassager` int(11) DEFAULT NULL,
  `NbVehicule` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `gestionnaire`
--

CREATE TABLE `gestionnaire` (
  `IDGestionnaire` varchar(50) NOT NULL,
  `NomGestionnaire` varchar(50) DEFAULT NULL,
  `LogGestionnaire` varchar(50) DEFAULT NULL,
  `MdpGestionnaire` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `liaison`
--

CREATE TABLE `liaison` (
  `IDLiaison` varchar(50) NOT NULL,
  `CodeLiaison` varchar(50) DEFAULT NULL,
  `Distance` int(11) DEFAULT NULL,
  `IDPort` varchar(50) NOT NULL,
  `IDPort_1` varchar(50) NOT NULL,
  `IDSecteur` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `periode`
--

CREATE TABLE `periode` (
  `IDPeriode` varchar(50) NOT NULL,
  `NomPeriode` varchar(50) DEFAULT NULL,
  `DateDebutPeriode` date DEFAULT NULL,
  `DateFinPeriode` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `port`
--

CREATE TABLE `port` (
  `IDPort` varchar(50) NOT NULL,
  `LibPort` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

CREATE TABLE `reservation` (
  `IDReservation` varchar(50) NOT NULL,
  `NomClient` varchar(50) DEFAULT NULL,
  `AdresseClient` varchar(50) DEFAULT NULL,
  `CPClient` int(11) DEFAULT NULL,
  `VilleClient` varchar(50) DEFAULT NULL,
  `IdUtilisateur` varchar(50) NOT NULL,
  `IDTraversee` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `secteur`
--

CREATE TABLE `secteur` (
  `IDSecteur` varchar(50) NOT NULL,
  `LibSecteur` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `tarif`
--

CREATE TABLE `tarif` (
  `IdTarif` varchar(50) NOT NULL,
  `Prix` decimal(15,2) DEFAULT NULL,
  `IDPeriode` varchar(50) NOT NULL,
  `IDType` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `tarifer`
--

CREATE TABLE `tarifer` (
  `IDLiaison` varchar(50) NOT NULL,
  `IdTarif` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `traversee`
--

CREATE TABLE `traversee` (
  `IDTraversee` varchar(50) NOT NULL,
  `DateTraversee` date DEFAULT NULL,
  `HeureTraversee` time DEFAULT NULL,
  `IDBateau` varchar(50) NOT NULL,
  `IDLiaison` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

CREATE TABLE `type` (
  `IDType` varchar(50) NOT NULL,
  `TypePassager` varchar(50) DEFAULT NULL,
  `TypeVehicule` varchar(50) DEFAULT NULL,
  `IdCategorie` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `IdUtilisateur` varchar(50) NOT NULL,
  `NomUtilisateur` varchar(50) DEFAULT NULL,
  `LogUtilisateur` varchar(50) DEFAULT NULL,
  `MdpUtilisateur` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
