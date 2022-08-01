<?php
  //ItemType: 0 - Text; 1 - List; 2 - Img; 3 - File; 4 - Price
  function ParseText($Text)
  {
    $str = trim($Text);
    $arr = explode(chr(13),$str);
    $i = 0;
    foreach ($arr as $item)
    {
      $arr[$i] = trim($item);
      $i++;
    }
    return $arr;
  }
  
  // Формирование имени файла
  function GetFileName($id,$ItemType)
  {
    if($ItemType == -1)
    {
      $Q = new TQuery;
      $Q->OpenAndSelectDBDef();
      if($Q->ExecSQL('Select * from `vtouritems` where `vtouritems`.`id` = '.$id.';'))
      {
        if($Q->RecCount > 0)
        {
          $Q->FieldFirst();
          $ItemType = $Q->Row->ItemType;
        }
      }
      $Q->CloseQuery();
      unset($Q);
    }
    if($ItemType == -1)
      return '';
    $Result = 'Content/'.$ItemType.'/';
    switch($ItemType)
    {
      case 2:
        $Result = $Result.$id.'.jpg';
        break;
      case 3:
      case 4:
        $Result = $Result.$id.'.doc';
        break;
    }
    return  $Result;
  }
  
  // Информация о туре
  function TourInfo($id)
  {
    if($id == -1) return 0;
    $Q = new TQuery;
    $Q->OpenAndSelectDBDef();
    // Формирование заголовка
    if($Q->ExecSQL('select * from vtour where vtour.id = '.$id))
    {
      if($Q->RecCount <= 0 ) return 0;
      $Q->FieldFirst();
      echo '<h1>'.$Q->Row->ShortName.'</h1><h2>'.$Q->Row->Name;
      if(trim($Q->Row->Address) != '')
        echo '<br>'.$Q->Row->Address;
      echo '</h2>';
    }
    
    if($Q->ExecSQL('Select * from vtouritems where vtouritems.Tour_id = '.$id))
    {
      if($Q->RecCount <= 0 ) return 0;
      $Q->FieldFirst();
      while(!$Q->Eof)
      {
        // Text
        if($Q->Row->ItemType == 0)
        {
          // Формирование заголовка
          if(trim($Q->Row->Head) != '')
            echo '<h2>'.$Q->Row->Head.'</h2>';
          // Формирование абзацов
            $arr = ParseText($Q->Row->Content);
            foreach ($arr as $item)
              if(trim($item) != '' ) echo '<p>'.$item.'</p>';
        }
        
        // List
        if($Q->Row->ItemType == 1)
        {
          // Формирование заголовка
          if(trim($Q->Row->Head) != '')
            echo '<b>'.$Q->Row->Head.'</b>';
          // Формирование списка
          if(trim($Q->Row->Content) != '')
          {
            echo '<ul class="Tour">';
            $arr = ParseText($Q->Row->Content);
            foreach ($arr as $item)
              if(trim($item) != '' ) echo '<li>'.$item.'</li>';
            echo '</ul>';
          }
        }
        
        // Img
        if($Q->Row->ItemType == 2)
        {
          $fname = GetFileName($Q->Row->id,$Q->Row->ItemType);
          if(file_exists($fname))
          {
            $a = getimagesize($fname);
            $w = $a[0];
            $h = $a[1];
            GetNewImgSize($w,$h,500,1000);
            if(trim($Q->Row->Head) != '')
              echo '<h2>'.$Q->Row->Head.'</h2>';
            echo '<p class="image"><img src="'.$fname.'" width="'.$w.'" height="'.$h.'"></p>';
            unset($a);
            unset($w);
            unset($h);
          }
        }
        
        // File or Price
        if($Q->Row->ItemType == 3 || $Q->Row->ItemType == 4)
        {
          $fname = GetFileName($Q->Row->id,$Q->Row->ItemType);
          if(file_exists($fname))
          {
            echo '<p class="AlCenter"><a href="'.$fname.'">';
            if($Q->Row->ItemType == 3)
              if(trim($Q->Row->Head) != '')
                echo $Q->Row->Head;
              else
                echo 'Ссылка на файл';
            else
              echo 'Посмотреть цены';
            echo '</a></p>';
          }
        }
        
        $Q->FieldNext();
      }
    }
    $Q->CloseQuery();
    unset($Q);
    return 1;
  }


