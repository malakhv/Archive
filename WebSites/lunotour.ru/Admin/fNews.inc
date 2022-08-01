<?php

  function EchoDate($timestmp)
  {
    echo date('d.m.Y',$timestmp);
  }

  function vNewsCat()
  {
    $Q = new TQuery;
    $Q->OpenAndSelectDBDef();
    echo '<h1>Новости</h1>';
    echo '<ul class="Tour">';
    if($Q->ExecSQL('select * from vnewscat'))
    {
      $Q->FieldFirst();
      while(!$Q->Eof)
      {
        echo '<li><a class="Admin" href="News.php?del_newscat='.$Q->Row->id.'">[-]</a><a href="News.php?newscat='.$Q->Row->id.'">'.$Q->Row->Name.'</a></li>';
        $Q->FieldNext();
      }
    }
    echo '<li><a class="Admin" href="News.php?new_newscat=1">[+]</a></li></ul>';
    $Q->CloseQuery();
    unset($Q);
  }
  
  function vNews($NewsCat_id)
  {
    if($NewsCat_id == -1) return 0;
    $Q = new TQuery;
    $Q->OpenAndSelectDBDef();
    // Информация о категории новости
    if($Q->ExecSQL('Select * from `vnewscat` where `vnewscat`.`id` = '.$NewsCat_id.''))
    {
      if($Q->RecCount != 0)
      {
        $Q->FieldFirst();
        echo '<h1>'.$Q->Row->Name.'</h1>';
        if($NewsCat_id != 1)
        {
          // Форма изменения информации о категории новостей
          ?>
          <p><form action="News.php?newscat=<?php echo $NewsCat_id; ?>" method="post">
            <input name="id" type="hidden" value="<?php echo $Q->Row->id; ?>">
            <input name="Name" type="text" value="<?php echo $Q->Row->Name; ?>"><br>
            <input class="Btn" name="save_newscat" type="submit" value="Save">
          </form><p>
          <?php
        }
      }
    }
    
    // Создать новость
    echo '<a href="News.php?newscat='.$NewsCat_id.'&new_news=1">Создать новость</a><hr size="1" noshade>';

    if($Q->ExecSQL('Select * from `vnews` where `vnews`.`NewsCat_id` = '.$NewsCat_id.';'))
    {
      $Q->FieldFirst();
      while(!$Q->Eof)
      {
        // Форма изменения информации о новости
        ?>
          <p><b><?php EchoDate($Q->Row->NDate); ?></b><br><form action="News.php?newscat=<?php echo $NewsCat_id; ?>" method="post">
            <input name="id" type="hidden" value="<?php echo $Q->Row->id; ?>">
            <input name="NewsCat_id" type="hidden" value="<?php echo $Q->Row->NewsCat_id; ?>">
            Дата:<br>
            <input name="NDate" type="text" value="<?php EchoDate($Q->Row->NDate); ?>"><br>
            Новость кратко:<br>
            <input name="ShortText" type="text" value="<?php echo $Q->Row->ShortText; ?>"><br>
            Текст новости:<br>
            <textarea name="Text" rows="6" wrap="off"><?php echo $Q->Row->Text; ?></textarea><br>
            <input class="Btn" name="save_news" type="submit" value="Save">
            <input class="Btn" name="del_news" type="submit" value="Delete">
          </form>
          </p>
        <?php
        $Q->FieldNext();
      }
    }
    $Q->CloseQuery();
    unset($Q);
  }
  
  function SaveNews($id, $ShortText, $Text, $NDate, $NewsCat_id)
  {
    // Работа с датой
    $NDate = strtotime($NDate);
    $NDate = date('Y-m-d',$NDate);
    // Формирование запроса
    if($id != -1)
      $sql = 'UPDATE `news` SET `ShortText` = "'.trim($ShortText).'", `Text` = "'.trim($Text).'", `NDate` = "'.$NDate.'", `NewsCat_id` = '.$NewsCat_id.' WHERE `news`.`id` = '.$id.';';
    else
      $sql ='INSERT INTO `news` (`ShortText`, `Text`, `NDate`, `NewsCat_id`) VALUES ("'.trim($ShortText).'", "'.trim($Text).'", CURDATE(), '.$NewsCat_id.');';
    echo $sql;
    // Выполнение запроса
    return Execute($sql,true);
  }
  
  function SaveNewsCat($id, $Name)
  {
    // Формирование запроса
    if($id != -1)
      $sql = 'UPDATE `newscat` SET `Name` = "'.trim($Name).'" WHERE `newscat`.`id` = '.$id.';';
    else
      $sql = 'INSERT INTO `newscat` (`Name`) VALUES ("'.trim($Name).'");';
    // Выполнение запроса
    return Execute($sql,true);
  }
  
  function DeleteNews($id)
  {
    return Delete($id,'news');
  }
  
  function DeleteNewsCat($id)
  {
    if($id != 1)
      Delete($id,'newscat');
  }

?>






