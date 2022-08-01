unit GlRAdmin;

interface

uses ComCtrls;

const
  msgNoNameComp = 'Недопустимое имя компьютера! Компьютер с таким именем уже' +
    'есть в базе данных. Попробуйте ввести другое имя или выберите ' +
    'компьютер из списка.';

type
  TItemType = (itNoData = 0, itNone = 1, itComp = 2, itPrinter = 3);

type
  TItemInfo = record
    ID: integer;
    IType: TItemType;
  end;

type
  PItemInfo = ^TItemInfo;

const
  NilItem: TItemInfo = (ID: -1; IType: itNoData);

procedure SetItemInfo(ItemInfo: TItemInfo; var Item: TListItem);
procedure SetItemType(ItemType: TItemType; var Item: TListItem);

function GetItemInfo(Item: TListItem): TItemInfo;
function GetItemType(Item: TListItem): TItemType;

procedure ClearItem(Item: TListItem);

implementation


procedure SetItemInfo(ItemInfo: TItemInfo; var Item: TListItem);
var Info: PItemInfo;
begin
  New(Info);
  Info^ := ItemInfo;
  Item.Data := Info;
end;

procedure SetItemType(ItemType: TItemType; var Item: TListItem);
begin
  if Item.Data <> nil then
  begin
    TItemInfo(Item.Data^).IType := ItemType;
  end;
end;

function GetItemInfo(Item: TListItem): TItemInfo;
begin
  Result := NilItem;
  if Item.Data <> nil then
    Result := TItemInfo(Item.Data^);
end;

function GetItemType(Item: TListItem): TItemType;
begin
  Result := itNoData;
  if Item.Data <> nil then
    Result := TItemInfo(Item.Data^).IType;
end;

procedure ClearItem(Item: TListItem);
begin
  if Item.Data <> nil then Dispose(Item.Data);
end;

end.
