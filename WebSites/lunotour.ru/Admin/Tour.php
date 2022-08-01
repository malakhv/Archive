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
    include "fTour.inc";
    include "fSTour.inc";
    
    session_start();
    $user_id = GetSessionVar('s_user_id','');
    if($user_id != '')
    {
      // Новая категория
      $rus = GetInt('rus');
      if($rus == 0 || $rus == 1)
        SaveCat(-1,'Новая категория',-1,$rus);
      unset($rus);
      // Удаление категории
      $del_cat = GetID('del_cat');
      if($del_cat != -1)
        DeleteCat($del_cat);
      unset($del_cat);
      // Удаление подкатегории
      $del_sub = GetID('del_sub');
      if($del_sub != -1)
        DeleteSubCat($del_sub);
      unset($del_sub);
      // Удаление тура
      $del_tour = GetID('del_tour');
      if($del_tour != -1)
        DeleteTour($del_tour);
      unset($del_tour);

      // Сохранение информации
      $save = PostVar('save','');
      if($save == 'Save')
      {

        // О категории
        $save_cat = PostID('save_cat');
        if($save_cat != -1)
        {
          // Получение значений переменных
          $Name = PostVar('name','Новая категория');
          $Rang = PostVar('rang',0);
          $Rus = PostVar('rus',0);
          // Сохранение информации о категории
          SaveCat($save_cat,$Name,$Rang,$Rus);
          unset($save_cat);
          unset($Name);
          unset($Rang);
          unset($Rus);
        }
        // О подкатегории
        $save_sub = PostID('save_sub');
        if($save_sub != -1)
        {
          // Получение значений переменных
          $Name = PostVar('name','Новая подкатегория');
          $Rang = PostVar('rang',0);
          $Cat_id = PostID('cat_id');
          // Если известна категория, то сохранение информации
          if($Cat_id != -1)
            SaveSubCat($save_sub,$Name,$Rang,$Cat_id);
          // Уничтожение переменных
          unset($Name);
          unset($Rang);
          unset($Cat_id);
        }
      }
      unset($save);

      $cat = GetID('cat');
      if($cat != -1)
      {
        // Новый тур
        $new_tour = GetID('new_tour');
        if($new_tour != -1)
          SaveTour(-1,'Новый тур','Новый тур','','',$new_tour);
        //Новая подкатегория
        $new_sub = GetID('new_sub');
        if($new_sub == 1)
          SaveSubCat(-1,'Новая подкатегория',-1,$cat);
        unset($new_sub);
        // Список подкатегорий
        vSubCat($cat);
        echo '<hr noshade size=1><a href="Tour.php">Список туров</a>';
      }
      else
      {
        // Список категорий
        vCat();
        echo '<hr noshade size=1><a href="index.php">Управление сайтом</a>';
      }
    }
    unset($user_id);
  ?>
</body>
</html>




