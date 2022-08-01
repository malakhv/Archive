<html>
  <head>
    <title>Разработки кафедры АСОИУ</title>
    <link rel="stylesheet" type="text/css" href="Main.css">
  </head>
  <body>
    <?php include "body/StartBody.inc"; ?>>
    <!--Content Start-->
    <h1>Разработки кафедры</h1>
    <?php
      include "functions/developments.inc";
      include "functions/Variables.inc";
      $Developments = new TDevelopments;
      $Var = new Variables;
      $dev = $Var->GetID('dev');
      if($dev == -1)
        $Developments->DevelopmentsList(false);
    ?>
    <!--Content End-->
    <?php include "body/EndBody.inc"; ?>
  </body>
</html>
