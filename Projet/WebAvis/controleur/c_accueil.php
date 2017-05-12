<?php

include '../model/bdd.php';
session_start();
if(!isset($_SESSION['login'])){
$_SESSION['login'] = $_POST['login'];
$_SESSION['password'] = $_POST['password'];
}

$conn = connetion($_SESSION['login'],$_SESSION['password']);
if($conn){
  if($_REQUEST['action'] == 'loadAtelier'){
    include("c_avis.php");
  }else if($_REQUEST['action'] == 'majAtelier'){
    include ("c_avisPost.php");
  }
}
else {
  header("Location: ../index.php");
}
?>
