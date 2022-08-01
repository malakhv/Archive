<html>
  <head>
    <title> Статистика использование принтера </title>
  </head>
  <body alink="navy" link="navy" vlink="navy">
    <?php
      function xodbc_num_rows($sql_id, $CurrRow = 0)
      {
        $NumRecords = 0;
        odbc_fetch_row($sql_id, 0);
        while (odbc_fetch_row($sql_id))
        {
          $NumRecords++;
        }
        odbc_fetch_row($sql_id, $CurrRow);
        return $NumRecords;
      }
      function xodbc_fetch_array($result, $rownumber=-1)
      {
        if ($rownumber < 0)
        {
          odbc_fetch_into($result, &$rs);
        } else
        {
          odbc_fetch_into($result, &$rs, $rownumber);
        }
        $conn = odbc_connect ("PrinterStat", "", "");  foreach ($rs as $key => $value)
        {
          $rs_assoc[odbc_field_name($result, $key+1)] = $value;
        }
        return $rs_assoc;
      }

    #Создание списка
      
    $x=odbc_connect("PrinterStat","","");
    if($UsID != 'Все пользователи'):
      $res=odbc_exec($x,"select * from Report where Report.UName = '$UsID'");
    else:
      $res=odbc_exec($x,"select * from Report");
    endif;
    $cnt=xodbc_num_rows($res);
  ?>
  
<!--  <img src="PrntTools.png" alt="Printer">
  <hr>-->
  
  <h2 align="center" > Статистика использование принтера </h2>
  <table align="center" border=1 cellspacing=0 cellpadding=2>
  <tr bgcolor=silver align="center">
    <td>Пользователь</td>
    <td>Принтер</td>
    <td>Документ</td>
    <td>Компьютер</td>
    <td>Страниц</td>
    <td>Дата</td>
  </tr>
  <?
    for ($i=0;$i<$cnt;$i++)
    {
      $row=xodbc_fetch_array($res,$i+1);
      echo '<tr><td>'.$row['UName'].'</td><td>'.$row['PName'].'</td><td>'.$row['Document'].'</td><td>'.$row['Machine'].'</td><td align="right">'.$row['PageCount'].'</td><td>'.$row['Date'].'</td></tr>';
    }
  ?>
  </table>
  
  <br>
  <a href="index.php"> Вернуться к списку пользователей </a>
  <br>&nbsp;<br>
  
  <hr>

  </body>
</html>



