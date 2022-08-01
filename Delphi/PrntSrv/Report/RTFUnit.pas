unit RTFUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus, ImgList, ToolWin, Spin;

type
  TRTFForm = class(TForm)
    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    Editor: TRichEdit;
    mnSave: TMenuItem;
    SaveDialog: TSaveDialog;
    N3: TMenuItem;
    mnExit: TMenuItem;
    ToolBar1: TToolBar;
    Images: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    btnLeft: TToolButton;
    btnCenter: TToolButton;
    btnRigth: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    N2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    ToolButton9: TToolButton;
    btnB: TToolButton;
    btnI: TToolButton;
    btnU: TToolButton;
    ImagesDis: TImageList;
    ImagesHot: TImageList;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    FontSize: TSpinEdit;
    FontBox: TComboBox;
    procedure mnSaveClick(Sender: TObject);
    procedure mnExitClick(Sender: TObject);
    procedure EditorSelectionChange(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure btnCenterClick(Sender: TObject);
    procedure btnRigthClick(Sender: TObject);
    procedure btnBClick(Sender: TObject);
    procedure btnIClick(Sender: TObject);
    procedure btnUClick(Sender: TObject);
    procedure FontSizeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FontBoxChange(Sender: TObject);
    procedure FontBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    procedure CreateHead;
    procedure AddItem(Item: TListItem);
    function CurrText: TTextAttributes;
  public
    procedure CreateReport(List: TListView);

  end;

var
  RTFForm: TRTFForm;

implementation

{$R *.dfm}

{ TForm1 }

function TRTFForm.CurrText: TTextAttributes;
begin
  //if Editor.SelLength > 0 then Result := Editor.SelAttributes
  //else Result := Editor.DefAttributes;
  Result := Editor.SelAttributes;
end;

procedure TRTFForm.AddItem(Item: TListItem);
var str: string;
begin
  Editor.Paragraph.Alignment := taLeftJustify;
  Editor.SelAttributes.Style := [fsBold];
  Editor.SelAttributes.Size := 12;
  Editor.Lines.Add(Item.Caption);
  Editor.SelAttributes.Style := [];

  Editor.Lines.Add('Документ    : ' + Item.SubItems.Strings[0]);
  Editor.Lines.Add('Принтер     : ' + Item.SubItems.Strings[1]);
  Editor.Lines.Add('Компьютер   : ' + Item.SubItems.Strings[2]);
  Editor.Lines.Add('Страниц     : ' + Item.SubItems.Strings[3]);
  Editor.Lines.Add('Дата/Время  : ' + Item.SubItems.Strings[4]);
  
  Editor.Lines.Add(str);
  Editor.Lines.Add('');
end;

procedure TRTFForm.CreateHead;
begin
  Editor.Paragraph.Alignment := taCenter;
  Editor.SelAttributes.Style := [fsBold];
  Editor.SelAttributes.Size := 18;
  Editor.Lines.Add('Отчет от '+ DateToStr(Date));
end;

procedure TRTFForm.CreateReport(List: TListView);
var i: integer;
begin
  Editor.Clear;
  CreateHead;
  for i := 0 to List.Items.Count - 1 do
  begin
    AddItem(List.Items.Item[i]);
  end;
end;

procedure TRTFForm.mnSaveClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    Editor.Lines.SaveToFile(SaveDialog.FileName);
  end;
end;

procedure TRTFForm.mnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TRTFForm.EditorSelectionChange(Sender: TObject);
begin
  btnB.Down := fsBold in Editor.SelAttributes.Style;
  btnI.Down := fsItalic in Editor.SelAttributes.Style;
  btnU.Down := fsUnderline in Editor.SelAttributes.Style;
  FontBox.ItemIndex := FontBox.Items.IndexOf(Editor.SelAttributes.Name);
  FontSize.Value := Editor.SelAttributes.Size;
end;

procedure TRTFForm.btnLeftClick(Sender: TObject);
begin
  Editor.Paragraph.Alignment := taLeftJustify;
end;

procedure TRTFForm.btnCenterClick(Sender: TObject);
begin
  Editor.Paragraph.Alignment := taCenter;
end;

procedure TRTFForm.btnRigthClick(Sender: TObject);
begin            
  Editor.Paragraph.Alignment := taRightJustify;
end;

procedure TRTFForm.btnBClick(Sender: TObject);
begin
  if (fsBold in Editor.SelAttributes.Style) then
    CurrText.Style := CurrText.Style - [fsBold]
  else
    CurrText.Style := CurrText.Style + [fsBold];
  EditorSelectionChange(Sender);
end;

procedure TRTFForm.btnIClick(Sender: TObject);
begin
  if (fsItalic in Editor.SelAttributes.Style) then
    CurrText.Style := CurrText.Style - [fsItalic]
  else
    CurrText.Style := CurrText.Style + [fsItalic];
  EditorSelectionChange(Sender);
end;

procedure TRTFForm.btnUClick(Sender: TObject);
begin
  if (fsUnderline in Editor.SelAttributes.Style) then
    CurrText.Style := CurrText.Style - [fsUnderline]
  else
    CurrText.Style := CurrText.Style + [fsUnderline];
  EditorSelectionChange(Sender);
end;

procedure TRTFForm.FontSizeChange(Sender: TObject);
begin
  Editor.SelAttributes.Size := FontSize.Value;
end;

procedure TRTFForm.FormCreate(Sender: TObject);
begin
  FontBox.Items := Screen.Fonts;
end;

procedure TRTFForm.FontBoxChange(Sender: TObject);
begin
  CurrText.Name := FontBox.Items[FontBox.ItemIndex];
end;

procedure TRTFForm.FontBoxDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with FontBox.Canvas do
  begin
    FillRect(Rect);
    Font.Name := FontBox.Items[index];
    TextOut(Rect.Left + 1,Rect.Top + 1,FontBox.Items[index]);
  end;
end;

end.
