<html>
  <head>
    <title>Туры</title>
    <link rel="stylesheet" type="text/css" href="Main.css">
  </head>
<body>
  <?php
    include "Body/BodyStart.inc";
    include "Inc/DBCon.inc";
    include "Inc/fVar.inc";
    include "Inc/fTour.inc";
    $cat = GetID('cat');
    if($cat != -1)
      vSubCat($cat);
    else
      vCat();
    include "Body/BodyEnd.inc";
  ?>
</body>
</html>








