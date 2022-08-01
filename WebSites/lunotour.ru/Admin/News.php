<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//RU">
<html>
  <head>
    <title>�������</title>
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
        // �������� �������
        $del_news = PostVar('del_news','');
        if($del_news == 'Delete')
        {
          $id = PostID('id');
          if($id != -1)
            DeleteNews($id,'News');
          unset($id);
        }
        unset($del_news);

        // ���������� ���������� � �������
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

        // �������� ��������� ��������
        $new_newscat = GetID('new_newscat');
        if($new_newscat == 1)
          SaveNewsCat(-1,'����� ���������');
        unset($new_newscat);

        // �������� ��������� ��������
        $del_newscat = GetID('del_newscat');
        if($del_newscat != -1)
          DeleteNewsCat($del_newscat);
        unset($del_newscat);

        $newscat = GetID('newscat');
        if($newscat != -1)
        {
          // ���������� ���������� � ��������� ��������
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

          // �������� �������
          $new_news = GetInt('new_news');
          if($new_news == 1)
            SaveNews(-1,'�������','����� �������',null,$newscat);
          unset($new_news);
          // ����������� ��������
          vNews($newscat);
          echo '<hr size="1" noshade><a href="News.php">������ ���������</a>';
        }
        else
        {
          vNewsCat();
          echo '<hr size="1" noshade><a href="index.php">���������� ������</a>';
        }
      }
      unset($user_id);
    ?>
  </body>
</html>

