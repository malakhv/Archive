unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TfrmBoardDemo = class(TForm)
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure ColorBox2Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBoardDemo: TfrmBoardDemo;

implementation

{$R *.dfm}

uses
  BoardControl;


var
  Board: TBoard; // Объявление переменной

procedure TfrmBoardDemo.CheckBox1Click(Sender: TObject);
begin
  Board.AutoSize := CheckBox1.Checked;
end;

procedure TfrmBoardDemo.ColorBox1Change(Sender: TObject);
begin
  Board.ActiveColor := ColorBox1.Selected;
end;

procedure TfrmBoardDemo.ColorBox2Change(Sender: TObject);
begin
  Board.ActiveBorder := ColorBox2.Selected;
end;

procedure TfrmBoardDemo.Edit1Change(Sender: TObject);
begin
  Board.Text := Edit1.Text;
end;

procedure TfrmBoardDemo.FormCreate(Sender: TObject);
begin
  // Создание обьекта (вызов канструктора)
  Board := TBoard.Create(Self);
  // Указание родителя
  Board.Parent := Self;
  // настройка положения на форме
  Board.Top := 36;
  Board.Left := 8;
  // делаем обьект видимым
  Board.Visible := true;
  // настройка цветов
  ColorBox1.Selected := Board.ActiveColor;
  ColorBox2.Selected := Board.ActiveBorder;
end;

procedure TfrmBoardDemo.FormDestroy(Sender: TObject);
begin
  // Уничтожение обьекта
  if Assigned(Board) then
    Board.Free;
end;

procedure TfrmBoardDemo.SpeedButton1Click(Sender: TObject);
begin
  Board.Turn;
end;

end.
