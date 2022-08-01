<?php

  class TText
  {
    private $EText = '';
    private $EHTML = true;
    public $String = array();
    
    function __set($nm,$val)
    {

      if($nm == 'Text')
      {
        $this->EText = trim($val);
        if($this->EHTML)
          $this->EText = htmlspecialchars($this->EText);
        $this->String = explode(chr(13),$this->EText);
        foreach($this->String as &$value)
          $value = trim($value);
      }
      
      if($nm == 'HTML')
      {
        $this->EHTML = $val;
      }

    }
    
    function __get($nm)
    {
      if($nm == 'Text')
      {
        return $this->EText;
      }
      
      if($nm == 'HTML')
      {
        return $this->EHTML;
      }
      
      if($nm == 'ParseStr')
      {
        if(count($this->String) > 0)
        {
          $Result = $this->String[0];
          for($i = 0; $i <  count($this->String) - 1; $i++)
          {
            $Result = $Result.'<br>'.$this->String[$i+1];
          }
        }
        return $Result;
      }
    }
  
    function __destruct()
    {
      $this->EText = '';
      unset($String);
    }
  }

?>

