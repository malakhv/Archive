<?php
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
          echo '<li><a class="Admin" href="Photo.php?del_section='.$Q->Row->id.'">[-]</a><a href="Photo.php?section='.$Q->Row->id.'">'.$Q->Row->Name.'</a></li>';
          $Q->FieldNext();
        }
        echo '<li><a class="Admin" href="Photo.php?new_section=1">[+]</a></li></ul>';
      }
    }
    $Q->CloseQuery();
    unset($Q);
  }
  
  function vPhoto($Section_id)
  {
    if($Section_id == -1) return 0;
    $Q = new TQuery;
    $Q->OpenAndSelectDBDefAdmin();
    // Информация о секции
    if($Q->ExecSQL('Select * from vsection where vsection.id = '.$Section_id.';'))
    {
      if($Q->RecCount > 0)
      {
        $Q->FieldFirst();
        // Заголовок
        echo '<h1>'.$Q->Row->Name.'</h1>';
        // Форма изменения информации о секции
        ?>
        <form action="Photo.php?section=<?php echo $Section_id; ?>" method="post">
          <input name="section_id" type="hidden" value="<?php echo $Section_id; ?>">
          <input name="name" type="text" value="<?php echo $Q->Row->Name; ?>"><br>
          <input class="Btn" name="save_section" type="submit" value="Save">
        </form>
        <hr noshade size=1>
        <?php
      }
    }
    // Форма добавления фотографии
    ?>
    <b>Новая фотография:</b>
    <p>
    <form enctype="multipart/form-data" action="Photo.php?section=<?php echo $Section_id; ?>" method="post">
      <input name="MAX_FILE_SIZE" type="hidden" value="1048576">
      <input name="section_id" type="hidden" value="<?php echo $Section_id; ?>">
      <input name="photo_file" type="file"><br>
      <input class="Btn" name="save_photo" type="submit" value="Save">
    </form>
    </p>
    <hr noshade size=1>
    <?php
    
    // Список фотографий
    if($Q->ExecSQL('Select * from vphoto where vphoto.Section_id = '.$Section_id.''))
    {
      $Q->FieldFirst();
      while(!$Q->Eof)
      {
        $path = '../Content/Photo/'.$Q->Row->id.'.jpg';
        if(file_exists($path))
        {
          $a = getimagesize($path);
          $w = $a[0];
          $h = $a[1];
          GetNewImgSize($w,$h,320,240);
          echo '<p align="left"><img width="'.$w.'" height="'.$h.'" src="'.$path.'" alt=""><br><a class="Admin" href="Photo.php?section='.$Section_id.'&del_photo='.$Q->Row->id.'">[удалить]</a></p>';
          unset($a);
          unset($w);
          unset($h);
        }
        $Q->FieldNext();
      }
    }
    $Q->CloseQuery();
    unset($Q);
    unset($sql);
  }
  
  function SaveSection($id, $Name)
  {
    if($id != -1)
      $sql = 'UPDATE `section` SET `Name` = "'.trim($Name).'" WHERE `section`.`id` = '.$id.';';
    else
      $sql = 'INSERT INTO `section` (`Name`) VALUES ("'.trim($Name).'");';
    return Execute($sql,true);
  }
  
  function SavePhoto($id,$URL,$Section_id)
  {
    if($id != -1)
      $sql = 'UPDATE `photo` SET `section_id` = '.$Section_id.';';
    else
      $sql = 'INSERT INTO `photo` (`section_id`) VALUES ('.$Section_id.');';
    $Q = new TQuery;
    $Q->OpenAndSelectDBDefAdmin();
    $Q->Execute($sql);
    // Получение id
    if($Q->ExecSQL('Select LAST_INSERT_ID() as LastID from `photo`'))
    {
      $Q->FieldFirst();
      $Result = $Q->Row->LastID;
    }
    else
      $Result = -1;
    $Q->CloseQuery();
    unset($Q);
    unset($sql);
    return $Result;
  }
  
  function DeleteSection($id)
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDef();
    if($Q->ExecSQL('select `vphoto` where `vphoto`.`Section_id` = '.$id.';'))
    {
      $Q->FieldFirst();
      while(!$Q->Eof)
      {
        DeletePhoto($Q->Row->id);
        $Q->FieldNext();
      }
    }
    return Delete($id,'section');
  }

  function DeletePhoto($id)
  {
    $Result = Delete($id,'photo');
    if($Result)
     @ DeleteFile('../Content/Photo/'.$id.'.jpg');
  }

?>
