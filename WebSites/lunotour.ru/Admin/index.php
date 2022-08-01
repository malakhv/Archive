<?php
  include "../Inc/fVar.inc";
  // ����� ������
  session_start();
  // ���� $out = 1 - ���������� ������� ������
  $out = GetID('out');
  if($out == 1)
  {
    // ����������� ���������� ������� ������
    unset($_SESSION['s_user_id']);
  }
  unset($out);

  // ��������� ������ ����� �����������
  $user_name = PostVar('user_name','');
  $user_pass = PostVar('user_pass','');
  if(trim($user_name) != '' && trim($user_pass) != '')
  {
    // �������� ����� ������������ � ������
    if($user_name == 'user' && $user_pass == 'pass')
    {
      // �������� ���������� ������� ������
      $_SESSION['s_user_id'] = $user_name;
    }
  }
  // ����������� ����������
  unset($user_name);
  unset($user_pass);
?>

<html>
  <head>
    <title>���������� ������</title>
    <link rel="stylesheet" type="text/css" href="Admin.css">
  </head>
  <body>
    <h1>���������� ������</h1>
    <hr noshade size=1>
    <?php
      // ��������� ������� ���������� ������� ������
      $user_id = GetSessionVar('s_user_id','');
      // ���� $user_id ����������, ������ ������������ ������� ����� � �������
      if($user_id != '')
      {
        // ����������� ������
        ?>
          <a href="Tour.php">���������� ������</a><br>
          <a href="Photo.php">���������� ������������</a><br>
          <a href="News.php">���������� ���������</a><br>
          <a href="Response.php">���������� ��������</a>
          <hr noshade size=1>
          <a href="index.php?out=1">�����</a>
        <?php
      }
      else
      {
        // ����� ����������� ����� �����������
        ?>
          <h2>����</h2>
          <form action="index.php" method="post">
            <input class="Login" name="user_name" type="text">&nbsp;&nbsp;
            <input class="Login" name="user_pass" type="password"><br>
            <input class="Btn" align="right" name="Ok" type="Submit" value="�����">
          </form>
          <hr noshade size=1>
        <?php
      }
      unset($user_id);
    ?>
  </body>
</html>


