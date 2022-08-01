<?php
  function SaveTour($id, $Name, $ShortName,  $Address, $Logo, $SubCat_id)
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDefAdmin();
    if($id != -1)
      $sql = 'UPDATE `tour` SET `Name` = "'.addslashes($Name).'", `ShortName` = "'.addslashes($ShortName).'", `Address` = "'.addslashes($Address).'", `Logo` = "'.$Logo.'", `SubCat_id` = '.$SubCat_id.' WHERE `tour`.id = '.$id.';';
    else
      $sql = 'INSERT INTO `tour` (`Name`, `ShortName`, `Address`, `Logo`, `SubCat_id`) VALUES ("'.addslashes($Name).'","'.addslashes($ShortName).'","'.addslashes($Address).'","'.$Logo.'",'.$SubCat_id.')';
    $Q->Execute($sql);
    $Q->CloseQuery();
    unset($sql);
    unset($Q);
  }
?>


