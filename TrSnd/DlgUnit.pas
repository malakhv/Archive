unit DlgUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, MImage, ImgList;

type
  TDlgForm = class(TForm)
    Image1: TImage;
    lblInfo: TLabel;
    MesEdit: TEdit;
    ImagesBtn: TImageList;
    imgOK: TMImage;
    imgCancel: TMImage;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure imgOKMouseEnter(Sender: TObject);
    procedure imgOKMouseLeave(Sender: TObject);
    procedure imgOKMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgOKMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgCancelClick(Sender: TObject);
    procedure imgOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DlgForm: TDlgForm;

implementation

uses ColorUnit;

{$R *.dfm}

procedure TDlgForm.FormCreate(Sender: TObject);
begin
  Self.Color := BgColor;
  MesEdit.Color := BgColor;
end;

procedure TDlgForm.FormPaint(Sender: TObject);
begin
  with Self.Canvas do
  begin
    Pen.Color := LineColor;
    MoveTo(1,1);
    LineTo(1,Self.ClientHeight - 2);
    LineTo(Self.ClientWidth - 2, Self.ClientHeight - 2);
    LineTo(Self.ClientWidth - 2, 1);
    LineTo(1,1);
  end;
end;

procedure TDlgForm.imgOKMouseEnter(Sender: TObject);
begin
  ImagesBtn.GetBitmap((Sender as TImage).Tag + 1,(Sender as TImage).Picture.Bitmap);
  (Sender as TImage).Invalidate;
end;

procedure TDlgForm.imgOKMouseLeave(Sender: TObject);
begin
  ImagesBtn.GetBitmap((Sender as TImage).Tag,(Sender as TImage).Picture.Bitmap);
  (Sender as TImage).Invalidate;
end;

procedure TDlgForm.imgOKMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ImagesBtn.GetBitmap((Sender as TImage).Tag + 2,(Sender as TImage).Picture.Bitmap);
  (Sender as TImage).Invalidate;
end;

procedure TDlgForm.imgOKMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var flag: byte;
begin
  flag := byte((X >= 0) and (Y >= 0) and (X <= (Sender as TControl).Width)
    and (Y <= (Sender as TControl).Height));
  ImagesBtn.GetBitmap((Sender as TImage).Tag + flag,(Sender as TImage).Picture.Bitmap);
  (Sender as TImage).Invalidate;
end;

procedure TDlgForm.imgCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TDlgForm.imgOKClick(Sender: TObject);
begin
  Self.ModalResult := mrOK;
end;

end.
