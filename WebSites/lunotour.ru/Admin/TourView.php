<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//RU">
<html>
<head>
  <title>Туры</title>
  <link rel="stylesheet" type="text/css" href="Admin.css">
</head>
<body>
  <?php
    include "../Inc/DBCon.inc";
    include "../Inc/fVar.inc";
    include "../Inc/fImg.inc";
    include "fTourView.inc";
    include "fSTour.inc";
    include "fFile.inc";

    session_start();
    $user_id = GetSessionVar('s_user_id','');
    if($user_id != '')
    {
      // Получение значений переменных
      $tour = ReID('tour');
      $save = PostVar('save','');
      $delete = PostVar('delete','');
      $new = GetInt('new');
      $Item_id = PostID('Item_id');
      $Tour_id = PostID('Tour_id');

      // Сохранить
      if(trim($save) != '')
      {
        // Сохранение информации об элементе
        if($Item_id != -1)
        {
          // Получение значений переменных
          $Head = trim(PostVar('Head',''));
          $Content = trim(PostVar('Content',''));
          $Rang = PostVar('Rang',0);
          $ItemType = PostVar('ItemType',0);
          // Вызов функции сохранения информации об элементе
          $res = SaveTourItem($Item_id,$Head,$Content,$Rang,$ItemType,$Tour_id);
          if(($ItemType == 2 || $ItemType == 3 || $ItemType == 4))
          {
            if($_FILES['item_file']['tmp_name'])
            {
              // Расчет имени файла для сохранения
              $upload = GetFileName($Item_id,$ItemType);
              // Удаление файла с таким же именем
              DeleteFile($upload);
              // Загрузка файла, если возникли ошибки, удаляем TourItem
              if(UploadFile('item_file',$upload,'') != 0)
                DelTourItem($Item_id);
              unset($upload);
            }
          }
          unset($res);

          // Уничтожение переменных
          unset($Head);
          unset($Content);
          unset($Rang);
          unset($ItemType);
          unset($Tour_id);
        }
        // Сохранение информации о туре
        if($Item_id == -1 && $Tour_id != -1)
        {
          // Получение значений переменных
          $Name = trim(PostVar('Name',''));
          $ShortName = trim(PostVar('ShortName',''));
          $Address = trim(PostVar('Address',''));
          $SubCat_id = PostID('SubCat_id');
          $Logo = trim(PostVar('Logo',''));
          if($SubCat_id == ID_ERROR)
            $SubCat_id = 1;
          // Вызов функции сохранения информации о туре
          SaveTour($Tour_id,$Name,$ShortName,$Address,$Logo, $SubCat_id);
          // Уничтожение переменных
          unset($Name);
          unset($ShortName);
          unset($Address);
          unset($SubCat_id);
          unset($Logo);
        }
      }
      // Удалить
      if(trim($delete) != '')
      {
        DelTourItem($Item_id);
        unset($Item_id);
        unset($delete);
      }

      // Новый элемент
      if($new != -1)
      {
        if($tour != -1)
          SaveTourItem(-1,'','',0,$new,$tour);
      }

      // Уничтожение переменных
      unset($Item_id);
      unset($Tour_id);
      unset($save);
      unset($delete);
      unset($new);

      // Если есть id тура, загружаем информацию о туре, иначе создаем новый тур
      if($tour > -1)
        TourEdit($tour);
    }
    unset($user_id);
  ?>
  <a href="Tour.php">Список категорий</a>
</body>
</html>
