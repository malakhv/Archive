unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ShellCtrls, ImgList, StdCtrls, Menus, ExtCtrls,
  Buttons;

type
  TMainForm = class(TForm)
    FileList: TListView;
    FileImageList: TImageList;
    btnPanel: TPanel;
    lblAddr: TLabel;
    AddrEdit: TEdit;
    Bevel1: TBevel;
    MainMenu1: TMainMenu;
    mnFile: TMenuItem;
    N2: TMenuItem;
    mnExit: TMenuItem;
    DriveBox: TComboBox;
    lblDrive: TLabel;
    btnUP: TSpeedButton;
    FileListMenu: TPopupMenu;
    SpeedButton1: TSpeedButton;
    lblIP: TLabel;
    IPEdit: TEdit;
    Bevel2: TBevel;
    btnConnect: TSpeedButton;
    StatBar: TStatusBar;
    mnFileDel: TMenuItem;
    mnDel: TMenuItem;
    mnCopy: TMenuItem;
    N3: TMenuItem;
    mnServer: TMenuItem;
    mnCloseServer: TMenuItem;
    procedure FileListDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnUPClick(Sender: TObject);
    procedure mnExitClick(Sender: TObject);
    procedure DriveBoxChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FileListKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConnectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FileListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure mnFileDelClick(Sender: TObject);
    procedure FileListMenuPopup(Sender: TObject);
    procedure mnCopyClick(Sender: TObject);
  private
    procedure ShowDrive(ReloadDriveList: boolean = false);
    procedure ShowDriveNET;
    procedure ShowDir(Dir: TFileName);
    procedure ShowDirNET(Dir: TFileName);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  CurrentDir: TFileName;
  Connect   : boolean;

implementation

uses Files, Drives, Global, TServerUnit, GetDirUnit;

{$R *.dfm}

procedure TMainForm.ShowDrive(ReloadDriveList: boolean = false);
var i: integer; itm: TListItem; inf: TItemInfo;
begin
  DriveBox.Items.Clear;
  DriveBox.Items.Add('Root');
  ClearListView(FileList);
  if ReloadDriveList = true then
  begin
   FreeDriveList; GetDrive;
  end;
  for i := 0 to DriveCount - 1 do
  begin
    itm := FileList.Items.Add;
    itm.Caption := DriveList[i].RootPath;
    inf.Index := i;
    inf.ItemType := itDrive;
    SetItemInfo(inf,itm);
    DriveBox.Items.Add(itm.Caption);
    if DriveList[i].DriveType = DRIVE_FIXED then itm.ImageIndex := 5;
    if DriveList[i].DriveType = DRIVE_REMOVABLE then itm.ImageIndex := 8;
    if DriveList[i].DriveType = DRIVE_CDROM then itm.ImageIndex := 7;
    if DriveList[i].DriveType = DRIVE_REMOTE then itm.ImageIndex := 6;
  end;
end;

procedure TMainForm.ShowDir(Dir: TFileName);
var i: integer; itm: TListItem; inf: TItemInfo;
    ext: string;
begin
  ClearListView(FileList);
  ResetArrayResult;
  faFileType := faAnyFile - faVolumeID - faSysFile - faHidden;
  FindFile(Dir,'*.*');
  for i := 0 to FileCount - 1 do
  begin
    if (ArrayResult[i].Attr and faDirectory) = faDirectory then
    begin
      itm := FileList.Items.Add;
      itm.Caption := ArrayResult[i].Name;
      inf.Index := i;
      inf.ItemType := itFolder;
      if itm.Caption = '..' then inf.ItemType := itFolder;
      SetItemInfo(inf,itm);
      itm.ImageIndex := 0;
    end;
  end;
  for i := 0 to FileCount - 1 do
  begin
    if (ArrayResult[i].Attr and faDirectory) <> faDirectory then
    begin
      itm := FileList.Items.Add;
      itm.Caption := ArrayResult[i].Name;
      inf.Index := i;
      inf.ItemType := itFile;
      SetItemInfo(inf,itm);
      itm.ImageIndex := 1;
      ext := ExtractFileExt(ArrayResult[i].Name);
      NormalStr(ext);
      if(ext = '.txt')or(ext = '.log')  then itm.ImageIndex := 2;
      if(ext = '.jpg')or(ext = '.jepg') then itm.ImageIndex := 3;
      if(ext = '.mp3') then itm.ImageIndex := 9;
      if(ext = '.wav') then itm.ImageIndex := 10;
      if(ext = '.wma') then itm.ImageIndex := 11;
      if(ext = '.mid') then itm.ImageIndex := 12;
      if(ext = '.htm')or(ext = '.html') then itm.ImageIndex := 13;
      if(ext = '.doc') then itm.ImageIndex := 15;
      if(ext = '.xls') then itm.ImageIndex := 14;
      if(ext = '.dll') then itm.ImageIndex := 16;
      if(ext = '.hlp') then itm.ImageIndex := 18;
      if(ext = '.gif')or(ext = '.emf') then itm.ImageIndex := 17;
      if(ext = '.bmp') then itm.ImageIndex := 19;
      if(ext = '.exe') then itm.ImageIndex := 20;
      if(ext ='.avi')or(ext='.mpg')or(ext='.mpeg') then itm.ImageIndex := 21;
      if(ext = '.sys')or(ext = '.inf')or(ext = '.ini') then itm.ImageIndex := 22;
      if(ext = '.zip')or(ext = '.rar') then itm.ImageIndex := 23;
      if(ext = '.com')or(ext = '.bat') then itm.ImageIndex := 24;
      if(ext = '.rtf') then itm.ImageIndex := 25;
      if(ext = '.c') then itm.ImageIndex := 26;
      if(ext = '.cpp') then itm.ImageIndex := 27;
      if(ext = '.h') then itm.ImageIndex := 28;
      if(ext = '.hpp') then itm.ImageIndex := 29;
      if(ext = '.dsw')or(ext = '.dsp') then itm.ImageIndex := 30;
      if(ext = '.rc') then itm.ImageIndex := 31;
      if(ext = '.pas') then itm.ImageIndex := 32;
      if(ext = '.dpr') then itm.ImageIndex := 33;
      if(ext = '.mdb') then itm.ImageIndex := 34;
    end;
  end;
end;

procedure TMainForm.FileListDblClick(Sender: TObject);
var inf: TItemInfo; Path: TFileName; str: string;
begin
  if FileList.Selected <> nil then
  begin
    GetItemInfo(FileList.Selected,inf);
    if inf.ItemType = itFile then Exit;
    if inf.ItemType = itDrive then DriveBox.ItemIndex := FileList.ItemIndex + 1;
    if FileCount > 0 then
    begin
      if ArrayResult[inf.index].Name = '..' then
      begin
        str := ExtractFilePath(ArrayResult[inf.index].FullName);
        Delete(str,Length(str),1);
        Path := ExtractFilePath(str);
      end else Path := ArrayResult[inf.index].FullName
    end
    else Path := CurrentDir + FileList.Selected.Caption;
    if Path[Length(Path)]<>'\'then Path := Path + '\';
    if Server.Status = ssConnect then ShowDirNET(Path)
    else ShowDir(Path);
    CurrentDir := Path;
    AddrEdit.Text := CurrentDir;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
 ShowDrive(true);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  CurrentDir := '';
  Connect := false;
end;

procedure TMainForm.btnUPClick(Sender: TObject);
var Path: TFileName;  str: string;
begin
 if FileCount <= 0 then Exit;
 if ArrayResult[0].Name <> '..' then Exit;
 str := ExtractFilePath(ArrayResult[0].FullName);
 Delete(str,Length(str),1);
 Path := ExtractFilePath(str);
 if Server.Status = ssConnect then ShowDirNET(Path)
 else ShowDir(Path);
 CurrentDir := ExtractFilePath(ArrayResult[0].FullName);
 AddrEdit.Text := CurrentDir;
end;

procedure TMainForm.mnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.DriveBoxChange(Sender: TObject);
var Path: TFileName;
begin
  if DriveBox.ItemIndex < 0 then Exit;
  if DriveBox.ItemIndex = 0 then
  begin
    if Server.Status = ssConnect then ShowDriveNET else ShowDrive;
    ResetArrayResult;
    CurrentDir := '';
    AddrEdit.Text := CurrentDir;
    Exit;
  end;
  Path := DriveBox.Items.Strings[DriveBox.ItemIndex];
  if Server.Status = ssConnect then ShowDirNET(Path)
  else if Server.Status = ssConnect then
  CurrentDir :=  Path;
  AddrEdit.Text := CurrentDir;
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
var Path: TFileName;
begin
  if AddrEdit.Text = '' then Exit;
  Path := AddrEdit.Text;
  if Server.Status = ssConnect then ShowDirNET(Path)
  else ShowDir(Path);
  CurrentDir := ExtractFilePath(ArrayResult[0].FullName);
  AddrEdit.Text := CurrentDir;
end;

procedure TMainForm.FileListKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin
    FileListDblClick(Sender);
    FileList.ItemIndex := 0;
  end;
end;

procedure TMainForm.ShowDriveNET;
var i: integer; itm: TListItem; inf: TItemInfo;
begin
  DriveBox.Items.Clear;
  DriveBox.Items.Add('Root');
  ClearListView(FileList);
  if Server.Status <> ssConnect then Exit;
  DriveCount :=  GetDriveList(DriveList);

  for i := 0 to DriveCount - 1 do
  begin
    itm := FileList.Items.Add;
    itm.Caption := DriveList[i].RootPath;
    inf.Index := i;
    inf.ItemType := itDrive;
    SetItemInfo(inf,itm);
    DriveBox.Items.Add(itm.Caption);
    if DriveList[i].DriveType = DRIVE_FIXED then itm.ImageIndex := 5;
    if DriveList[i].DriveType = DRIVE_REMOVABLE then itm.ImageIndex := 8;
    if DriveList[i].DriveType = DRIVE_CDROM then itm.ImageIndex := 7;
    if DriveList[i].DriveType = DRIVE_REMOTE then itm.ImageIndex := 6;
  end;
end;

procedure TMainForm.btnConnectClick(Sender: TObject);
begin
  StartWSA;
  if Server.Status = ssConnect then
  begin
    DisConnection;
    Self.Caption := 'FileGet';
    Exit;
  end;
  if Connection(IPEdit.Text) then
  begin
    Self.Caption := 'FileGet  [Server: ' + IPEdit.Text + ']';
    ShowDriveNET;
  end;
end;

procedure TMainForm.ShowDirNET(Dir: TFileName);
var i: integer; itm: TListItem; inf: TItemInfo;
    ext: string;
begin
  ClearListView(FileList);
  ResetArrayResult;
  faFileType := faAnyFile - faVolumeID - faSysFile - faHidden;

  FileCount :=  GetFileList(Dir);

  for i := 0 to FileCount - 1 do
  begin
    if (ArrayResult[i].Attr and faDirectory) = faDirectory then
    begin
      itm := FileList.Items.Add;
      itm.Caption := ArrayResult[i].Name;
      inf.Index := i;
      inf.ItemType := itFolder;
      if itm.Caption = '..' then inf.ItemType := itFolder;
      SetItemInfo(inf,itm);
      itm.ImageIndex := 0;
    end;
  end;
  for i := 0 to FileCount - 1 do
  begin
    if (ArrayResult[i].Attr and faDirectory) <> faDirectory then
    begin
      itm := FileList.Items.Add;
      itm.Caption := ArrayResult[i].Name;
      inf.Index := i;
      inf.ItemType := itFile;
      SetItemInfo(inf,itm);
      itm.ImageIndex := 1;
      ext := ExtractFileExt(ArrayResult[i].Name);
      NormalStr(ext);
      if(ext = '.txt')or(ext = '.log')  then itm.ImageIndex := 2;
      if(ext = '.jpg')or(ext = '.jepg') then itm.ImageIndex := 3 ;
      if(ext = '.mp3') then itm.ImageIndex := 9;
      if(ext = '.wav') then itm.ImageIndex := 10;
      if(ext = '.wma') then itm.ImageIndex := 11;
      if(ext = '.mid') then itm.ImageIndex := 12;
      if(ext = '.htm')or(ext = '.html') then itm.ImageIndex := 13;
      if(ext = '.doc') then itm.ImageIndex := 15;
      if(ext = '.xls') then itm.ImageIndex := 14;
      if(ext = '.dll') then itm.ImageIndex := 16;
      if(ext = '.hlp') then itm.ImageIndex := 18;
      if(ext = '.gif')or(ext = '.emf') then itm.ImageIndex := 17;
      if(ext = '.bmp') then itm.ImageIndex := 19;
      if(ext = '.exe') then itm.ImageIndex := 20;
      if(ext ='.avi')or(ext='.mpg')or(ext='.mpeg') then itm.ImageIndex := 21;
      if(ext = '.sys')or(ext = '.inf')or(ext = '.ini') then itm.ImageIndex := 22;
      if(ext = '.zip')or(ext = '.rar') then itm.ImageIndex := 23;
      if(ext = '.com')or(ext = '.bat') then itm.ImageIndex := 24;
      if(ext = '.rtf') then itm.ImageIndex := 25;
      if(ext = '.c') then itm.ImageIndex   := 26;
      if(ext = '.cpp') then itm.ImageIndex := 27;
      if(ext = '.h') then itm.ImageIndex   := 28;
      if(ext = '.hpp') then itm.ImageIndex := 29;
      if(ext = '.dsw')or(ext = '.dsp') then itm.ImageIndex := 30;
      if(ext = '.rc') then itm.ImageIndex  := 31;
      if(ext = '.pas') then itm.ImageIndex := 32;
      if(ext = '.dpr') then itm.ImageIndex := 33;
      if(ext = '.mdb') then itm.ImageIndex := 34;
    end;
  end;
end;
procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 DisConnection;
end;

procedure TMainForm.FileListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var inf: TItemInfo;
begin
  if not Selected then Exit;
  GetItemInfo(Item,inf);
  if inf.ItemType = itFolder then
  begin
    StatBar.Panels.Items[0].Text := 'Тип:  Папка';
    StatBar.Panels.Items[1].Text := 'Размер:  ' + IntToStr(ArrayResult[inf.Index].FileSize) + '  байт';
  end;
  if inf.ItemType = itFile then
  begin
    StatBar.Panels.Items[0].Text := 'Тип:  Файл';
    StatBar.Panels.Items[1].Text := 'Размер:  ' + IntToStr(ArrayResult[inf.Index].FileSize) + '  байт';
  end;
end;

procedure TMainForm.mnFileDelClick(Sender: TObject);
var inf: TItemInfo; itm: TListItem;
begin
  GetItemInfo(FileList.Selected,inf);
  if inf.ItemType = itFile then
  begin
    if DelFile(ArrayResult[inf.Index].FullName) then
    begin
      itm := FileList.Selected;
      DelDataItem(itm);
      FileList.Items.Delete(FileList.Selected.Index);
    end;
  end;

  if inf.ItemType = itFolder then
  begin
    if DelFolder(ArrayResult[inf.Index].FullName) then
    begin
      itm := FileList.Selected;
      DelDataItem(itm);
      FileList.Items.Delete(FileList.Selected.Index);
    end;
  end;
end;

procedure TMainForm.FileListMenuPopup(Sender: TObject);
var inf: TItemInfo; itm: TListItem;
begin
  mnDel.Visible     := FileList.Selected <> nil;
  mnFileDel.Visible := FileList.Selected <> nil;
  mnCopy.Visible    := FileList.Selected <> nil;
  if FileList.Selected = nil then Exit;

  GetItemInfo(FileList.Selected,inf);
  if inf.ItemType = itDrive then
  begin
    mnDel.Enabled := false;
    mnDel.Enabled := false;
  end;
  if inf.ItemType = itFile then  mnDel.Enabled := true;
  if inf.ItemType = itFolder then mnDel.Enabled := false;
  mnFileDel.Enabled := mnDel.Enabled;
  mnCopy.Enabled  := mnDel.Enabled;
end;

procedure TMainForm.mnCopyClick(Sender: TObject);
var inf: TItemInfo; itm: TListItem; Dir: TFileName;
begin
  GetItemInfo(FileList.Selected,inf);
  if DirForm.ShowModal = mrOK then
  begin
    Dir := DirForm.DirList.Directory;
    LoadFile(ArrayResult[inf.Index],Dir);
  end;
end;

end.
