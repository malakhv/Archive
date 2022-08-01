<html>
<head>
  <title>МОУ СОШ № 19 Новости</title>
  <link rel="stylesheet" type="text/css" href="main.css">
</head>
<body>
  <?php
    include "body/BStart.inc";
    include "function/Variables.inc";
    
    $Var = new Variables;
    $id = $Var->GetID('id');
    if($id > 0)
    {
      $News = new TNews;
      $News->News_id = $id;
      $News->GetNewsInfo();
      $News->CloseQuery();
      unset($News);
      unset($id);
    }
    else
      echo '<h3>Нет данных</h3>';
  ?>

  <?php
    include "body/BEnd.inc";
  ?>
</body>
</html>




