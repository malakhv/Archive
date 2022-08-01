<?php

  function EchoDate($timestmp)
  {
    echo date('d.m.Y',$timestmp);
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
      echo '<h1>'.$Q->Row->Name.'</h1>'
      // Отображение формы изменения информаци об отзыве
      ?>
      <p><form action="RespView.php?resp=<?php echo $id; ?>" method="post">
        <input name="resp_id" type="hidden" value="<?php echo $id; ?>">
        <input name="resp_rus" type="hidden" value="<?php echo $Q->Row->Rus; ?>">
        Название:<br>
        <input name="resp_name" type="text" value="<?php echo $Q->Row->Name; ?>"><br>
        Дата:<br>
        <input name="resp_rdate" type="text" value="<?php EchoDate($Q->Row->RDate); ?>"><br>
        Текст отзыва:<br>
        <textarea name="resp_text"><?php echo $Q->Row->Text; ?></textarea><br>
        <input class="Btn" name="resp_save" type="submit" value="Save">&nbsp;&nbsp;
        <input class="Btn" name="resp_delete" type="submit" value="Delete">
      </form></p>
      <hr noshade size=1>
      
      <b>Новая фотография:</b>
      <p><form enctype="multipart/form-data" action="RespView.php?resp=<?php echo $id; ?>" method="post">
        <input name="MAX_FILE_SIZE" type="hidden" value="1048576">
        <input name="resp_id" type="hidden" value="<?php echo $id; ?>">
        <input name="resp_file" type="file"><br>
        <input class="Btn" name="photo_save" type="submit" value="Save">
      </form></p>

      <?php
      
      // Список фотографий
      if($Q->ExecSQL('Select * from `vresp_image` where `vresp_image`.`Response_id` = '.$id.''))
      {
        if($Q->RecCount > 0) echo '<hr noshade size=1>';

        $Q->FieldFirst();
        while(!$Q->Eof)
        {
          $path = '../Content/RespImg/'.$Q->Row->id.'.jpg';
          if(file_exists($path))
          {
            $a = getimagesize($path);
            $w = $a[0];
            $h = $a[1];
            GetNewImgSize($w,$h,320,240);
            echo '<p align="left"><img width="'.$w.'" height="'.$h.'" src="'.$path.'" alt=""><br><a class="Admin" href="RespView.php?resp='.$id.'&del_image='.$Q->Row->id.'">[удалить]</a></p>';
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
  
  function SaveRespImage($id, $Resp_id, $Name)
  {
    $Result = -1;
    $Q = new TQuery;
    $Q->OpenAndSelectDBDefAdmin();
    // Подготовка переменных
    $Name = addslashes(trim($Name));
    if($id != -1)
      $sql = 'UPDATE `resp_image` SET `Name` = "'.$Name.'", `Response_id` = '.$Resp_id.' WHERE `resp_image`.`id` = '.$id.';';
    else
      $sql = 'INSERT INTO `resp_image` (`Name`, `Response_id`) VALUES ("'.$Name.'",'.$Resp_id.');';

    if($Q->Execute($sql))
    {
      // Получение id
      if($Q->ExecSQL('Select LAST_INSERT_ID() as LastID from `resp_image`'))
      {
        $Q->FieldFirst();
        $Result = $Q->Row->LastID;
      }
    }
    return $Result;
  }
  
  function DeleteRespImg($id)
  {
    $Result = Delete($id,'resp_image');
    if($Result)
     @ DeleteFile('../Content/RespImg/'.$id.'.jpg');
  }
  
?>
