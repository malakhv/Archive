<?php

  function GetVar($VarName, $DefVal)
  {
    $Result = $DefVal;
    if(isset($_GET[$VarName]))
      $Result = $_GET[$VarName];
    return $Result;
  }

  function GetInt($VarName)
  {
    return  (integer) GetVar($VarName,-1);
  }

  function GetID($VarName)
  {
    $Result = (integer) GetVar($VarName,-1);
    if($Result <= 0)
      $Result = -1;
    return $Result;
  }
  
  function PostVar($VarName, $DefVal)
  {
    $Result = $DefVal;
    if(isset($_POST[$VarName]))
      $Result = $_POST[$VarName];
    return $Result;
  }
  
  function PostID($VarName)
  {
    $Result = (integer) PostVar($VarName,-1);
    if($Result <= 0)
      $Result = -1;
    return $Result;
  }
  
  function PostInt($VarName)
  {
    return (integer) PostVar($VarName,-1);
  }
  
  function ReVar($VarName, $DefVal)
  {
    $Result = $DefVal;
    if(isset($_REQUEST[$VarName]))
      $Result = $_REQUEST[$VarName];
    return $Result;
  }
  
  function ReID($VarName)
  {
    $Result = (integer) ReVar($VarName,-1);
    if($Result <= 0)
      $Result = -1;
    return $Result;
  }
  
  // Session Work
  function GetSessionVar($VarName, $DefValue)
  {
    $Result = $DefValue;
    if(isset($_SESSION[$VarName]))
      if(!empty($_SESSION[$VarName]))
        $Result = $_SESSION[$VarName];
    return $Result;
  }
?>

