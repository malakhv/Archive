unit myClipboard;
interface

uses Clipbrd;

procedure CopyTextToClipboard(Str:string);
function LoadTextFromClipboard: string;

implementation

procedure CopyTextToClipboard(Str:string);
begin
 Clipboard.AsText := str;
end;

function LoadTextFromClipboard: string;
begin
 Result := '';
 if Clipboard.HasFormat(1) then
 begin
   Result := Clipboard.AsText;
 end;
end;

end.
