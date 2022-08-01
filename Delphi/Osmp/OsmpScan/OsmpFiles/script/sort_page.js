var sourceArray;

function setSourceArray(folders)
{
  // Добавляем папку abricos_tv к массиву папок
  try {
    folders.push(['abricos_tv',[]]);
  } catch(err){
  }finally{
    // Присваеваем значение sourceArray
    sourceArray = folders;
  }
}

function getFolder(folder)
{
	for(var i=0;i<sourceArray.length;i++){
	  if (sourceArray[i][0] == folder){
	    return sourceArray[i][1];
	  }
	}
}

function prvArraySortComparator(a,b)
{
	if (a[0]>b[0]) return -1;
	if (a[0]<b[0]) return 1;
	return 0;
}

function transformArray(arr)
{
	var oldArray = arr;
	var newArray = new Array();
	
	for (i=0; i<oldArray.length; i++)
	{
	  so = getRating(oldArray[i])
	  if ((so >= 0) || (hideRestrProv == 0))
	  {
	    newArray.push([so,oldArray[i]]);
	  }
	}
	newArray.sort(prvArraySortComparator);
	var oldArray = new Array();
	for (i=0; i<newArray.length; i++)
	{
	  oldArray.push(newArray[i][1]);
	}
	return oldArray;	
}

function getRating(prv)
{
	var retVal = -1;
	if (isArray(prv))
	{
	  var fld = getFolder(prv[1]);
	  var prvCount = 0;
	  var uniqPrv = new Array();
	  retVal = 0;               

	  // Some folders contains same providers, 
	  // so we must exclude them from rating	  
	  for(var a=0;a<fld.length;a++)
	  {
	    canAdd = 1;
		
		// TODO: Fix recursive providers retriveal
		if (!isArray(fld[a]))
		{
		  pushPrv = value[fld[a]]["prv_id"];
		}

	    for(var b=0;b<uniqPrv.length;b++)
	    {
	      if (uniqPrv[b]==pushPrv) canAdd = 0;
	    }
	    if (canAdd==1) uniqPrv.push(pushPrv);
	  }

	  
	  for(var j=0;j<uniqPrv.length;j++)
	  {
	    rating = getRating(uniqPrv[j]);
	    if (rating>=0) 
	    {
	      prvCount++;
	    }
	    retVal += (rating < 0) ? 0 : rating;
	  }
	  retVal = (prvCount == 0) ? -1 : retVal;
	} 
	else
	{
	    if (hideRestrProv && value[prv] && value[prv]["always_display"] == "1")
	      sortOrder.push([prv, 0]);
	    else
	        prv = value[prv]["prv_id"];
	        
	    for(var i=0;i<sortOrder.length;i++)
	    {	 
	      if (sortOrder[i][0] == prv)
	      {
	        retVal = sortOrder[i][1];
	      }		
	    }
	}
	return retVal;
}

function setSortOrder(prv)
{
	for(var i=0;i<sortOrder.length;i++)
	{
	  if (sortOrder[i][0] == prv)
	  {
	    sortOrder[i][1]++;
	    return true;
	  }
	}
	sortOrder.push([prv,1]);
}

