unit MainUnit;

interface
                            
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, ComCtrls;

const
     maxPoint = 20;
     DefaulFile1Name = '1.txt';
     DefaulFile2Name = '2.txt';
     DefaulSeparator = '====================';

type TPoint = record
        X: integer;
        Y: integer;
        Index: byte;
        PtrImage: ^TImage;
     end;

type TRebro = record
      Point1:byte;  //Номера точек в массива PointArray
      Point2:byte;
      Index: byte;
     end;

type
  TPointArray = array[1..maxPoint] of TPoint;
  TRebroArray = array[1..maxPoint*2] of TRebro;

type
  TMainForm = class(TForm)
    Panel2: TPanel;
    ShapePanel: TPanel;
    ListBox: TListBox;
    ToolBar: TPanel;
    lblX: TLabel;
    lblY: TLabel;
    Bevel2: TBevel;
    edAddX: TEdit;
    edAddY: TEdit;
    SpeedButton2: TSpeedButton;
    lblIndex: TLabel;
    Bevel3: TBevel;
    Label3: TLabel;
    lblInfoX: TLabel;
    lblInfoY: TLabel;
    chRebro: TCheckBox;
    PaintBox1: TPaintBox;
    Bevel4: TBevel;
    Label1: TLabel;
    edX: TEdit;
    Label2: TLabel;
    edY: TEdit;
    Panel3: TPanel;
    SpeedButton3: TSpeedButton;
    StatusBar1: TStatusBar;
    SpeedButton1: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure ShapePanelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure ShapePanelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    procedure CreatePoint(X,Y:integer);
    procedure CreateLine(rb:TRebro);
    procedure InitMyPoint;
    procedure InitMyRebro;
    procedure PointMouseMove(Sender:TObject;Shift:TShiftState;X,Y:Integer);
    procedure PointClick(Sender:TObject);
    function CreateFileShape:boolean;
    procedure CreateLineCursor(x,y:integer);

    procedure CreateSetka;
    procedure VrPoSetke(Sender:TObject);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  PointFileName:TFileName;
  DirCreateFile:TFileName;
  PointCount: byte;
  RebroCount: byte;
  MyPoint: TPointArray;
  MyRebro: TRebroArray;
  OldPointIndex:integer;
  im:TImage;

implementation

{$R *.dfm}

procedure TMainForm.InitMyPoint;
var i:byte;
begin
 for i:= 1 to maxPoint do
 begin
   MyPoint[i].X := 0;
   MyPoint[i].Y := 0;
   MyPoint[i].Index := 0;
   MyPoint[i].PtrImage := nil;
 end;
end;

procedure TMainForm.InitMyRebro;
var i:byte;
begin
 for i:= 1 to maxPoint * 2 do
 begin
  MyRebro[i].Point1 := 0;
  MyRebro[i].Point2 := 0;
  MyRebro[i].Index  := 0
 end;
end;

procedure TMainForm.VrPoSetke(Sender:TObject);
var x,y,i:integer;
begin
 for i := 1 to maxPoint do
 begin
  if MyPoint[i].Index <> 0 then
  begin
   x := MyPoint[i].X;
   y := MyPoint[i].Y;
   if(x mod 10)<5  then x := x - (x mod 10);
   if(x mod 10)>=5 then x := x + (10 - (x mod 10));

   if(y mod 10)<5  then y := y - (y mod 10);
   if(y mod 10)>=5 then y := y + (10 - (y mod 10));

   MyPoint[i].X := x;
   MyPoint[i].Y := y;
   MyPoint[i].PtrImage.Left := x;
   MyPoint[i].PtrImage.Top  := y;
   PaintBox1Paint(Sender);
  end;
 end;
end;

procedure TMainForm.CreateSetka;
var i:integer; cl:TColor;
begin
 cl :=  PaintBox1.Canvas.Pen.Color;
 PaintBox1.Canvas.Pen.Color := clMoneyGreen;


 for i := 1 to  PaintBox1.Height do
 begin
  if (i mod 10) = 0 then
  begin
   PaintBox1.Canvas.MoveTo(0,i);
   PaintBox1.Canvas.LineTo(PaintBox1.Width,i);
  end;
 end;

 for i := 1 to  PaintBox1.Width  do
 begin
  if (i mod 10) = 0 then
  begin
   PaintBox1.Canvas.MoveTo(i,0);
   PaintBox1.Canvas.LineTo(i,PaintBox1.Height);
  end;
 end;

 PaintBox1.Canvas.Pen.Color := cl;
end;

procedure TMainForm.CreateLineCursor(x,y:integer);
begin

end;

procedure TMainForm.CreatePoint(X,Y:integer);
var  s:string;  rbr:TRebro;
begin
 if PointCount = maxPoint then Exit;

 im := TImage.Create(ShapePanel);
 im.Parent := ShapePanel;
 im.Left := X; //- 2;
 im.Top := Y; //- 2;
 im.AutoSize := true;
 im.OnMouseMove := PointMouseMove;
 im.OnClick := PointClick;
 im.Picture.LoadFromFile(PointFileName);
 im.Visible := true;
 PointCount := PointCount + 1;
 im.Tag := PointCount;
 MyPoint[PointCount].X := X;
 MyPoint[PointCount].Y := Y;
 MyPoint[PointCount].Index  := PointCount;
 MyPoint[PointCount].PtrImage := @im;
 //OldPointIndex := MyPoint[PointCount].Index;
 s := IntToStr(PointCount)+' - ';
 ListBox.Items.Add(s+IntToStr(X));
 ListBox.Items.Add(s+IntToStr(Y));
 ListBox.Items.Add(DefaulSeparator);

 if(ChRebro.Checked = true)and(PointCount>1)then
 begin
  rbr.Point1 := OldPointIndex;//PointCount - 1;
  rbr.Point2 := PointCount;
  rbr.Index := 0;
  CreateLine(rbr);
 end;
 OldPointIndex := MyPoint[PointCount].Index;
end;

procedure TMainForm.CreateLine(rb:TRebro);
var X1,Y1,X2,Y2:integer;
begin
 X1 := MyPoint[rb.Point1].X;
 Y1 := MyPoint[rb.Point1].Y;
 X2 := MyPoint[rb.Point2].X;
 Y2 := MyPoint[rb.Point2].Y;
 //Рисуем линию
 PaintBox1.Canvas.MoveTo(X1,Y1);
 PaintBox1.Canvas.LineTo(X2,Y2);

 RebroCount := RebroCount + 1;
 MyRebro[RebroCount].Point1 := rb.Point1;
 MyRebro[RebroCount].Point2 := rb.Point2;
 MyRebro[RebroCount].Index  := RebroCount;
end;

procedure TMainForm.PointMouseMove(Sender:TObject;Shift:TShiftState;X,Y:Integer);
var i:byte;
begin
 i := (Sender as TImage).Tag;
 lblIndex.Caption := IntToStr(i);
 lblInfoX.Caption := IntToStr(MyPoint[i].X);
 lblInfoY.Caption := IntToStr(MyPoint[i].Y);
end;

procedure TMainForm.PointClick(Sender:TObject);
var i:byte;  rbr:TRebro;
begin
 i:= (Sender as TImage).Tag;
 if i <> OldPointIndex then
 begin
  rbr.Point1 := OldPointIndex;
  rbr.Point2 := i;
  rbr.Index := 0;
  CreateLine(rbr);
 end;
 OldPointIndex := i;
end;

function TMainForm.CreateFileShape:boolean;
var List:TStringList; i:byte;
begin
 Result := false;
 if PointCount < 2 then Exit;
 List := TStringList.Create;
 List.Clear;

 List.Add(edX.Text);
 List.Add(edY.Text);
                                   
 for i := 1 to maxPoint do
 begin
  if MyPoint[i].Index = 0 then Continue;
  List.Add(IntToStr(MyPoint[i].X));
  List.Add(IntToStr(MyPoint[i].Y));
 end;

 List.SaveToFile(DirCreateFile + DefaulFile1Name);
 List.Clear;

 List.Add(IntToStr(PointCount)); 
 //if chRebro.Checked = true then List.Add(IntToStr(RebroCount+1)) else
 List.Add(IntToStr(RebroCount));
 for i := 1 to maxPoint*2 do
 begin
  if MyRebro[i].Index = 0 then Continue;
  List.Add(IntToStr(MyRebro[i].Point1));
  List.Add(IntToStr(MyRebro[i].Point2));
 end;
 {if chRebro.Checked = true then
 begin
  List.Add(IntToStr(RebroCount+1));
  List.Add('1');
 end;}

 List.SaveToFile(DirCreateFile + DefaulFile2Name);
 List.Free;
end;


//=============================================================================

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
 if ListBox.Count = 0 then
 begin
   ListBox.Items.Add(edX.Text);
   ListBox.Items.Add(edY.Text);
 end
 else
 begin
   ListBox.Items.Strings[0] := edX.Text;
   ListBox.Items.Strings[1] := edY.Text;
 end;
end;

procedure TMainForm.ShapePanelMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if Button = mbLeft then CreatePoint(X,Y);
 if Button = mbRight then  OldPointIndex := -1;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 if MainForm.Caption <> 'Малахов Михаил КВТ - 033' then Application.Terminate; 
 PointCount := 0;
 RebroCount := 0;
 PointFileName := ExtractFilePath(Application.ExeName)+'Res\Point.bmp';
 DirCreateFile := ExtractFilePath(Application.ExeName)+'File\';
 InitMyPoint;
 InitMyRebro;
 CreateSetka;
end;

procedure TMainForm.ShapePanelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 lblX.Caption := IntToStr(X);
 lblY.Caption := IntToStr(Y);
end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
var X,Y:integer;
begin
 X := StrToInt(edAddX.Text);
 Y := StrToInt(edAddY.Text);
 CreatePoint(X,Y);
end;

procedure TMainForm.SpeedButton3Click(Sender: TObject);
begin
 CreateFileShape;
end;

procedure TMainForm.PaintBox1Paint(Sender: TObject);
var i:byte; X1,Y1,X2,Y2:integer; rbr:TRebro;
begin
 CreateSetka;
 for i:=1 to maxPoint*2 do
 begin
  if MyRebro[i].Index = 0 then Continue;
  rbr := MyRebro[i];
  X1 := MyPoint[rbr.Point1].X;
  Y1 := MyPoint[rbr.Point1].Y;
  X2 := MyPoint[rbr.Point2].X;
  Y2 := MyPoint[rbr.Point2].Y;
  PaintBox1.Canvas.MoveTo(X1,Y1);
  PaintBox1.Canvas.LineTo(X2,Y2);
 end;
end;

procedure TMainForm.SpeedButton4Click(Sender: TObject);
begin
 //VrPoSetke(Sender);
end;

end.
