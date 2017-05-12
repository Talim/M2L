<?php


function connetion($db_username,$db_password){
$tns = "
(DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = freesio.lyc-bonaparte.fr)(PORT = 15211))
    )
    (CONNECT_DATA =
      (SERVICE_NAME = xe)
    )
  )
       ";

try{
    $conn = new PDO("oci:dbname=".$tns,$db_username,$db_password);
    return $conn;
}catch(PDOException $e){
    echo ($e->getMessage());
}
}

function getLesAteliers($connexion){
  return $connexion->query("select * from atelier");
}

function getLesStats($idAtelier,$conn){
  $requete =  $conn->prepare("select NBTS,NBS,NBMS,NBPS from MDL.STATISTIQUE inner join MDL.ATELIER on MDL.STATISTIQUE.id = MDL.ATELIER.idStatistique where MDL.ATELIER.id = ".$idAtelier);
  $requete->execute();
  return $requete->fetch(PDO::FETCH_ASSOC);
}

function updateLesStats($conn,$nbAvisTs,$nbAvisS,$nbAvisMs,$nbAvisPs,$idAtelier){
  $conn->query("update MDL.STATISTIQUE set NBTS ='".$nbAvisTs."',NBS ='".$nbAvisS."',NBMS ='".$nbAvisMs."',NBPS ='".$nbAvisPs."' where ID ='".$idAtelier."'");

}


?>
