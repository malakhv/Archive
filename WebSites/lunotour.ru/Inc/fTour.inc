<?php
  // Список категорий
  function vCat()
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDef();
    if($Q->ExecSQL('select * from vcat'))
    {
      $Q->FieldFirst();
      $rus = -1;
      while(!$Q->Eof)
      {
        if($rus != $Q->Row->Rus)
        {
          if($rus != -1) echo '</ul>';
          if($Q->Row->Rus == 1) echo '<h1>Россия</h1>';
          else echo '<h1>Заграница</h1>';
          echo '<ul class="Tour">';
          $rus = $Q->Row->Rus;
        }
        echo '<li><a href="Tour.php?cat='.$Q->Row->id.'">'.$Q->Row->Name.'</a></li>';
        $Q->FieldNext();
      }
      if($rus != -1) echo '</ul>';
      $Q->CloseQuery();
      unset($Q);
    }
  }

  // Список подкатегорий
  function vSubCat($cat)
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDef();
    // Формировние заголовка
    if($Q->ExecSQL('Select * from vcat where vcat.id = '.$cat.';'))
    {
      $Q->FieldFirst();
      $str = $Q->Row->Name.'.';
      if($Q->Row->Rus == 1)
        $str = $str.' Россия';
      else
        $str = $str.' Заграница';
      echo '<h1>'.$str.'</h1>';
      unset($str);
    }
    // Список подкатегорий
    if($Q->ExecSQL('select * from vtour where vtour.Cat_id = '.$cat.';'))
    {
      $Q->FieldFirst();
      $scat = -1;
      while(!$Q->Eof)
      {
        if($scat != $Q->Row->SubCat_id)
        {
          if($scat != -1) echo '</ul>';
          echo '<b>'.$Q->Row->scName.'</b><ul class="Tour">';
          $scat = $Q->Row->SubCat_id;
        }
        echo '<li><a href="TourView.php?tour='.$Q->Row->id.'">'.$Q->Row->ShortName.'</a></li>';
        $Q->FieldNext();
      }
      if($scat != -1) echo '</ul>';
    }
    $Q->CloseQuery();
    unset($Q);
  }
?>



