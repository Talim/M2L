<?php

  $lesAteliers = getLesAteliers($conn);

  if(!isset ($idAtelier))
  {
    $idAtelier = 1;
  }
  $requete =  $conn->prepare("select NBTS,NBS,NBMS,NBPS from MDL.STATISTIQUE inner join MDL.ATELIER on MDL.STATISTIQUE.id = MDL.ATELIER.idStatistique where MDL.ATELIER.id = ".$idAtelier);
  $requete->execute();
  $result = $requete->fetch(PDO::FETCH_ASSOC);
  $nbAvisTs = $result['NBTS'];
  $nbAvisS = $result['NBS'];
  $nbAvisMs = $result['NBMS'];
  $nbAvisPs = $result['NBPS'];

  include("../view/v_avis.php");

 ?>
