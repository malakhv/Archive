<?php
  include "function/News.inc";
  $News = new TNews;
  $News->CreateNewsList(10,0,1);
  $News->CloseQuery();
  unset($News);
?>

