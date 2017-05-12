<?php
    include '../model/bdd.php';
    session_start();
    $conn = connetion($_SESSION['login'],$_SESSION['password']);
    $idAtelier =  $_POST['selectAtelier'];
    $nbAvisTs =$_POST['avisTs'];
    $nbAvisS =  $_POST['avisS'];
    $nbAvisMs = $_POST['avisMs'];
    $nbAvisPs = $_POST['avisPs'];

    $requete =  $conn->prepare("select NBTS,NBS,NBMS,NBPS from MDL.STATISTIQUE inner join MDL.ATELIER on MDL.STATISTIQUE.id = MDL.ATELIER.idStatistique where MDL.ATELIER.id = ".$idAtelier);
    $requete->execute();
    $result = $requete->fetch(PDO::FETCH_ASSOC);
    $nbAvisTs += $result['NBTS'];
    $nbAvisS += $result['NBS'];
    $nbAvisMs += $result['NBMS'];
    $nbAvisPs += $result['NBPS'];

    $conn->query("update MDL.STATISTIQUE set NBTS ='".$nbAvisTs."',NBS ='".$nbAvisS."',NBMS ='".$nbAvisMs."',NBPS ='".$nbAvisPs."' where ID ='".$idAtelier."'");

    include("c_avis.php");


 ?>
