<?php
  function SaveResponse($id, $RDate, $Name, $Rus, $Text)
  {
    // ���������� ����������
    $Name = addslashes(trim($Name));
    $Text = addslashes(trim($Text));
    // ������ � �����
    $RDate = strtotime($RDate);
    $RDate = date('Y-m-d',$RDate);
    // ���� id <> -1, �� ��������� ������ � �������, ����� ������� �����
    if($id != -1)
      $sql = 'UPDATE `response` SET `Rus` = '.$Rus.', `RDate` = "'.$RDate.'",
        `Name` = "'.$Name.'", `Text` = "'.$Text.'" WHERE `response`.`id` = '.$id.';';
    else
      $sql = 'INSERT INTO `response` (`Rus`,`RDate`,`Name`,`Text`) VALUES
        ('.$Rus.', CURDATE(),"'.$Name.'","'.$Text.'" );';
    // ���������� �������
    return Execute($sql,true);
  }
?>
