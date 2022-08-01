<?php

  function vPhoto($Section_id)
  {
    if($Section_id == -1)
      return 0;
    $Q = new TQuery;
    $Q->OpenAndSelectDBDef();
    // Информация о секции
    echo '<h1>Фотографии';
    if($Q->ExecSQL('Select * from vsection where vsection.id = '.$Section_id.';'))
    {
      if($Q->RecCount > 0)
      {
        $Q->FieldFirst();
        // Заголовок
        echo '.'.$Q->Row->Name;
      }
    }
    echo '</h1>';
    // Список фотографий
    if($Q->ExecSQL('Select * from vphoto where vphoto.Section_id = '.$Section_id.';'))
    {
      $Q->FieldFirst();
      while(!$Q->Eof)
      {
        $path = 'Content/Photo/'.$Q->Row->id.'.jpg';
        $a = getimagesize($path);
        $w = $a[0];
        $h = $a[1];
        GetNewImgSize($w,$h,500,1000);
        echo '<p class="image"><img align="center" width="'.$w.'" height="'.$h.'" src="'.$path.'" alt=""></p>';
        $Q->FieldNext();
      }
    }
    $Q->CloseQuery();
    unset($Q);
  }

  function vSection()
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDef();
    echo '<h1>Фотографии</h1>';
    if($Q->ExecSQL('select * from vsection'))
    {
      if($Q->RecCount > 0)
      {
        $Q->FieldFirst();
        echo '<ul class="Tour">';
        while(!$Q->Eof)
        {
          echo '<li><a href="Photo.php?section='.$Q->Row->id.'">'.$Q->Row->Name.'</a></li>';
          $Q->FieldNext();
        }
        echo '</ul>';
      }
    }
  }
?>


