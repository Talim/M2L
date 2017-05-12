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


?>
