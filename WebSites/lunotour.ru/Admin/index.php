<?php
  include "../Inc/fVar.inc";
  // Старт сессии
  session_start();
  // Если $out = 1 - завершение текущей сессии
  $out = GetID('out');
  if($out == 1)
  {
    // Уничтожение переменных текущей сессии
    unset($_SESSION['s_user_id']);
  }
  unset($out);

  // Получение данных формы авторизации
  $user_name = PostVar('user_name','');
  $user_pass = PostVar('user_pass','');
  if(trim($user_name) != '' && trim($user_pass) != '')
  {
    // Проверка имени пользователя и пародя
    if($user_name == 'user' && $user_pass == 'pass')
    {
      // Создание переменных текущей сессии
      $_SESSION['s_user_id'] = $user_name;
    }
  }
  // Уничтожение переменных
  unset($user_name);
  unset($user_pass);
?>

<html>
  <head>
    <title>Управление сайтом</title>
    <link rel="stylesheet" type="text/css" href="Admin.css">
  </head>
  <body>
    <h1>Управление сайтом</h1>
    <hr noshade size=1>
    <?php
      // Получение значени переменных текущей сессии
      $user_id = GetSessionVar('s_user_id','');
      // Если $user_id сущетсвует, значит пользователь успешно вошел в систему
      if($user_id != '')
      {
        // Отображение ссылок
        ?>
          <a href="Tour.php">Управление Турами</a><br>
          <a href="Photo.php">Управление Фотографиями</a><br>
          <a href="News.php">Управление Новостями</a><br>
          <a href="Response.php">Управление Отзывами</a>
          <hr noshade size=1>
          <a href="index.php?out=1">Выход</a>
        <?php
      }
      else
      {
        // Иначе отображение формы регистрации
        ?>
          <h2>Вход</h2>
          <form action="index.php" method="post">
            <input class="Login" name="user_name" type="text">&nbsp;&nbsp;
            <input class="Login" name="user_pass" type="password"><br>
            <input class="Btn" align="right" name="Ok" type="Submit" value="Войти">
          </form>
          <hr noshade size=1>
        <?php
      }
      unset($user_id);
    ?>
  </body>
</html>


