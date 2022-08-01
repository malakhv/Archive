<html>
  <head>
    <title>Фотографии</title>
    <link rel="stylesheet" type="text/css" href="Main.css">
  </head>
<body>
  <?php
    include "Body/BodyStart.inc";
    include "Inc/DBCon.inc";
    include "Inc/fVar.inc";
    include "Inc/fImg.inc";
    include "Inc/fPhoto.inc";
    $section = GetID('section');
    if($section != -1)
      vPhoto($section);
    else
      vSection();
    include "Body/BodyEnd.inc";
  ?>
</body>
</html>



