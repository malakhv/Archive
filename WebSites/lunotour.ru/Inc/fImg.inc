<?php

  function GetPercent($x, $maxx)
  {
    $k = 1;
    if($x > $maxx)
      $k = $x / $maxx;
    return $k;
  }
  
  function GetNewImgSize(&$w,&$h,$maxw,$maxh)
  {
    $pw = GetPercent($w,$maxw);
    $ph = GetPercent($h,$maxh);
    if($pw > $ph)
    {
      $w = (integer) $w /$pw;
      $h = (integer) $h / $pw;
    }
    else
    {
      $w = (integer) $w / $ph;
      $h = (integer) $h / $ph;
    }
  }

?>

