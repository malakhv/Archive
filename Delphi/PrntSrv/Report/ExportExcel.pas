unit ExportExcel;

interface

uses ComObj, Variants;

type
  TExcelApplication = class(TObject)
  private
    FVisible: boolean;
    FHead: string;
    FConnection: boolean;
    procedure SetVisible(const Value: boolean);

  public
    ExcelApp: variant;
    property Head: string read FHead write FHead;
    property Visible: boolean read FVisible write SetVisible;
    property Connection: boolean read FConnection;
    procedure Connect;
    procedure Show;
    procedure Hide;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TExcelDoc }

const
  ExcelAppString = 'Excel.Application';

constructor TExcelApplication.Create;
begin
  inherited Create;
  FConnection := false;
end;

destructor TExcelApplication.Destroy;
begin
  inherited;
end;

procedure TExcelApplication.Connect;
begin
  ExcelApp := CreateOleObject(ExcelAppString);
  FConnection := ExcelApp <> Null;  
end;

procedure TExcelApplication.Hide;
begin
  Visible := false;
end;

procedure TExcelApplication.SetVisible(const Value: boolean);
begin
  FVisible := Value;
  ExcelApp.Visible := Value;
end;

procedure TExcelApplication.Show;
begin
  Visible := true;
end;

end.
