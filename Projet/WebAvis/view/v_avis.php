<html>

<head>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/css/materialize.min.css">
  <link rel="stylesheet" type="text/css" href="../css/style.css">
</head>

<body>

  <nav>
    <div class="nav-wrapper">
      
        <img src="../view/image/m2l.png" style="width:100px;height:64px;" >

      <ul id="nav-mobile" class="right hide-on-med-and-down">
        <li><a href="v_avis.php">Avis</a></li>
      </ul>
    </div>
  </nav>

  <center>
    <div class="container">
      <h4>Maison des ligues de Lorraine</h4>
      <div class="card-panel">
        <h5 class="header2">Sondage : Avis des ateliers</h5>


        <form action="../controleur/c_avisPost.php" method="post">
            <div class="row">

              <div class="row valign-wrapper">


            <div class="input-field col s3">
              <select id="selectAtelier" name="selectAtelier">
                <option value="" disabled selected>Choisir un atelier</option>
                <?php
                  foreach ($lesAteliers as $unAtelier) {
                    echo "<option value=\"".$unAtelier['ID']."\">".$unAtelier['LIBELLEATELIER']."</option>";
                  }
                 ?>
              </select>
            </div>
            <div class="col s1">
            </div>
            </div>

            </div>

          <div class="row">
          <div class="row valign-wrapper">
            <div class="input-field col s6">
              <input placeholder="Veuillez indiquer le nombre d'avis à ajouter" name="avisTs" id="avisTs" type="number" class="validate" required>
              <label for="first_name">Nombre avis très satisfait</label>
            </div>
            <div class="col s4 ">
              Avis actuel : <?php echo $nbAvisTs ?>
            </div>
          </div>

          <div class="row valign-wrapper">
            <div class="input-field col s6">
              <input placeholder="Veuillez indiquer le nombre d'avis à ajouter" name="avisS" id="avisS" type="number" class="validate" required>
              <label for="first_name">Nombre avis satisfait</label>
            </div>
            <div class="col s4 ">
              Avis actuel : <?php echo $nbAvisS ?>
            </div>
          </div>
          <div class="row valign-wrapper">
            <div class="input-field col s6">
              <input placeholder="Veuillez indiquer le nombre d'avis à ajouter" name="avisMs" id="avisMs" type="number" class="validate" required>
              <label for="first_name">Nombre avis moyennement satisfait</label>
            </div>
            <div class="col s4 ">
              Avis actuel : <?php echo $nbAvisMs ?>
            </div>
          </div>
          <div class="row valign-wrapper">
            <div class="input-field col s6">
              <input placeholder="Veuillez indiquer le nombre d'avis à ajouter" name="avisPs" id="avisPs" type="number" class="validate" required>
              <label for="first_name">Nombre avis  pas du tout satisfait</label>
            </div>
            <div class="col s4 ">
              Avis actuel : <?php echo $nbAvisPs ?>
            </div>
          </div>

          <button class="btn waves-effect waves-light" type="submit" name="action" id="sendAvis">Envoyer
            <i class="material-icons right">send</i>
          </button>
        </form>
        </div>
      </div>
    </div>
  </center>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.1/jquery.min.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/js/materialize.min.js"></script>
  <script type="text/javascript" src="../view/js/init.js"></script>
</body>

</html>
