<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//RU">
<html>
<head>
  <title>Фотографии</title>
  <link rel="stylesheet" type="text/css" href="Admin.css">
</head>
<body>
  <?php
    include "../Inc/DBCon.inc";
    include "../Inc/fVar.inc";
    include "fFile.inc";
    include "fPhoto.inc";
    include "../Inc/fImg.inc";
    
    session_start();
    $user_id = GetSessionVar('s_user_id','');
    if($user_id != '')
    {
      // Удаление секции
      $del_section = GetID('del_section');
      if($del_section != -1)
        DeleteSection($del_section);
      unset($del_section);
    
      // Новая секция
      $new_section = GetID('new_section');
      if($new_section != -1)
        SaveSection(-1,'Новая секция');
      unset($new_section);
    
      // Удаление фотографии
      $del_photo = GetID('del_photo');
      if($del_photo != -1)
        DeletePhoto($del_photo);
      unset($del_photo);
    
      // Новая фоторграфия
      $save_photo = PostVar('save_photo','');
      if($save_photo == 'Save')
      {
        $section_id = PostID('section_id');
        if($section_id != -1)
        {
          $new_id = SavePhoto(-1,'',$section_id);
          if($new_id != -1)
          {
            // Если были ошибки, то удаляем фотографию
            if(UploadFile('photo_file','../Content/Photo/'.$new_id.'.jpg','image/jpeg') != 0)
              DeletePhoto($new_id);
          }
          unset($new_id);
        }
        unset($section_id);
      }
      unset($save_photo);
    
      $section = GetID('section');
      if($section != -1)
      {
        // Сохранение информации о секции
        $save_section = PostVar('save_section','');
        if($save_section == 'Save')
        {
          $Name = PostVar('name','');
          if(trim($Name) != '')
            SaveSection($section,$Name);
          unset($Name);
        }
        unset($save_section);
        // Отображение информации
        vPhoto($section);
        echo '<hr size="1" noshade><a href="Photo.php">Список категорий</a>';
      }
      else
      {
        vSection();
        echo '<hr size="1" noshade><a href="index.php">Управление сайтом</a>';
      }
    }
    unset($user_id);
  ?>
</body>
</html>

