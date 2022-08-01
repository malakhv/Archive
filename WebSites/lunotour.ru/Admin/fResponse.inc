<?php

  function vRes($Q, $Rus)
  {
    if($Rus == 1) echo '<h1>Россия</h1>';
    else echo '<h1>Заграница</h1>';
    echo '<ul class="Tour">';
    if($Q->ExecSQL('select * from `vresponse` where `vresponse`.`Rus` = '.$Rus.';'))
    {
      $Q->FieldFirst();
      
      while(!$Q->Eof)
      {
        echo '<li><a class="Admin" href="Response.php?del_resp='.$Q->Row->id.'">[-]</a>&nbsp;<a href="RespView.php?resp='.$Q->Row->id.'">'.$Q->Row->Name.'</a></li>';
        $Q->FieldNext();
      }
    }
    echo '<li><a class="Admin" href="Response.php?rus='.$Rus.'">[+]</a></li></ul>';
  }

  function vResponse()
  {
    $Query = new TQuery;
    $Query->OpenAndSelectDBDef();
    vRes($Query,1);
    vRes($Query,0);
    $Query->CloseQuery();
    unset($Query);
    unset($rus);
  }
  
  function DeleteRespImg($id)
  {
    $Result = Delete($id,'resp_image');
    if($Result)
     DeleteFile('../Content/RespImg/'.$id.'.jpg');
  }
  
  function DeleteResponse($id)
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDef();
    if($Q->ExecSQL('select * from `vresp_image` where `vresp_image`.`Response_id` = '.$id.';'))
    {
      $Q->FieldFirst();
      while(!$Q->Eof)
      {
        DeleteRespImg($Q->Row->id);
        $Q->FieldNext();
      }
    }
    Delete($id,'response');
  }
?>

