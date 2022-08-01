unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, FileCtrl, Buttons, ComCtrls, Menus;

const defFileType =  faAnyFile-faHidden-faSysFile-faDirectory;

const bmp = '*.bmp';

const
r='---------------------------------------------------------------------------';

type TFileInfo = record
       FullName: TFileName;
       Name:     TFileName;
       FileSize: LongInt;
     end;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    edDir: TEdit;
    Label1: TLabel;
    btnDir: TSpeedButton;
    ResultList: TListBox;
    chbSubFolder: TCheckBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    lblIm1: TLabel;
    Label4: TLabel;
    lblIm2: TLabel;
    ProgressBar: TProgressBar;
    SpeedButton2: TSpeedButton;
    btnRunFind: TSpeedButton;
    btnSaveResult: TSpeedButton;
    SaveDialog: TSaveDialog;
    ResultMenu: TPopupMenu;
    mnClearResult: TMenuItem;
    mnSaveResult: TMenuItem;
    N3: TMenuItem;
    N1: TMenuItem;
    mnDelFile: TMenuItem;
    procedure btnDirClick(Sender: TObject);
    procedure btnRunFindClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ResultListDblClick(Sender: TObject);
    procedure btnSaveResultClick(Sender: TObject);
    procedure mnClearResultClick(Sender: TObject);
  private
    function CompareImages(Im1:TFileName;Im2:TFileName):boolean;
    procedure AddDublicateInfo(i:integer;j:integer);
    procedure CreateFileList(FileMask:string);
    procedure RunCompare;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  FindDir: TFileName;
  ImageFileName1: TFileName;
  ImageFileName2: TFileName;
  FileList: TStringList;
  FindFileMask: string;
  ViewFileName: TFileName;

implementation

uses Files, DirUnit, ViewUnit;

{$R *.dfm}

procedure TmainForm.RunCompare;
var i,j:integer;
begin
 for i := 0 to FileList.Count - 2 do
  for j := i+1 to FileList.Count - 1 do
  begin
   if CompareImages(FileList.Strings[i],FileList.Strings[j]) = true then
   AddDublicateInfo(i,j);
  end;
end;

procedure TMainForm.CreateFileList(FileMask:string);
var  i:integer;
begin
 if chbSubFolder.Checked = false then
 begin
   FindFile(FindDir,FileMask);
 end;
 if chbSubFolder.Checked = true then
 begin
   FindFileAllDir(FindDir,FileMask);
 end;
 if FileList = nil then FileList := TStringList.Create;
 FileList.Clear;
 for i := 0 to FileCount - 1 do
 begin
   FileList.Add(ArrayResult[i].FullName);
 end;
 ResetArrayResult;
 ResultList.Items.AddStrings(FileList);
end;

procedure TMainForm.AddDublicateInfo(i:integer;j:integer);
begin
 ResultList.Items.Add(r);
 ResultList.Items.Add(FileList.Strings[i]);
 ResultList.Items.Add(FileList.Strings[j]);
 ResultList.Items.Add(r);
end;

function TMainForm.CompareImages(Im1:TFileName;Im2:TFileName):boolean;
var bm1,bm2: TBitmap; i,j:integer;
begin
 bm1 := TBitmap.Create;
 bm2 := TBitmap.Create;
 lblIm1.Caption := Im1;
 lblIm2.Caption := Im2;
 Application.ProcessMessages; 
 bm1.LoadFromFile(Im1);
 bm2.LoadFromFile(Im2);
 Result := true;
 if(bm1.Height <> bm2.Height)or(bm1.Width <> bm2.Width)then
 begin
  bm1.Free;
  bm2.Free;
  Result := false;
  Exit;
 end;
 ProgressBar.Max := bm1.Height;
 ProgressBar.Position := 0;
 for i := 1 to bm1.Height do
 begin
   for j := 1 to bm1.Width do
   begin
    if bm1.Canvas.Pixels[i,j] <> bm2.Canvas.Pixels[i,j]then
    begin
     Result := false;
     break;
    end;
   end;
   ProgressBar.Position := ProgressBar.Position + 1;
   Application.ProcessMessages; 
 end;
 ProgressBar.Position := 0;
 bm1.Free;
 bm2.Free;
end;

procedure TMainForm.btnDirClick(Sender: TObject);
begin
 DirForm.ShowModal;
end;

procedure TMainForm.btnRunFindClick(Sender: TObject);
begin
 CreateFileList(FindFileMask);
 ResultList.Clear;
 RunCompare;
end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
begin
 Application.Terminate; 
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 FindFileMask := bmp;
end;

procedure TMainForm.ResultListDblClick(Sender: TObject);
var b:TBitmap;
begin
 ViewFileName := ResultList.Items.Strings[ResultList.ItemIndex];
 if(ViewFileName <> r)and(ViewFileName <>'')then
 begin
  b := TBitmap.Create;
  b.LoadFromFile(ViewFileName);
  ViewForm.ClientHeight := b.Height;
  ViewForm.ClientWidth := b.Width;
  b.Free;
  ViewForm.ShowModal;
 end;
end;

procedure TMainForm.btnSaveResultClick(Sender: TObject);
begin
 if SaveDialog.Execute then
 begin
   ResultList.Items.SaveToFile(SaveDialog.FileName); 
 end;
end;

procedure TMainForm.mnClearResultClick(Sender: TObject);
begin
 ResultList.Clear; 
end;

end.
