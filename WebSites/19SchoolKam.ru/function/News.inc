<?php

  DEFINE('NewsTable','vnews');
  DEFINE('NewsList','select * from vnews');
  DEFINE('NewsInfo','select * from vnews where vnews.id = ');

  include "function/DBCon.inc";
  
  class TNews extends TTable
  {

    private $ENews_id = -1;

    function __construct()
    {
      parent::__construct();
    }

    function __destruct()
    {
      parent::__destruct();
    }
    
    function __set($nm,$val)
    {
      if($nm == 'News_id')
      {
        $this->LastError = $this->ExecSQL(NewsInfo.$val);
        if(!$this->LastError)
        {
          $this->FieldFirst();
          $this->ENews_id = $val;
        }
        else
          $this->ENews_id = -1;
      }
    }
    
    function GetNewsInfo($id = -1)
    {
      if($id != -1)
        $this->News_id = $id;
      if($this->Row != null)
      {
        echo '<h3 align="center">'.$this->Row->Name.'<br>'.$this->GetDateField('NDate').'</h3>';
        if($this->Row->Text != '')
          echo '<p>'.$this->Row->Text.'</p>';
      }
    }
    
    function CreateNewsList($NewsLimit,$LimitStart, $ListType)
    {
      $sql = NewsList;
      if($NewsLimit > 0)
        $sql = $sql.' limit '.$LimitStart.', '.$NewsLimit;
      if($this->ExecSQL($sql))
      {
        $this->FieldFirst();
        while(!$this->Eof)
        {
          if($ListType == 1)
            echo '<p class="news"><b>'.$this->GetDateField('NDate').'</b>&nbsp;<a href="news.php?id='.$this->Row->id.'">'.$this->Row->Name.'.</a></p>';
          $this->FieldNext();
        }
      }
    }
    
  }
?>
