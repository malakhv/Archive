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
?>
