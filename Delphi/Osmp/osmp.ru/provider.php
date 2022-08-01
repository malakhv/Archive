<?php
  include "func/MyVar.inc";
  include "func/xml.inc";
  include "opt.inc";

  // Обработка данных запроса
  $MyVar = new TMyVar;
  $txn_id = $MyVar->GetVar('txn_id',NO_DATA);
  $account = $MyVar->GetVar('account',NO_DATA);
  $sum = $MyVar->GetVar('sum',NO_DATA);
  unset($MyVar);
  
  if(IsValidate($txn_id,$account,$sum))
  {
    $fName = $account.' ('.date('d-m-Y H i s').').xml'; // Имя файла
    $qDate = date('Y-m-d H:i:s');                       // Дата

    if(SAVE_LOCAL == '1')
    {
      if( ($h = @fopen(LOCAL_DIR.$fName,'w+t')) != false )
      {
        fwrite($h,BuildDateStr($txn_id,$account,$sum,$qDate)); fclose($h);
      }
      unset($h);
    };

    if(SAVE_FTP == '1')
    {
      if( ($h = @fopen('ftp://'.FTPLOGIN.':'.FTPPSWRD.'@'.FTP_DIR.$fName,'wt')) != false )
      {
        fwrite($h,BuildDateStr($txn_id,$account,$sum,$qDate)); fclose($h);
      }
      unset($h);
    }
    
    // Возврат положительного результата
    echo BuildResultStr($txn_id);
    
    // Уничтожение переменных
    unset($qDate);
    unset($fName);
  }
  // Уничтожение переменных
  unset($sum);
  unset($account);
  unset($txn_id);
?>
