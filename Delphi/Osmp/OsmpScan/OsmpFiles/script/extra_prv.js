function getExtraPrvIcon(id)
{
	return "./img/custom/"+id;
}

// Если true, то работаем с папкой abricos_tv, иначе с папкой tv
var IsAbricosFolder = true;

// Функция возвращает имя папки, в которую нужно поместить провайдера Абрикос
function GetAbricosFolder()
{
  if(IsAbricosFolder)
    return 'abricos_tv'
  else
    return 'tv';
}

function getExtraFolder(id)
{
	switch(id)
	{
           case '40': return GetAbricosFolder();
           case '81': return 'ecommerce';
           case '103': return 'internet';
           case '123': return 'other';
           case '382': return 'folder_zkh';
           default: return 'other';
	}
}

function getExtraRecord(i)
{
	var addVal=new Object();
	addVal.prv_id = extraPrv[i][1][0];
	addVal.prv_name = extraPrv[i][1][1];
	addVal.prv_folder = getExtraFolder(extraPrv[i][0]);
	addVal.prv_image = getExtraPrvIcon(extraPrv[i][1][2]);
	addVal.prv_page = "./p_custom.html";
	addVal.prv_page_conf = "./validate_confirm_extra.html";
	addVal.prv_title = extraPrv[i][1][4];
	addVal.prv_caption = extraPrv[i][1][5];
	addVal.prv_alert = '<font weight=bold size=5>'+addVal.prv_name+'</font>'+
	  '<br><br><font size=4 color=red>Внимание!<br>По вопросам зачисления платежей обращайтесь к владельцу автомата!</font>';
	addVal.prv_is_extra = 1;
	return addVal;
}

// Функция возвращает true при успешном добавлении информации о папке abricos,
// иначе false
function AddAbricosFolder()
{
  try{
    if( value["abricos"] == null )
    {
      // Добавляем в массив Value информации о папке abricos
      value["abricos"] = new Array ();
      value["abricos"]["prv_image"] = "./img/custom/abricos.gif";
    }
    return true;
  }catch(err){
    return false;
  }
}

function linkExtraPrv(arr,folder)
{
  var newArray = new Array();
	newArray=arr;

	if (typeof(extraPrv) == 'undefined') 
	{
		return newArray;
	}

  // My Code Start
  if( folder ==  "tv" )
  {
    IsAbricosFolder = AddAbricosFolder();
    if(IsAbricosFolder)
      try{
      // Добавление папки abricos в начало массива провайдеров
      newArray.unshift(['abricos','abricos_tv']);
      }catch(err){
        IsAbricosFolder = false;
      }
  }

	for (var i=0;i<extraPrv.length;i++)
	{
	  if (getExtraFolder(extraPrv[i][0])==folder)
	    newArray.unshift(value.length)
	  value.push(getExtraRecord(i));
	}
		
	return newArray;
}

function addExtraPrvToValues()
{
	if (typeof(extraPrv) == 'undefined') 
	{
		return;
	}

	for (var i=0;i<extraPrv.length;i++)
	{
	  value.push(getExtraRecord(i));
	}

}

function getIndexOfPrv(id) 
{ 
        for(i=1;i<value.length;i++) 
        { 
                try 
                { 
                        if (value[i].prv_id == id) 
                        { 
                                return i; 
                        } 
                } 
                catch(e) {}; 

        } 
        return 1; 
} 

