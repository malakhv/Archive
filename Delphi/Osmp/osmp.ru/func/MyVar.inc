<?php


  class TMyVar
  {
    function GetVar($VarName, $DefVal)
    {
      if(isset($_GET[$VarName]))
        return $_GET[$VarName];
      else
        return $DefVal;
    }

    function GetInt($VarName)
    {
      return (integer) $this->GetVar($VarName,-1);
    }
    
    function GetID($VarName)
    {
      $Result = $this->GetInt($VarName);
      if($Result < 0) $Result = -1;
      return $Result;
    }
    
    function PostVar($VarName, $DefVal)
    {
      if(isset($_POST[$VarName]))
        return $_POST[$VarName];
      else
        return $DefVal;
    }
    
    function PostInt($VarName)
    {
      return (integer) $this->PostVar($VarName,-1);
    }
    
    function PostID($VarName)
    {
      $Result = $this->PostInt($VarName);
      if($Result < 0) $Result = -1;
      return $Result;
    }
    
    function ReVar($VarName, $DefVal)
    {
      if(isset($_REQUEST[$VarName]))
        return $_REQUEST[$VarName];
      else
        return $DefVal;
    }
    
    function ReInt($VarName)
    {
      return (integer) $this->ReVar($VarName,-1);
    }
    
    function ReID($VarName)
    {
      $Result = $this->ReInt($VarName);
      if($Result < 0) $Result = -1;
      return $Result;

    }
  }
  
  class TMySessionVar
  {
    function GetVar($VarName, $DefValue)
    {
      $Result = $DefValue;
      if(isset($_SESSION[$VarName]))
        if(!empty($_SESSION[$VarName]))
          $Result = $_SESSION[$VarName];
      return $Result;
    }
  }
?>
