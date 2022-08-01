unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, ExtDlgs;

const defkx =1;// 0.9;
      defky =1;// -0.958;
      fl_str = 'Во весь экран';
      nr_str = 'В окне';

type
  TMainForm = class(TForm)
    Paint: TPaintBox;
    SaveDialog: TSavePictureDialog;
    ImageMenu: TPopupMenu;
    mnSave: TMenuItem;
    N2: TMenuItem;
    mnExit: TMenuItem;
    N3: TMenuItem;
    Image: TImage;
    N1: TMenuItem;
    mnFull: TMenuItem;
    N4: TMenuItem;
    mnOptions: TMenuItem;
    procedure mnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnExitClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure mnFullClick(Sender: TObject);
    procedure mnOptionsClick(Sender: TObject);
  private
    procedure CreateFractal;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  bmp:TBitmap;
  Full: boolean;
  kx: double = 1;//0.9;
  ky: double = 1;// -0.958;
  Shag: double = 1;

implementation

uses OptionsUnit;

{$R *.dfm}

procedure TMainForm.CreateFractal;
var pmin,pmax,qmin,qmax,p0,q0: double;
    dp,dq:double; M,r:double; a,b,i,j:integer;
    KK: integer;
    k: double;
    x0,y0,x,y:double;
    cl: TColor;
begin
 pmin := -2.25; pmax := 0.75; qmin := -1.5; qmax := 1.5; M := 1000;// - оригинал
 a := MainForm.ClientWidth; b := MainForm.ClientHeight;  
 bmp.Width := a; bmp.Height := b;
 dp := (pmax - pmin)/(a - 1); dq := (qmax - qmin)/(b - 1);

 KK := 300;
 Image.Visible := false;

 for j := 1 to b do
 begin
   for i := 1 to a do
   begin
     p0 := pmin  + (i)*dp; q0 := qmin  + (j)*dq; k := 0; x0 := 0; y0 := 0; r := 0;
     x := x0; y := y0;
     while ((r <= M) and (k<KK)) do
     begin
       r := x0*x0 + y0*y0;
       x := kx*(x0*x0 - y0*y0 + p0);
       y := ky*(2*x0*y0  + q0);
       k := k + Shag;
       x0 := x;
       y0 := y;
     end;
     cl := Paint.Canvas.Pixels[i,j];
     if r > M then cl := RGB(Round(k) + 40,10,30);
     //if k = KK then cl := RGB(k + 40,k + 10 + abs(i-j),k + 30 + abs(j-i));// clSkyBlue; //clBlack;
     if k = KK then cl := clBlack;
     Paint.Canvas.Pixels[i,j] := cl;
     bmp.Canvas.Pixels[i,j] := cl;
   end;
 end;
   Image.Visible := true;
   image.Picture.Bitmap.Assign(bmp);
end;

procedure TMainForm.mnSaveClick(Sender: TObject);
begin
 if SaveDialog.Execute then
 begin
   bmp.SaveToFile(SaveDialog.FileName);
 end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 bmp := TBitmap.Create;
 Full := false;
end;

procedure TMainForm.mnExitClick(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TMainForm.N3Click(Sender: TObject);
begin
 CreateFractal;
end;

procedure TMainForm.mnFullClick(Sender: TObject);
begin
 if not Full then
 begin
   MainForm.BorderStyle := bsNone;
   MainForm.Width := 1025;
   MainForm.Height := 769;
   MainForm.Left := -1;
   MainForm.Top := -1;
   mnFull.Caption := nr_str;
 end;
 if Full then
 begin
   MainForm.BorderStyle := bsSizeable;
   MainForm.Width := 640;
   MainForm.Height := 480;
   MainForm.Left := 220;
   MainForm.Top := 140;
   mnFull.Caption := fl_str;
 end;
 Full := not Full;
 CreateFractal;
end;

procedure TMainForm.mnOptionsClick(Sender: TObject);
begin
 if OptionsForm.ShowModal = mrOK then
 begin
   kx := StrToFloatDef(OptionsForm.edKX.Text,1);
   ky := StrToFloatDef(OptionsForm.edKY.Text,1);
   Shag := StrToFloatDef(OptionsForm.edShag.Text,1);
   CreateFractal;
 end;
end;

end.
