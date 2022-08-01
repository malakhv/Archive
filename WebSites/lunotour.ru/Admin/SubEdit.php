<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//RU">
<html>
  <head>
    <title>Подкатегории</title>
    <link rel="stylesheet" type="text/css" href="Admin.css">
  </head>
  <body>
    <?php
      include "../Inc/DBCon.inc";
      include "../Inc/fVar.inc";
      include "fTour.inc";
      
      session_start();
      $user_id = GetSessionVar('s_user_id','');
      if($user_id != '')
      {
        $sub = GetID('sub');
        if($sub != -1)
        {
          $Q = new TQuery;
          $Q->OpenAndSelectDBDefAdmin();
          if($Q->ExecSQL('Select * from `subcat` where `subcat`.id = '.$sub.';'))
          {
            if($Q->RecCount > 0)
            {
              $Q->FieldFirst();
              ?>
                <h1><?php echo $Q->Row->Name;?></h1>
                <form action="Tour.php?cat=<?php echo $Q->Row->Cat_id; ?>" method="post">
                  <input name="save_sub" type="hidden" value="<?php echo $Q->Row->id; ?>">
                  <input name="cat_id" type="hidden" value="<?php echo $Q->Row->Cat_id; ?>">
                  <input name="rang" type="hidden" value="<?php echo $Q->Row->Rang; ?>">
                  <input name="name" type="text" value="<?php echo $Q->Row->Name; ?>"><br>
                  <input class="Btn" name="save" type="submit" value="Save">
                </form>
              <?php
            }
          }
        }
        else
          echo '<h1>Нет данных</h1>';
      }
      unset($user_id);
    ?>
    <hr noshade size=1>
    <a href="Tour.php">Список туров</a>
    
  </body>
</html>



