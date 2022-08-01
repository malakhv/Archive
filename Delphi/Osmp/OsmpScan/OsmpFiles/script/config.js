var authOnlineCellular = false;

var extraPrv = [
['103',[3189,'---','tv.gif']],
['103',[6138,'provider2','internet.gif']],
['40',[14781,'Абрикос - Базовый пакет','abricos.gif']],
['40',[14801,'Абрикос-Социальный пакет','abricos.gif']],
['123',[16567,'СМС-Дневник Камышин','sms_kam.gif']],
['40',[19348,'Абрикос - Интернет','abricos.gif']],
['40',[19349,'Абрикос - Переподключение','abricos.gif']],
['123',[20544,'Торговый Дом Камышина','krediti.gif']]
];

var fieldDescr = function(fname,mask,ml,tl,cp)
{
	this.fieldName = fname;
	this.fieldMask = mask;
	this.maxLength = ml;
	this.title = tl;
	this.caption = cp;
	this.enteredValues = new Array();
}

var fieldsDescr = new Array();

fieldsDescr["3189"] = new Array();
fieldsDescr["3189"].push(new fieldDescr('account','\\d{6}',10,'введите номер ','-'));
fieldsDescr["6138"] = new Array();
fieldsDescr["6138"].push(new fieldDescr('account','\\d{4}',4,'Номер ЛС',''));
fieldsDescr["14781"] = new Array();
fieldsDescr["14781"].push(new fieldDescr('account','\\d{6}-\\d{4}',10,'Введите номер лицевого счёта и ПИН-код','Узнать свой лицевой счёт и ПИН-код можно по телефону 8-927-501-03-11'));
fieldsDescr["14801"] = new Array();
fieldsDescr["14801"].push(new fieldDescr('account','\\d{6}-\\d{4}',6,'Введите номер лицевого счёта и ПИН-код','Узнать свой лицевой счёт и ПИН-код можно по телефону 8-927-501-03-11'));
fieldsDescr["16567"] = new Array();
fieldsDescr["16567"].push(new fieldDescr('account','\\d{2}-8(\\d{3})\\d{3}-\\d{2}-\\d{2}',12,'Введите номер школы и свой номер телефона {зарегистрированный в договоре}',''));
fieldsDescr["19348"] = new Array();
fieldsDescr["19348"].push(new fieldDescr('account','\\d{6}-\\d{4}',10,'Введите номер лицевого счёта и ПИН-код','Узнать свой лицевой счёт и ПИН-код можно по телефону 8-927-501-03-11'));
fieldsDescr["19349"] = new Array();
fieldsDescr["19349"].push(new fieldDescr('account','\\d{6}-\\d{4}',10,'Введите номер лицевого счёта и ПИН-код','Узнать свой лицевой счёт и ПИН-код можно по телефону 8-927-501-03-11'));
fieldsDescr["20544"] = new Array();
fieldsDescr["20544"].push(new fieldDescr('account','\\d{8}-\\d{4}',10,'Введите номер договора аренды и ПИН-код','Узнать свой номер договора аренды и ПИН-код можно по телефону 8-927-501-03-11'));

