<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//RU">
<html>
  <head>
    <title>������</title>
    <link rel="stylesheet" type="text/css" href="Admin.css">
  </head>
  <body>
    <?php
      include "../Inc/DBCon.inc";
      include "../Inc/fVar.inc";
      include "SResp.inc";
      include "fFile.inc";
      include "fResponse.inc";
      session_start();
      $user_id = GetSessionVar('s_user_id','');
      if($user_id != '')
      {
        // �������� ������
        $rus = GetInt('rus');
        if($rus == 0 || $rus == 1)
          SaveResponse(-1,null,'����� �����',$rus,'');
        unset($rus);
        
        // �������� ������
        $del_resp = GetID('del_resp');
        if($del_resp != -1)
          DeleteResponse($del_resp);
        unset($del_resp);
        
        // ����������� ������ �������
        vResponse();
      }
      unset($user_id);
    ?>
    <hr size="1" noshade>
    <a href="index.php">���������� ������</a>
  </body>
</html>



