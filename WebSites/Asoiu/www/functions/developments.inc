<?php

  DEFINE('DevelopmentsTable','vdevelopments');

  include "DBCon.inc";
  
  class TDevelopments extends TTable
  {
    function __construct()
    {
      parent::__construct();
      $this->TableName = DevelopmentsTable;
    }
    
    function __destruct()
    {
      parent::__destruct();
    }
    
    function DevelopmentsList($ShortInfo = true)
    {
      if($this->LastError) return;
      // ������������ ������� ���������
      echo '<table class="info" width="100%"><tr class="head">
        <td>��������</td>
        <td>���������</td>';
      if(!$ShortInfo)
        echo '<td>����</td><td>����������</td>';
      echo '<td>����</td>';
      while(!$this->Eof)
      {
        echo '<tr>
          <td>'.$this->Row->Name.'</td>
          <td>'.$this->Row->CatName.'</td>';
        if(!$ShortInfo)
          echo '<td class="al_right">'.$this->Row->Price.'</td><td>'.$this->GetParseHTMLStr('Info').'</td>';
        echo '<td class="al_right">'.$this->GetDateField('DevDate').'</td></tr>';
        $this->FieldNext();
      }
      echo '</table>';
    }
  }
?>
