<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//RU">
<html>
  <head>
    <title>Новости</title>
    <link rel="stylesheet" type="text/css" href="Admin.css">
  </head>
  <body>
    <?php
      include "../Inc/DBCon.inc";
      include "../Inc/fVar.inc";
      include "fNews.inc";

      session_start();
      $user_id = GetSessionVar('s_user_id','');
      if($user_id != '')
      {
        // Удаление новости
        $del_news = PostVar('del_news','');
        if($del_news == 'Delete')
        {
          $id = PostID('id');
          if($id != -1)
            DeleteNews($id,'News');
          unset($id);
        }
        unset($del_news);

        // Сохранение информации о новости
        $save_news = PostVar('save_news','');
        if($save_news == 'Save')
        {
          $id = PostID('id');
          if($id != -1)
          {
            $ShortText = PostVar('ShortText','');
            $Text = PostVar('Text','');
            $NDate = PostVar('NDate','');
            $NewsCat_id = PostID('NewsCat_id');
            if($NewsCat_id == -1)
              $NewsCat_id = 1;
            SaveNews($id,$ShortText,$Text,$NDate,$NewsCat_id);
            unset($ShortText);
            unset($Text);
            unset($NewsCat_id);
          }
          unset($id);
        }
        unset($save_news);

        // Создание категории новостей
        $new_newscat = GetID('new_newscat');
        if($new_newscat == 1)
          SaveNewsCat(-1,'Новая категория');
        unset($new_newscat);

        // Удаление категории новостей
        $del_newscat = GetID('del_newscat');
        if($del_newscat != -1)
          DeleteNewsCat($del_newscat);
        unset($del_newscat);

        $newscat = GetID('newscat');
        if($newscat != -1)
        {
          // Сохранение информации о категории новостей
          $save_newscat = PostVar('save_newscat','');
          if($save_newscat == 'Save')
          {
            $id = PostID('id');
            if($id != -1)
            {
              $Name = trim(PostVar('Name',''));
              if($Name != '')
                SaveNewsCat($id,$Name);
              unset($Name);
            }
            unset($id);
          }
          unset($save_newscat);

          // Создание новости
          $new_news = GetInt('new_news');
          if($new_news == 1)
            SaveNews(-1,'Новость','Текст новости',null,$newscat);
          unset($new_news);
          // Отображение новостей
          vNews($newscat);
          echo '<hr size="1" noshade><a href="News.php">Список категорий</a>';
        }
        else
        {
          vNewsCat();
          echo '<hr size="1" noshade><a href="index.php">Управление сайтом</a>';
        }
      }
      unset($user_id);
    ?>
  </body>
</html>

