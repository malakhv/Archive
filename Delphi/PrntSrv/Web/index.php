<html>
  <head>
    <title> Выбор пользователя </title>
  </head>
  <body>
  
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

      $x=odbc_connect("PrinterStat","","");
      $res=odbc_exec($x,"Select distinct Report.UName from Report order by Report.UName");
      $cnt=xodbc_num_rows($res);
     ?>
     
     <!-- <img src="PrntTools.png" alt="Printer">
      <hr>-->
     
     <h2 align="center"> Просмотр статистики использования принтера </h2>
     
      <form action="Stat.php" method=get>
      <select name="UsID">
        <option value='Все пользователи' selected> Все пользователи  </option>
        <?php
          for ($i=0;$i<$cnt;$i++)
          {
            $row=xodbc_fetch_array($res,$i+1);
            #echo '<option value = \"'.$row['UName'].'\">'.$row['UName'].'</option>';
            echo '<option value ='.$row['UName'].'>'.$row['UName'].'</option>';
          }
        ?>
      </select>
      <br> &nbsp;
      <br>
      <input name="btnEdit" type=submit value="Показать">
    </form>
    
    <hr>

  </body>
</html>


