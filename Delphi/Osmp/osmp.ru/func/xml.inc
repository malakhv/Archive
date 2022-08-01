<?php

  // $ID - txn_id
  // $A  - account
  // $S  - sum
  // $DT - data

  define('NO_DATA','nd');

  function IsValidate($ID, $A, $S)
  {
    return (boolean)( ($ID > 0) && ($A != NO_DATA) && ($S > 0) );
  }
  
  function BuildDateStr($ID, $A, $S, $DT)
  {
    return
    '<?xml version="1.0" encoding="windows-1251" ?>
      <record>
        <datetime>'.$DT.'</datetime><id>'.$ID.'</id><type>302</type>
        <info>
          <lc_id>1</lc_id>
          <lc_ident>'.$A.'</lc_ident>
          <datetime>'.$DT.'</datetime>
          <sum>'.$S.'</sum>
          <type>Безналичный платёж</type><type_ident>1008</type_ident>
          <bank>Банк Москвы</bank><bik>323233213</bik>
          <cacc>09876509876512341234</cacc>
          <racc>55576509876436451234</racc><number>0067890898768908</number>
        </info>
      </record>';
  }
  
  function BuildResultStr($ID)
  {
    return
    '<?xml version="1.0"?>
    <response><osmp_txn_id>'.$ID.'</osmp_txn_id><result>0</result></response>';
  }
  
?>
