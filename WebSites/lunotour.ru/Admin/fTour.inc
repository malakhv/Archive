<?php

  // Список категорий
  function vCat()
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDefAdmin();
    if($Q->ExecSQL('select * from vcat'))
    {
      $Q->FieldFirst();
      $rus = -1;
      while(!$Q->Eof)
      {
        if($rus != $Q->Row->Rus)
        {
          if($rus != -1) echo '<li><a class="Admin" href="Tour.php?rus='.$rus.'">[+]</a></li></ul>';
          if($Q->Row->Rus == 1) echo '<h1>Россия</h1>';
          else echo '<h1>Заграница</h1>';
          echo '<ul class="Tour">';
          $rus = $Q->Row->Rus;
        }
        echo '<li><a class="Admin" href="Tour.php?del_cat='.$Q->Row->id.'">[-]</a>&nbsp;<a href="Tour.php?cat='.$Q->Row->id.'">'.$Q->Row->Name.'</a></li>';
        $Q->FieldNext();
      }
      if($rus != -1) echo '<li><a class="Admin" href="Tour.php?rus='.$rus.'">[+]</a></li></ul>';
      $Q->CloseQuery();
      unset($Q);
    }
  }

  // Список подкатегорий
  function vSubCat($cat)
  {
    if($cat == -1) return 0;
    $Q = new TQuery;
    $Q->OpenAndSelectDBDefAdmin();
    // Формировние заголовка
    if($Q->ExecSQL('select * from vcat where vcat.id = '.$cat))
    {
      $Q->FieldFirst();
      $str = $Q->Row->Name.'.';
      if($Q->Row->Rus == 1)
        $str = $str.' Росиия';
      else
        $str = $str.' Заграница';
      echo '<h1>'.$str.'</h1>';
      unset($str);
    }
    // Форма изменения информации о категории
    ?>
    <form action="Tour.php?cat=<?php echo $cat; ?>" method="post">
      <input name="save_cat" type="hidden" value="<?php echo $cat; ?>">
      <input name="rus" type="hidden" value="<?php echo $Q->Row->Rus; ?>">
      <input name="rang" type="hidden" value="<?php echo $Q->Row->Rang; ?>">
      <input name="name" type="text" value="<?php echo $Q->Row->Name; ?>"><br>
      <input class="Btn" name="save" type="submit" value="Save">
    </form>
    <hr noshade size=1>
    <?php
    // Список подкатегорий
    if($Q->ExecSQL('select * from vsubcat where vsubcat.Cat_id = '.$cat))
    {
      $Q->FieldFirst();
      $tmp = new TQuery;
      $tmp->OpenAndSelectDBDefAdmin();
      while(!$Q->Eof)
      {
        echo '<a class="Admin" href="Tour.php?cat='.$cat.'&del_sub='.$Q->Row->id.'">[-]</a> <a href="SubEdit.php?sub='.$Q->Row->id.'"><b>'.$Q->Row->Name.'</b></a><br>';
        // Список туров
        if($tmp->ExecSQL('Select * from vtour where vtour.Cat_id = '.$cat.' and vtour.SubCat_id = '.$Q->Row->id.';'))
        {
          echo '<ul class="Tour">';
          $tmp->FieldFirst();
          while (!$tmp->Eof)
          {
            echo '<li><a class="Admin" href="Tour.php?cat='.$cat.'&del_tour='.$tmp->Row->id.'">[-]</a>&nbsp;<a href="TourView.php?tour='.$tmp->Row->id.'">'.$tmp->Row->ShortName.'</a></li>';
            $tmp->FieldNext();
          }
          echo '<li><a class="Admin" href="Tour.php?cat='.$cat.'&new_tour='.$Q->Row->id.'">[+]</a></li></ul>';
        }
        $Q->FieldNext();
      }
      $tmp->QueryFree();
      unset($tmp);
    }
    $Q->CloseQuery();
    unset($Q);
    echo '<a class="Admin" href="Tour.php?cat='.$cat.'&new_sub=1"><b>[Новая подкатегория]</b></a>';
  }
  
  function GetMax($Query,$Table,$Field)
  {
    $Result = 0;
    if($Query->ExecSQL('Select Max('.$Field.') as Mx from `'.$Table.'`;'))
    {
      if($Query->RecCount > 0)
      {
        $Query->FieldFirst();
        $Result = $Query->Row->Mx;
      }
    }
    return $Result;
  }
  
  function SaveCat($id, $Name, $Rang, $Rus)
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDefAdmin();
    // Если ранг = -1, то добавляем в конец
    if($Rang == -1)
      $Rang = GetMax($Q,'Cat','Rang') + 1;
    // Если id != -1, то обновляем информцию, иначе добавляем запись
    if($id != -1)
      $sql = 'UPDATE `cat` SET `Name` = "'.$Name.'", `Rang` = '.$Rang.', `Rus` = '.$Rus.' WHERE `cat`.id = '.$id.';';
    else
      $sql = 'INSERT INTO `cat` (`Name`, `Rang`, `Rus`)  VALUES  ("'.$Name.'",'.$Rang.','.$Rus.');';
    $Q->Execute($sql);
    $Q->CloseQuery();
    unset($Q);
  }

  function SaveSubCat($id, $Name, $Rang, $Cat_id)
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDefAdmin();
    if($Rang == -1)
      $Rang = GetMax($Q,'SubCat','Rang') + 1;
    if($id != -1)
      $sql = 'UPDATE `subcat` SET `Name` = "'.$Name.'", `Rang` = '.$Rang.', `Cat_id` = '.$Cat_id.' WHERE `subcat`.id = '.$id.';';
    else
      $sql = 'INSERT INTO `subcat` (`Name`, `Rang`, `Cat_id`) VALUES ("'.$Name.'",'.$Rang.','.$Cat_id.');';
    $Q->Execute($sql);
    $Q->CloseQuery();
    unset($Q);
  }
  
  function DeleteCat($id)
  {
    Delete($id,'cat');
  }
  
  function DeleteSubCat($id)
  {
    Delete($id,'subcat');
  }
  
  function DeleteTour($id)
  {
    Delete($id,'tour');
  }
?>


