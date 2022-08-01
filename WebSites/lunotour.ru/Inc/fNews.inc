<?php

  function vNews()
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDef();
    
    if($Q->ExecSQL('Select * from `vnews`;'))
    {
      $Q->FieldFirst();
      while(!$Q->Eof)
      {
        echo '<p><table class="News"><tr><td>Дата:&nbsp;'.date('d.m.Y',$Q->Row->NDate).'.';
        if($Q->Row->NewsCat_id != 1)
          echo 'Категория:&nbsp;<b>'.$Q->Row->CatName.'.</b>';
        echo '</td></tr>';
        echo '<tr><td>'.$Q->Row->ShortText.'</td></tr>';
        echo '<tr><td align="right"><a class="News" href="index.php?news='.$Q->Row->id.'">Подробнее...</a></td></tr>';
        echo '</table></p>';
        $Q->FieldNext();
      }
      echo '<br>';
    }
    $Q->CloseQuery();
    unset($Q);
  }
  
  function NewsInfo($id)
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDef();
    if($Q->ExecSQL('Select * from `vnews` where `vnews`.`id` = '.$id.';'))
    {
      if($Q->RecCount != 0)
      {
        $Q->FieldFirst();
        if($Q->Row->NewsCat_id != 1)
          echo '<h2>'.$Q->Row->CatName.'<br>';
        else
          echo '<h2>';
        echo 'Дата:&nbsp;'.date('d.m.Y',$Q->Row->NDate).'</h2>';
        echo '<p>'.trim($Q->Row->Text).'</p>';
      }
    }
    $Q->CloseQuery();
    unset($Q);
  }
?>



