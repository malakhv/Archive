<?php

  include "Text.inc";

  class TDBConnection
  {
    var $Connection = 0;
    var $Connected  = false;
    var $HostName   = '';
    var $DBName     = '';

    function CloseConnect()
    {
      if($this->Connected)
        if($this->Connection != null)
          mysql_close($this->Connection);
      $this->Connected = false;
    }

    function OpenAttr($UserName, $Password)
    {
      $this->CloseConnect();
      $this->Connection = mysql_connect($this->HostName, $UserName, $Password);
      $this->Connected = (boolean) $this->Connection;
      return $this->Connected;
    }

    function OpenConnect()
    {
      $this->OpenAttr('root','');
    }

    function SelectDB()
    {
      if($this->Connected)
        return (boolean) mysql_select_db($this->DBName, $this->Connection);
      else
        return false;
    }

    function OpenAndSelectDB($Host,$DB,$User,$Passw)
    {
      $this->HostName = $Host;
      $this->DBName   = $DB;
      $this->OpenAttr($User,$Passw);
      return $this->SelectDB();
    }

    function OpenAndSelectDBDef()
    {
      $this->OpenAndSelectDB('mysql-srv16228.ht-systems.ru','srv16228_school','srv16228_usr','rsu1_');
      if($this->Connected) return $this->Connection;
      else return false;
    }
    
    function OpenAndSelectDBDefAdmin()
    {
      $this->OpenAndSelectDB('mysql-srv14529.ht-systems.ru','srv14529_myluno','srv14529_b1ind','x15kL3_R1');
      if($this->Connected) return $this->Connection;
      else return false;
    }
  };

  class TQuery extends TDBConnection
  {
    var $SQL = '';
    var $SQLResult = null;
    var $Row;
    var $Eof = false;
    var $RecCount = 0;
    var $FieldCount = 0;
    var $Fields = array();

    function QueryFree()
    {
      $this->RecCount = 0;
      $this->FieldCount = 0;
      $this->Eof = true;
      unset($this->Fields);
      if($this->SQLResult != null)
      {
        if(is_resource($this->SQLResult))
					mysql_free_result($this->SQLResult);
        $this->SQLResult = null;
        $this->Row = null;
      }
    }

    function CloseQuery()
    {
      $this->QueryFree();
      parent::CloseConnect();
    }

    function ExecSQL($MSQL = '') // true - выполнено успешно, false - нет.
    {
      $this->QueryFree();
      if(!$this->Connected) return false;
      if($MSQL != '') $this->SQL = $MSQL;
      $this->SQLResult = mysql_query($this->SQL,$this->Connection);
      if((boolean) $this->SQLResult)
      {
        // Количество записей
        $this->RecCount  = mysql_num_rows($this->SQLResult);
        // Количество полей
        $this->FieldCount = mysql_num_fields($this->SQLResult);
        // Формирование списка полей
        $i = 0;
        while($i < mysql_num_fields($this->SQLResult))
        {
          $meta = mysql_fetch_field($this->SQLResult,$i);
          if($meta):
            $this->Fields[$i] = $meta;
          endif;
          $i++;
        }
      }
      $this->Eof = $this->RecCount == 0;
      return (boolean) $this->SQLResult;
    }
    
    function Execute($MSQL = '')
    {
      $this->QueryFree();
      if(!$this->Connected) return false;
      if($MSQL != '') $this->SQL = $MSQL;
      $this->SQLResult = mysql_query($this->SQL,$this->Connection);
      return (boolean) $this->SQLResult;
    }

    function FieldNext() //true - данные есть, false - данных нету.
    {
      if(!$this->Connected) return false;
      $this->Row = mysql_fetch_object($this->SQLResult);
      $this->Eof = (boolean) !$this->Row;
      return !$this->Eof;
    }

    function FieldFirst()
    {
      $this->Eof = true;
      if($this->RecCount != 0)
      {
        mysql_data_seek($this->SQLResult,0);
        $this->FieldNext();
        $this->Eof = false;
      }
    }

    function FieldByName($FieldName)
    {
      return $this->Row->$FieldName;
    }

    function PrintField($FieldName)
    {
      echo $this->Row->$FieldName;
    }
    
    function StrNoData($Str)
    {
      if ($Str != '') return $Str;
      return 'Нет данных';
    }

    function RowStr($FieldName)
    {
      $str = trim($this->Row->$FieldName);
      return $this->StrNoData($str);
    }
  }
  
  class TTable extends TQuery
  {

    private $ETableName = '';
    private $ELastError = false;
    private $EText = null;
    private $EId = -1;
    
    public $EnabledNoDataStr = true;
    
    function __set($nm,$val)
    {
      if($nm == 'TableName')
      {
        if(trim($val) == '')
        {
          $this->QueryFree();
          $this->ETableName = '';
          return;
        }
        
        $this->ELastError = !$this->ExecSQL('select * from '.$val);
        if(!$this->ELastError)
        {
          $this->ETableName = $val;
          $this->FieldFirst();
        }
        else
          $this->ETableName = '';
      }
      
      if($nm == 'LastError')
        $this->ELastError = $val;

      if($nm == 'id')
      {
        if($this->ETableName != '')
        {
          $this->ELastError = !$this->ExecSQL('select * from '.$this->ETableName.' where '.$this->ETableName.'.id = '.$val);
          if(!$this->ELastError)
          {
            $this->EId = $val;
            $this->FieldFirst();
          }
          else
            $this->EId = -1;
        }
      }
    }
    
    function GetDateField($AFieldName)
    {
      return date('d.m.Y',$this->FieldByName($AFieldName));
    }
    
    function __get($nm)
    {
      if($nm == 'TableName')
        return $this->ETableName;
      if($nm == 'LastError')
        return $this->ELastError;
      if($nm == 'id')
        return $this->EId;
    }
    
    private function GetParse($AFieldName, $AHTML)
    {
      if($this->ETableName != '')
      {
        $this->EText->HTML = $AHTML;
        $this->EText->Text = $this->FieldByName($AFieldName);
        if($this->EnabledNoDataStr)
          return $this->StrNoData($this->EText->ParseStr);
        else
          return $this->EText->ParseStr;
      }
      return '';
    }

    function GetParseHTMLStr($AFieldName)
    {
      return $this->GetParse($AFieldName,true);
    }
    
    function GetParseStr($AFieldName)
    {
      return $this->GetParse($AFieldName,true);
    }

    function __construct()
    {
      $this->OpenAndSelectDBDef();
      $this->EText = new TText;
    }

    function __destruct()
    {
      $this->CloseQuery;
      unset($this->EText);
    }
  }
  
  function Execute($sql,$Admin = true)
  {
    $Query = new TQuery;
    if($Admin)
      $Query->OpenAndSelectDBDefAdmin();
    else
      $Query->OpenAndSelectDBDef();
    $Result = $Query->Execute($sql);
    $Query->CloseQuery();
    unset($Query);
    return $Result;
  }
  
  function Delete($id, $Table)
  {
    $sql = 'Delete from `'.$Table.'` where `'.$Table.'`.id = '.$id.';';
    return Execute($sql,true);
  }
?>





