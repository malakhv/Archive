unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses ADODBWork;

{$R *.dfm}

var
  q: TCustomADODB;

procedure TForm1.Button1Click(Sender: TObject);
var 
    f: TFieldList;

begin
  SetLength(f,1);
  f[0].Field := 'TypeName';
  f[0].Value := 'Cjdctv Yjdsq';
  //q.SaveRec('Select * from PoolType',f,c,smAppend);
  q.AddRec('PoolType',f);

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  q.DelRec('PoolType','PoolType.ID > 3');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  q := TCustomADODB.Create(nil);
  q.ConnectionString := ADOQuery1.ConnectionString;
  q.SQL.Add('Select * from PoolType');
  DataSource1.DataSet := q;
  q.Active := true;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if Assigned(q) then
    q.Free;
end;

end.
