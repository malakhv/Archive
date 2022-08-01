unit DioList;

interface

uses MyXMLNode;

type

  TDioInfoXMLNode = class(TXMLNodeObject)
  private
    function GetAddress: string;
    function GetDioOwner: string;
    function GetInfo1: string;
    function GetInfo2: string;
    function GetNumber: integer;
    procedure SetAddress(const Value: string);
    procedure SetDioOwner(const Value: string);
    procedure SetInfo1(const Value: string);
    procedure SetInfo2(const Value: string);
    procedure SetNumber(const Value: integer);
  public
    property Number: integer read GetNumber write SetNumber;
    property Address: string read GetAddress write SetAddress;
    property DioOwner: string read GetDioOwner write SetDioOwner;
    property Info1: string read GetInfo1 write SetInfo1;
    property Info2: string read GetInfo2 write SetInfo2;
  end;

//type


implementation

const

  { Имена атрибутов }

  aAddress = 'Address';
  aDioOwner = 'DioOwner';
  aInfo1 = 'Info1';
  aInfo2 = 'Info2';

{ TDioInfoXMLNode }

function TDioInfoXMLNode.GetAddress: string;
begin
  Result := Attribute[aAddress];
end;

function TDioInfoXMLNode.GetDioOwner: string;
begin
  Result := Attribute[aDioOwner];
end;

function TDioInfoXMLNode.GetInfo1: string;
begin
  Result := Attribute[aInfo1];
end;

function TDioInfoXMLNode.GetInfo2: string;
begin
  Result := Attribute[aInfo2];
end;

function TDioInfoXMLNode.GetNumber: integer;
begin
  Result := Integer(NodeValue);
end;

procedure TDioInfoXMLNode.SetAddress(const Value: string);
begin
  Attribute[aAddress] := Value;
end;

procedure TDioInfoXMLNode.SetDioOwner(const Value: string);
begin
  Attribute[aDioOwner] := Value;
end;

procedure TDioInfoXMLNode.SetInfo1(const Value: string);
begin
  Attribute[aInfo1] := Value;
end;

procedure TDioInfoXMLNode.SetInfo2(const Value: string);
begin
  Attribute[aInfo2] := Value;
end;

procedure TDioInfoXMLNode.SetNumber(const Value: integer);
begin
  NodeValue := Value;
end;

end.
