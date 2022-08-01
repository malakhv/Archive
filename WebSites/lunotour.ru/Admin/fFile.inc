<?php
  function DeleteFile($FileName)
  {
    if(file_exists($FileName))
      return @ unlink($FileName);
  }
  
  function UploadFile($UserFile,$UpName,$FileType)
  {
    $Result = $_FILES[$UserFile]['error'];
    if($Result == 0)
    {
      // Проверка типа файла
      if($_FILES[$UserFile]['type'] == $FileType || $FileType == '')
      {
        // Формирование пути файла
        if($_FILES[$UserFile]['tmp_name'])
        {
          if(!move_uploaded_file($_FILES[$UserFile]['tmp_name'],$UpName))
            $Result = 10;
        }
      }
      else
        $Result = 20;
    }
    return $Result;
  }
?>
