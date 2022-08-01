unit ColorUnit;

interface

uses Graphics;

var
  FontColor: TColor;
  BgColor  : TColor;

  // Dialog window
  LineColor: TColor;


implementation

uses Windows;

initialization
begin
  FontColor := RGB(228,215,188);
  BgColor   := RGB(22,22,22);
  LineColor := RGB(79,78,78);
end;

end.
