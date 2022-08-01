<html>
  <head>
    <title>Сотрудники кафедры АСОИУ</title>
    <link rel="stylesheet" type="text/css" href="main.css">
    <link rel="stylesheet" type="text/css" href="employees.css">
  </head>
  <body>
    <?php include "body/StartBody.inc"; ?>
    <!--Content Start-->
    <?php
      include "functions/employees.inc";
      include "functions/Variables.inc";
      $Empl = new TEmployees;
      $Var = new Variables;
      $emp = $Var->GetID('emp');
      if($emp == -1)
        $Empl->EmployeesList();
      else
        $Empl->EmployeesInfo($emp);
      unset($Var);
      unset($Empl);
    ?>
    <!--Content End-->
    <?php include "body/EndBody.inc"; ?>
  </body>
</html>
