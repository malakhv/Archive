unit MyListViewUtils;

interface

uses Classes, ComCtrls;


function ColumnsToStr(ListView: TListView): string;
function ListItemToStr(ListItem: TListItem): string;
function ListViewToStr(ListView: TListView; SelectedOnly, IncludeHead: boolean): string;

implementation

uses SysUtils;

const

  TabChar = #9;
  NewStrChar = #13#10;

function ColumnsToStr(ListView: TListView): string;
var i: integer;
begin
  with ListView.Columns do
    for i := 0 to Count - 1 do
      Result := Result + Items[i].Caption + TabChar;
  Result := Trim(Result);
end;

function ListItemToStr(ListItem: TListItem): string;
var j: integer;
begin
  with ListItem do
  begin
    Result := Caption;
    for j := 0 to SubItems.Count - 1 do
      Result := Result + TabChar + SubItems[j];
  end;
end;

function ListViewToStr(ListView: TListView; SelectedOnly, IncludeHead: boolean): string;
var i: integer;
begin
  if IncludeHead then
    Result := ColumnsToStr(ListView);
  with ListView.Items do
    for i := 0 to Count - 1 do
      if Item[i].Selected or not SelectedOnly then
        Result := Result + NewStrChar + ListItemToStr(Item[i]);
end;

end.
