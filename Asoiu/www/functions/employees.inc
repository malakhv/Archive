<?php

  DEFINE('EmployeesTable','vemployees');
  DEFINE('iEmployees','select * from vemployees where vemployees.id = ');

  include "disciplines.inc";

  function GetImagePath($id, $type)
  {
    $path = 'img/employees/'.$type.'/'.$id.'jpg';
    if(file_exists($path))
      return $path;
    return 'img/employees/'.$type.'/def.jpg';
  }
  
  class TEmployees extends TTable
  {

   // private $EEmployees_id = -1;

    function __construct()
    {
      parent::__construct();
      $this->TableName = EmployeesTable;
    }
    
    function __destruct()
    {
      parent::__destruct();
    }

    function EmployeesList()
    {
      if(!$this->LastError)
      {
        if($this->RecCount != 0)
        {
          $i = 1;
          $g = -1;
          while(!$this->Eof)
          {
            // Смена группы должностей
            if($g != $this->Row->PostGroup_id)
            {
              // Если должности меняються не первый раз, закрываем таблицу
              if($g != -1)
              {
                if($i % 2 == 0)
                  echo '</tr>';
                echo '</table>';
              }
              echo '<h1>'.$this->Row->PostGroup.'</h1><table class="employees" width="100%">';
              $g = $this->Row->PostGroup_id;
              $i = 1;
            }

            if($i % 2 == 1) echo '<tr>';
            // Информация о сотруднике
            echo '<td><img src="'.GetImagePath($this->Row->id,'small').'" height="75" width="60" align="left" vspace="2" alt="">';
            echo '<p class="name">'.$this->Row->FName.' '.$this->Row->Name.' '.$this->Row->LName.'</p>';
            echo $this->Row->Degree.'<br>'.$this->Row->Post.'<br><a href="employees.php?emp='.$this->Row->id.'">Инфoрмация...</td>';
            if($i % 2 == 0) echo '</tr>';
            $i++;
            $this->FieldNext();
          }
          // Конец таблицы сотрудников
          if($i % 2 == 0)
            echo '</tr>';
          echo '</table><br>';
        }
        else
          echo '<tr><td><h1>Нет данных</h1></td></tr>';
      }
    }

    function EmployeesInfo($id)
    {
      $this->id = $id;
      if(!$this->LastError);
      {
        if($this->RecCount > 0)
        {
          echo '<h1>'.$this->Row->FName.' '.$this->Row->Name.' '.$this->Row->LName.'</h1>';
          echo '<img src="'.GetImagePath($this->Row->id,'big').'" height="150" width="120" align="left" alt=""><table>';
          echo '<tr><td>Должность&nbsp;</td><td>:&nbsp;'.$this->Row->Post.'</td></tr>';
          echo '<tr><td>Ученая степень&nbsp;</td><td>:&nbsp;'.$this->Row->Degree.'</td></tr>';
          echo '<tr><td>Ученое звание&nbsp;</td><td>:&nbsp;'.$this->Row->AStatus.'</td></tr>';
          echo '<tr><td>Базовое образование&nbsp;</td><td>:&nbsp;'.$this->GetParseHTMLStr('BEducation').'</td></tr></table><br clear="all">&nbsp;<br>';
          echo '<h2>Информация:</h2><p class="info">'.$this->GetParseHTMLStr('Info').'</p>';
          echo '<h2>Награды:</h2><p class="info">'.$this->RowStr('Awards').'</p>';
          echo '<h2>Преподаваемые дисциплины:</h2><p class="info">';
          $CurDis = new TCurrentDis;
          $CurDis->Employees_id = $id;
          if($CurDis->RecCount > 0)
          {
            echo '<ul>';
            while(!$CurDis->Eof)
            {
              echo '<li><a href="disciplines.php?dis='.$CurDis->Row->Disciplines_id.'">'.$CurDis->Row->Name.'...</a></li>';
              $CurDis->FieldNext();
            }
            echo '</ul>';
          }
          echo '</p>';
          unset($CurDis);
        }
      }
    }
  }
?>
