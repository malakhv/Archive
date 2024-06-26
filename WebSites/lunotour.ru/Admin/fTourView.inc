<?php
  //ItemType: 0 - Text; 1 - List; 2 - Img; 3 - File; 4 - Price
  function ParseText($Text)
  {
    $str = trim($Text);
    $arr = explode(chr(13),$str);
    $i = 0;
    foreach ($arr as $item)
    {
      $arr[$i] = trim($item);
      $i++;
    }
    unset($i);
    return $arr;
  }
  
  // ������������ ����� �����
  function GetFileName($id,$ItemType)
  {
    if($ItemType == -1)
    {
      $Q = new TQuery;
      $Q->OpenAndSelectDBDef();
      if($Q->ExecSQL('Select * from `vtouritems` where `vtouritems`.`id` = '.$id.';'))
      {
        if($Q->RecCount > 0)
        {
          $Q->FieldFirst();
          $ItemType = $Q->Row->ItemType;
        }
      }
      $Q->CloseQuery();
      unset($Q);
    }
    if($ItemType == -1)
      return '';
    $Result = '../Content/'.$ItemType.'/';
    switch($ItemType)
    {
      case 2:
        $Result = $Result.$id.'.jpg';
        break;
      case 3:
      case 4:
        $Result = $Result.$id.'.doc';
        break;
    }
    return  $Result;
  }
  
  // ���������� � ����
  function TourInfo($id)
  {
    if($id == -1) return 0;
    $Q = new TQuery;
    $Q->OpenAndSelectDBDef();
    // ������������ ���������
    if($Q->ExecSQL('select * from vtour where vtour.id = '.$id))
    {
      if($Q->RecCount <= 0 ) return 0;
      $Q->FieldFirst();
      echo '<h1>'.$Q->Row->Name.'</h1><h2>'.$Q->Row->Name;
      if(trim($Q->Row->Address) != '')
        echo '<br>'.$Q->Row->Address;
      echo '</h2>';
    }
    
    if($Q->ExecSQL('Select * from vtouritems where vtouritems.Tour_id = '.$id))
    {
      if($Q->RecCount <= 0 ) return 0;
      $Q->FieldFirst();
      while(!$Q->Eof)
      {
        // Text
        if($Q->Row->ItemType == 0)
        {
          // ������������ ���������
          if(trim($Q->Row->Head) != '')
            echo '<h2>'.$Q->Row->Head.'</h2>';
          // ������������ �������
            $arr = ParseText($Q->Row->Content);
            foreach ($arr as $item)
              if(trim($item) != '' ) echo '<p>'.$item.'</p>';
        }
        
        // List
        if($Q->Row->ItemType == 1)
        {
          // ������������ ���������
          if(trim($Q->Row->Head) != '')
            echo '<b>'.$Q->Row->Head.'</b>';
          // ������������ ������
          if(trim($Q->Row->Content) != '')
          {
            echo '<ul class="Tour">';
            $arr = ParseText($Q->Row->Content);
            foreach ($arr as $item)
              if(trim($item) != '' ) echo '<li>'.$item.'</li>';
            echo '</ul>';
          }
        }
        
        // Img
        if($Q->Row->ItemType == 2)
        {
          $fname = trim($Q->Row->Content);
        }
        $Q->FieldNext();
      }
    }
    $Q->CloseQuery();
    unset($Q);
    return 1;
  }
  
  function TourEdit($id)
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDef();

    // ������������ ���������
    if($Q->ExecSQL('select * from vtour where vtour.id = '.$id))
    {
      if($Q->RecCount <= 0 ) return 0;
      $Q->FieldFirst();
      echo '<h1>'.$Q->Row->Name.'</h1>';
      // ����� �������������� ���������� � ����
      echo '<p><form action="TourView.php?tour='.$id.'" method="post">';
      // id ����
      echo '<input name="Tour_id" type="hidden" value="'.$id.'">';
      // Logo
      echo '<input name="Logo" type="hidden" value="'.$Q->Row->Logo.'">';
      // SubCat_id (������������)
      echo '<input name="SubCat_id" type="hidden" value="'.$Q->Row->SubCat_id.'">';
      // �������� ����
      echo '<b>��������:</b><br><input name="Name" type="text" value="'.htmlspecialchars($Q->Row->Name).'"><br>';
      echo '<b>�������� ������:</b><br><input name="ShortName" type="text" value="'.htmlspecialchars($Q->Row->ShortName).'"><br>';
      // ����� ����
      echo '<b>�����:</b><br><input name="Address" type="text" value="'.$Q->Row->Address.'"><br>';
      // ������ ��������� � �������
      echo '<input class="Btn" name="save" type="submit" value="Save">&nbsp;&nbsp;';
      echo '<input class="Btn" name="delete" type="submit" value="Delete"></form></p>';
      echo '<hr noshade size=1>';
      // ���������� � ����
      echo '<p>���������� � ���� (&nbsp;';
      echo '��������:&nbsp;<a href="TourView.php?tour='.$id.'&new=0">�����</a>&nbsp;|&nbsp;<a href="TourView.php?tour='.$id.'&new=1">������</a>&nbsp;|&nbsp;<a href="TourView.php?tour='.$id.'&new=2">��������</a>&nbsp;|&nbsp;<a href="TourView.php?tour='.$id.'&new=3">����</a>&nbsp;|&nbsp;<a href="TourView.php?tour='.$id.'&new=4">����</a>&nbsp;)<br>';
      if($Q->ExecSQL('select * from vtouritems where vtouritems.Tour_id = '.$id))
      {
        $Q->FieldFirst();
        //if($Q->RecCount > 0)
          echo '<hr noshade size=1>';
        while(!$Q->Eof)
        {
          echo '<p>�������:&nbsp;';
          switch($Q->Row->ItemType)
          {
            case 0:
              echo '�����';
              break;
            case 1:
              echo '������';
              break;
            case 2:
              echo '��������';
              break;
            case 3:
              echo '����';
              break;
            case 4:
              echo '����';
              break;
          }
          if($Q->Row->ItemType == 0 || $Q->Row->ItemType == 1)
            echo '<p><form action="TourView.php?tour='.$id.'" method="post">';
          if($Q->Row->ItemType == 2 || $Q->Row->ItemType == 3 || $Q->Row->ItemType == 4)
          {
            echo '<p><form enctype="multipart/form-data" action="TourView.php?tour='.$id.'" method="post">';
            echo '<input name="MAX_FILE_SIZE" type="hidden" value="10485760">';
          }
          // id ��������
          echo '<input name="Item_id" type="hidden" value="'.$Q->Row->id.'">';
          // id ����
          echo '<input name="Tour_id" type="hidden" value="'.$id.'">';
          // ��� �����������
          echo '<input name="ItemType" type="hidden" value="'.$Q->Row->ItemType.'">';
          // ��������� ��������
          echo '<b>���������:</b><br><input name="Head" size="50" type="text" value="'.$Q->Row->Head.'"><br>';
          // ����
          echo '<b>������� ����������:</b><br><input class="Short" name="Rang" type="text" value="'.$Q->Row->Rang.'"><br>';
          echo '<b>����������:</b><br>';
          // ���� ��� ����������� - ����� ��� ������, ������� textarea
          if($Q->Row->ItemType == 0 || $Q->Row->ItemType == 1)
            echo '<textarea name="Content" rows="6" wrap="off">'.$Q->Row->Content.'</textarea>';
          // ���� ��� ����������� ��������, ���� ��� ���� � ������ - ������� ���� �������� �����
          if($Q->Row->ItemType == 2 || $Q->Row->ItemType == 3 || $Q->Row->ItemType == 4)
          {
            $fl = '../Content/'.$Q->Row->ItemType.'/';
            switch($Q->Row->ItemType)
            {
              case 2:
                $fl = $fl.$Q->Row->id.'.jpg';
                if(file_exists($fl))
                {
                  $a = getimagesize($fl);
                  $w = $a[0];
                  $h = $a[1];
                  GetNewImgSize($w,$h,160,120);
                  echo '<img src="'.$fl.'" width="'.$w.'" height="'.$h.'"><br>';
                  unset($a);
                  unset($w);
                  unset($h);
                }
                break;
              case 3:
              case 4:
                $fl = $fl.$Q->Row->id.'.doc';
                if(file_exists($fl))
                  echo '<a href="'.$fl.'">��������</a><br>&nbsp;<br>';
              break;
            }
            echo '<input name="item_file" type="file">';
            unset($fl);
          }
          // ������ ��������� � �������
          echo '<br><input class="Btn" name="save" type="submit" value="Save">&nbsp;&nbsp;';
          echo '<input class="Btn" name="delete" type="submit" value="Delete"></form></p></p>';
          echo '<hr noshade size=1>';
          $Q->FieldNext();
        }
      }
    }
    $Q->CloseQuery();
    unset($Q);
    return 1;
  }
  
  function DelTourItem($id)
  {
    // �������� �����
    DeleteFile(GetFileName($id,-1));
    // �������� ������ �� ������� ��
    Delete($id,'touritems');
  }
  
  function SaveTourItem($id, $Head, $Content, $Rang, $ItemType, $Tour_id)
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDefAdmin();
    // ���� id = -1, �� ��������� ������, ����� ��������� ����������
    if($id != -1)
      $sql = 'UPDATE `touritems` set `Head` = "'.addslashes($Head).'", `Content` = "'.addslashes($Content).'",
        	   `Rang` = '.$Rang.', `ItemType` = '.$ItemType.', `Tour_id` = '.$Tour_id.'
              WHERE `touritems`.id = '.$id.';';
    else
      $sql = 'INSERT INTO `touritems` (`Head`, `Content`, `Rang`, `ItemType`,
        	`Tour_id`)
        	VALUES ("'.addslashes($Head).'","'.addslashes($Content).'",'.$Rang.','.$ItemType.','.$Tour_id.');';
    // �������� ������������ �������� �� ���������
    $Result = -1;
    // ���������� �������, ���� ������� - ��������� Last Insert ID
    if($Q->Execute($sql))
    {
      // ���������� ������� �� ��������� ���������� ID
      if($Q->ExecSQL('Select LAST_INSERT_ID() as LastID from `touritems`'))
      {
        $Q->FieldFirst();
        $Result = $Q->Row->LastID;
      }
    }
    $Q->CloseQuery();
    // ����������� ����������
    unset($sql);
    unset($Q);
    return $Result;
  }




