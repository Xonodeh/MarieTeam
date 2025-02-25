<?php

function inscription($pdo, $id,$prenomNom, $login , $mdp)
{
    $sql="INSERT INTO Utilisateur (IdUtilisateur ,NomUtilisateur, LogUtilisateur, MdpUtilisateur) VALUES (:Id ,:leNom, :leLogin, :leMdp)";

    try {
        $stmt = $pdo->prepare($sql);
        $executionOK = $stmt->execute([
            ':Id' => $id,
            ':leNom' => $prenomNom,
            ':leLogin' => $login,
            ':leMdp' => $mdp,
        ]);

        return $executionOK ;
    }

    catch (PDOException $e) {
        echo 'Connexion échouée : ' . $e->getMessage();
    } catch (Exception $e) {
        echo $e->getMessage();
    }
}