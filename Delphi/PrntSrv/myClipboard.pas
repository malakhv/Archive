unit myClipboard;

interface

uses Clipbrd;

procedure CopyTxtToClipbrd(Str:string);
function GetTxtFromClipbrd: string;

implementation

procedure CopyTxtToClipbrd(Str:string);
begin
 Clipboard.AsText := str;
end;

function GetTxtFromClipbrd: string;
begin
 Result := '';
 if Clipboard.HasFormat(1) then
 begin
   Result := Clipboard.AsText;
 end;
end;

end.
