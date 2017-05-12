<?php
    include '../model/bdd.php';
    session_start();
    $conn = connetion($_SESSION['login'],$_SESSION['password']);
    $idAtelier =  $_POST['selectAtelier'];
    $nbAvisTs =$_POST['avisTs'];
    $nbAvisS =  $_POST['avisS'];
    $nbAvisMs = $_POST['avisMs'];
    $nbAvisPs = $_POST['avisPs'];

    $result = getLesStats($idAtelier, $conn);
    $nbAvisTs += $result['NBTS'];
    $nbAvisS += $result['NBS'];
    $nbAvisMs += $result['NBMS'];
    $nbAvisPs += $result['NBPS'];

    updateLesStats($conn,$nbAvisTs,$nbAvisS,$nbAvisMs,$nbAvisPs,$idAtelier);

    include("c_avis.php");


 ?>
