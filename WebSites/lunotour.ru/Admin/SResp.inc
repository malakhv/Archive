<?php
  function SaveResponse($id, $RDate, $Name, $Rus, $Text)
  {
    // Подготовка переменных
    $Name = addslashes(trim($Name));
    $Text = addslashes(trim($Text));
    // Работа с датой
    $RDate = strtotime($RDate);
    $RDate = date('Y-m-d',$RDate);
    // Если id <> -1, то обновляем запись в таблице, иначе создаем новую
    if($id != -1)
      $sql = 'UPDATE `response` SET `Rus` = '.$Rus.', `RDate` = "'.$RDate.'",
        `Name` = "'.$Name.'", `Text` = "'.$Text.'" WHERE `response`.`id` = '.$id.';';
    else
      $sql = 'INSERT INTO `response` (`Rus`,`RDate`,`Name`,`Text`) VALUES
        ('.$Rus.', CURDATE(),"'.$Name.'","'.$Text.'" );';
    // Выполнение запроса
    return Execute($sql,true);
  }
?>
