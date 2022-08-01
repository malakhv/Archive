<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//RU">
<html>
<head>
  <title>����</title>
  <link rel="stylesheet" type="text/css" href="Admin.css">
</head>
<body>
  <?php
    include "../Inc/DBCon.inc";
    include "../Inc/fVar.inc";
    include "../Inc/fImg.inc";
    include "fRespView.inc";
    include "SResp.inc";
    include "fFile.inc";
    
    session_start();
    $user_id = GetSessionVar('s_user_id','');
    if($user_id != '')
    {
      // ��������� �������� ����������
      $resp = GetID('resp');
      $resp_save = PostVar('resp_save','');
      $resp_delete = PostVar('resp_delete','');
      
      // ���������� ���������� �� ������
      if($resp_save == 'Save')
      {
        $resp_id = PostID('resp_id');
        if($resp_id != -1)
        {
          $resp_name = PostVar('resp_name','');
          $resp_rdate = PostVar('resp_rdate','');
          $resp_text = PostVar('resp_text','');
          $resp_rus = PostInt('resp_rus');
          SaveResponse($resp_id,$resp_rdate,$resp_name,$resp_rus,$resp_text);
          unset($resp_name);
          unset($resp_rdate);
          unset($resp_text);
        }
        unset($resp_id);
      }
      unset($resp_save);
      
      // ����� �����������
      $photo_save = PostVar('photo_save','');
      if($photo_save == 'Save')
      {
        $resp_id = PostID('resp_id');
        if($resp_id != -1)
        {
          $new_id = SaveRespImage(-1,$resp_id,'����� ����������');
          if($new_id != -1)
          {
            // ���� ���� ������, �� ������� ����������
            if(UploadFile('resp_file','../Content/RespImg/'.$new_id.'.jpg','image/jpeg') != 0)
              DeleteRespImg($new_id);
          }
          unset($new_id);
        }
        unset($resp_id);
      }
      unset($photo_save);
      
      // �������� ����������
      $del_image = GetID('del_image');
      if($del_image != -1)
      {
        DeleteRespImg($del_image);
      }
      unset($del_image);
      
      
      if($resp != -1)
      {
        // ����� ����������
        vRespInfo($resp);
      }
      unset($resp);
    }
    unset($user_id);
  ?>
  <hr noshade size=1>
  <a href="Response.php">������ �������</a>
</body>
</html>

