<?php

  DEFINE('CurrDis','select * from vcurrentdis');
  DEFINE('Disciplines','select * from vdisciplines');
  DEFINE('DisciplinesTable','vdisciplines');
  
  include "DBCon.inc";

  class TCurrentDis extends TTable
  {

    private $EEmployees_id = -1;
    
    function __set($nm,$val)
    {
      if($nm == 'Employees_id')
      {
        $this->EEmployees_id = $val;
        $this->LastError = !$this->ExecSQL(CurrDis.' where Employees_id = '.$this->EEmployees_id);
        if(!$this->LastError)
        {
          $this->FieldFirst();
        }
        else
          $this->EEmployees_id = -1;
      }
    }

    function GetCurrentDis($Emp_id = -1)
    {
      if($Emp_id != -1 )
        $this->Employees_id = $Emp_id;
      if($this->EEmployees_id != -1)
      {
        $this->FieldFirst();
        while(!$this->Eof)
        {
          echo $this->Row->Name;
          $this->FieldNext();
        }
        $this->FieldFirst();
      }
    }
  }
  
  class TDisciplines extends TTable
  {

    function __construct()
    {
      parent::__construct();
      $this->TableName = DisciplinesTable;
    }
    
    function __destruct()
    {
      parent::__destruct();
    }

    function DisciplinesList()
    {
      if(!$this->LastError)
      {
        echo '<table class="disciplines" width="100%"><tr class="head">
          <td>��������</td>
          <td width="60">�������</td>
          <td width="100">����� �����</td>
          <td width="100">������</td>
          <td width="100">������������</td>
          <td>����������</td>
        </tr>';
        $Text = new TText;
        while(!$this->Eof)
        {
          echo '<tr>
            <td>'.$this->Row->Name.'</td>
            <td class="al_right">'.$this->Row->Semestr.'</td>
            <td class="al_right">'.$this->Row->TotalTime.' ���.</td>
            <td class="al_right">'.$this->Row->LctrTime.' ���.</td>
            <td class="al_right">'.$this->Row->LbsTime.' ���.</td>
            <td>'.$this->GetParseHTMLStr('Info').'</td>
          </tr>';
          $this->FieldNext();
        }
        echo '</table>';
        unset($Text);
      }
    }
  }
?>
