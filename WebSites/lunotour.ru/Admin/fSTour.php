<?php
  function SaveTour($id, $Name, $Address, $Logo, $SubCat_id)
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDef();
    if($id != -1)
      $sql = 'UPDATE `Tour` SET `Name` = "'.$Name.'", `Address` = "'.$Address.'", `Logo` = "'.$Logo.'", `SubCat_id` = '.$SubCat_id.' WHERE `Tour`.id = '.$id.';';
    else
      $sql = 'INSERT INTO `Tour` (`Name`, `Address`, `Logo`, `SubCat_id`) VALUES ("'.$Name.'","'.$Address.'","'.$Logo.'",'.$SubCat_id.')';
    $Q->Execute($sql);
    $Q->CloseQuery();
    unset($sql);
    unset($Q);
  }
?>


