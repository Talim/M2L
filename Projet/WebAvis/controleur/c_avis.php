<?php

  $lesAteliers = getLesAteliers($conn);

  if(!isset ($idAtelier))
  {
    $idAtelier = 1;
  }

  $result = getLesStats($idAtelier, $conn);
  $nbAvisTs = $result['NBTS'];
  $nbAvisS = $result['NBS'];
  $nbAvisMs = $result['NBMS'];
  $nbAvisPs = $result['NBPS'];

  include("../view/v_avis.php");

 ?>
