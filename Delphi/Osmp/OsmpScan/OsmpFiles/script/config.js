var authOnlineCellular = false;

var extraPrv = [
['103',[3189,'---','tv.gif']],
['103',[6138,'provider2','internet.gif']],
['40',[14781,'������� - ������� �����','abricos.gif']],
['40',[14801,'�������-���������� �����','abricos.gif']],
['123',[16567,'���-������� �������','sms_kam.gif']],
['40',[19348,'������� - ��������','abricos.gif']],
['40',[19349,'������� - ���������������','abricos.gif']],
['123',[20544,'�������� ��� ��������','krediti.gif']]
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
fieldsDescr["3189"].push(new fieldDescr('account','\\d{6}',10,'������� ����� ','-'));
fieldsDescr["6138"] = new Array();
fieldsDescr["6138"].push(new fieldDescr('account','\\d{4}',4,'����� ��',''));
fieldsDescr["14781"] = new Array();
fieldsDescr["14781"].push(new fieldDescr('account','\\d{6}-\\d{4}',10,'������� ����� �������� ����� � ���-���','������ ���� ������� ���� � ���-��� ����� �� �������� 8-927-501-03-11'));
fieldsDescr["14801"] = new Array();
fieldsDescr["14801"].push(new fieldDescr('account','\\d{6}-\\d{4}',6,'������� ����� �������� ����� � ���-���','������ ���� ������� ���� � ���-��� ����� �� �������� 8-927-501-03-11'));
fieldsDescr["16567"] = new Array();
fieldsDescr["16567"].push(new fieldDescr('account','\\d{2}-8(\\d{3})\\d{3}-\\d{2}-\\d{2}',12,'������� ����� ����� � ���� ����� �������� {������������������ � ��������}',''));
fieldsDescr["19348"] = new Array();
fieldsDescr["19348"].push(new fieldDescr('account','\\d{6}-\\d{4}',10,'������� ����� �������� ����� � ���-���','������ ���� ������� ���� � ���-��� ����� �� �������� 8-927-501-03-11'));
fieldsDescr["19349"] = new Array();
fieldsDescr["19349"].push(new fieldDescr('account','\\d{6}-\\d{4}',10,'������� ����� �������� ����� � ���-���','������ ���� ������� ���� � ���-��� ����� �� �������� 8-927-501-03-11'));
fieldsDescr["20544"] = new Array();
fieldsDescr["20544"].push(new fieldDescr('account','\\d{8}-\\d{4}',10,'������� ����� �������� ������ � ���-���','������ ���� ����� �������� ������ � ���-��� ����� �� �������� 8-927-501-03-11'));

