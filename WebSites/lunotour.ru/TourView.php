<html>
  <head>
    <title>Туры</title>
    <link rel="stylesheet" type="text/css" href="Main.css"/>
  </head>
<body>
  <?php
    include "Body/BodyStart.inc";
    include "Inc/DBCon.inc";
    include "Inc/fVar.inc";
    include "Inc/fImg.inc";
    include "Inc/fTourView.inc";
    $tour = GetID('tour');
    if($tour != ID_ERROR)
      TourInfo($tour);
    include "Body/BodyEnd.inc";
  ?>
</body>
</html>













