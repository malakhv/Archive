unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Grids, DirOutln, StdCtrls, FileCtrl,
  Buttons, Menus;

const
    CaptionColumn1 = 'Имя Файла';
    CaptionColumn2 = 'Размер';
    CaptionColumn3 = '';
    SizeColumn1 = 250;
    SizeColumn2 = 70;
    SizeColumn3 = 50;
    defFileType =  faAnyFile-faHidden-faSysFile-faDirectory;
    defDirectory = '\\Elib\Data\';

type TFileInfo = record
       FullName: TFileName;
       Name:     TFileName;
       FileSize: LongInt;
     end;
     
type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DirList: TDirectoryListBox;
    DriveList: TDriveComboBox;
    ListView: TListView;
    SpeedButton1: TSpeedButton;
    ListMenu: TPopupMenu;
    mnUpdate: TMenuItem;
    DirMenu: TPopupMenu;
    mnCreateList: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Label1: TLabel;
    lbFileCount: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DirListChange(Sender: TObject);
    procedure mnUpdateClick(Sender: TObject);
    procedure mnCreateListClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    procedure InitListView;
    procedure AddFileInfo(FileInfo:TFileInfo);
    function FindFile(Dir:TFileName;Mask:string):integer;
    function FindFileAllDir(Dir:TFileName;Mask:string;Attr:integer;var List:TStringList):integer;
    procedure GetFileList(FileMask:string);
    procedure InitProgres;
  public
    procedure CreateFileList;
  end;

var
  MainForm: TMainForm;
  Info:TFileInfo;
  faFileType:integer;
  FileMask:string;
  ExeDir:TFileName;
  //-- ---------------


implementation

uses ProgresUnit;

{$R *.dfm}

function TMainForm.FindFile(Dir:TFileName;Mask:string):integer;
var FSearchRec:TSearchRec; FindResult:integer;
begin
 Result := 0;
 try
  faFileType := faAnyFile-faHidden-faSysFile-faDirectory;
  FindResult := FindFirst(Dir+'\'+Mask,faFileType,FSearchRec);
  while FindResult = 0 do
  begin
   Info.Name := ExtractFileName(FSearchRec.Name);
   Info.FileSize := FSearchRec.Size;
   AddFileInfo(Info);
   FindResult := FindNext(FSearchRec);
  end;
  finally
   FindClose(FSearchRec);
  end;
end;

function TMainForm.FindFileAllDir(Dir:TFileName;Mask:string;Attr:integer;var List:TStringList):integer;
 function IsDirNotation(ADirName:string):boolean;
 begin
   Result := (ADirName = '.')or(ADirName = '..');
 end;
var FSearchRec,DSearchRec:TSearchRec; FindResult:integer;
begin
  if Dir[Length(Dir)]<>'\'then Dir := Dir + '\';
  Result := 0;
  FindResult := FindFirst(Dir+Mask,Attr,FSearchRec);
  try
    while FindResult = 0 do
    begin
      List.Add(Dir+FSearchRec.Name);
      ProgresForm.lbFileCount.Caption := IntToStr(List.Count);
      Application.ProcessMessages;
      FindResult := FindNext(FSearchRec);
    end;
    FindResult := FindFirst(Dir+'*',faDirectory,DSearchRec);
    while FindResult = 0 do
    begin
      if((DSearchRec.Attr and faDirectory)=faDirectory)
         and(not IsDirNotation(DSearchRec.Name)) then
      begin
       FindFileAllDir(Dir+DSearchRec.Name,Mask,Attr,List);
      end;
      FindResult := FindNext(DSearchRec);
    end;
  finally
    FindClose(FSearchRec);
  end;
end;

procedure TMainForm.GetFileList(FileMask:string);
begin
 ListView.Items.Clear;
 FindFile(DirList.Directory,FileMask); 
end;

procedure TMainForm.InitListView;
var NewColumn:TListColumn;
begin
 ListView.Items.Clear;
 ListView.Columns.Clear;

 NewColumn := ListView.Columns.Add;
 NewColumn.Caption := CaptionColumn1;
 NewColumn.Width   := SizeColumn1;
 NewColumn := ListView.Columns.Add;
 NewColumn.Caption := CaptionColumn2;
 NewColumn.Width   := SizeColumn2;
end;

procedure TMainForm.AddFileInfo(FileInfo:TFileInfo);
var item:TListItem; sz:integer; s:string[2];
begin
 item := ListView.Items.Add;
 item.Caption := FileInfo.Name;
 sz := FileInfo.FileSize;
 s := 'b';
 if sz > 1024 then begin sz := sz div 1024; s:='kb'; end;
 item.SubItems.Add(IntToStr(sz)+'   '+s);
end;

procedure TMainForm.CreateFileList;
var Ls:TStringList;
begin
 Label1.Visible := true;
 lbFileCount.Visible := true;
 Ls := TStringList.Create;
 FileMask := '*';
 FindFileAllDir(DirList.Directory,FileMask,defFileType,Ls);
 Ls.SaveToFile(ExeDir+'FileList.txt');
 Ls.Free; 
end;

procedure TMainForm.InitProgres;
begin
 ProgresForm.lbFileCount.Caption := '000000';
 ProgresForm.ShowModal;
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
 Application.Terminate; 
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 InitListView;
 faFileType := faAnyFile-faHidden-faSysFile-faDirectory;
 ExeDir := ExtractFilePath(Application.ExeName);
 GetFileList('*');
 DirList.Directory := defDirectory;
end;

procedure TMainForm.DirListChange(Sender: TObject);
begin
 GetFileList('*');
end;

procedure TMainForm.mnUpdateClick(Sender: TObject);
begin
 GetFileList('*');
end;

procedure TMainForm.mnCreateListClick(Sender: TObject);
begin
 InitProgres;
 CreateFileList;
end;

procedure TMainForm.N2Click(Sender: TObject);
begin
 DirList.Directory := defDirectory;
 GetFileList('*');
end;

end.
