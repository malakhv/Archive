<?php

  function vRes($Q, $Rus)
  {
    if($Rus == 1) echo '<h1>Россия</h1>';
    else echo '<h1>Заграница</h1>';
    echo '<ul class="Tour">';
    if($Q->ExecSQL('select * from `vresponse` where `vresponse`.`Rus` = '.$Rus.';'))
    {
      if($Q->RecCount <= 0)
      {
        echo '<li>Нет данных</li></ul>';
        return 0;
      }
      $Q->FieldFirst();
      while(!$Q->Eof)
      {
        echo '<li><a href="Response.php?resp='.$Q->Row->id.'">'.$Q->Row->Name.'</a></li>';
        $Q->FieldNext();
      }
    }
    echo '</ul>';
    return 1;
  }

  function vResponse()
  {
    $Query = new TQuery;
    $Query->OpenAndSelectDBDef();
    vRes($Query,1);
    vRes($Query,0);
    $Query->CloseQuery();
    unset($Query);
    unset($rus);
  }
  
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
  
  function vRespInfo($id)
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDef();
    if($Q->ExecSQL('select * from `vresponse` where `vresponse`.`id` = '.$id.';'))
    {
      // Если результирующий набор данных пуст - завершаем работу
      if($Q->RecCount <= 0) return 0;
      // Переход к первой записи
      $Q->FieldFirst();
      echo '<h1>'.$Q->Row->Name.'</h1>';
      echo '<h2>'.date('d.m.Y',$Q->Row->RDate).'</h2>';
      // Формирование абзацев
      $arr = ParseText($Q->Row->Text);
      foreach ($arr as $item)
        if(trim($item) != '' ) echo '<p>'.$item.'</p>';

      // Список фотографий
      if($Q->ExecSQL('Select * from `vresp_image` where `vresp_image`.`Response_id` = '.$id.''))
      {
        $Q->FieldFirst();
        while(!$Q->Eof)
        {
          $path = 'Content/RespImg/'.$Q->Row->id.'.jpg';
          if(file_exists($path))
          {
            $a = getimagesize($path);
            $w = $a[0];
            $h = $a[1];
            GetNewImgSize($w,$h,500,1000);
            echo '<p class="image"><img width="'.$w.'" height="'.$h.'" src="'.$path.'"></p>';
            unset($a);
            unset($w);
            unset($h);
          }
          $Q->FieldNext();
        }
      }

    }
    $Q->CloseQuery();
    unset($Q);
    return 1;
  }
?>
