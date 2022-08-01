<html>
  <head>
    <title>Отзывы туристов</title>
    <link rel="stylesheet" type="text/css" href="Main.css">
  </head>
<body>
  <?php
    include "Body/BodyStart.inc";
  ?>
  <?php
    include "Inc/DBCon.inc";
    include "Inc/fVar.inc";
    include "Inc/fImg.inc";
    include "Inc/fResponse.inc";
    
    $resp = GetID('resp');
    if($resp == -1)
      vResponse();
    else
      vRespInfo($resp);

    include "Body/BodyEnd.inc";
  ?>
</body>
</html>


