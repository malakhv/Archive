<html>
  <head>
    <title>������� ������ ������� �����</title>
    <link rel="stylesheet" type="text/css" href="main.css">
    <link rel="stylesheet" type="text/css" href="disciplines.css">
  </head>
  <body>
    <?php include "body/StartBody.inc"; ?>
    <!--Content Start-->
    <?php
      include "functions/disciplines.inc";
      include "functions/Variables.inc";
      echo '<h1>����������, ������������� �� �������</h1>';
      $Dis = new TDisciplines;
      $Dis->DisciplinesList();
    ?>
    <!--Content End-->
    <?php include "body/EndBody.inc"; ?>
  </body>
</html>



