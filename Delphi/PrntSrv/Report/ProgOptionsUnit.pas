unit ProgOptionsUnit;

interface

uses SysUtils, Graphics;

const
  OptFileName = 'Options.dat';

type
  TFName = string[255];

type
  TOptions = record
    TreeState: boolean;
    FontSize: Integer;
    FontName: TFName;
    FontColor: TColor;
  end;

type
  TProgOpt = class(TObject)
  public
    Options: TOptions;
    constructor Create;
    procedure LoadDefOptions;
    procedure SaveToFile(AFileName: TFileName = '');
    procedure LoadFromFile(AFileName: TFileName = '');
  end;

implementation

const
  DefFontName   = 'MS Sans Serif';
  DefFontColor  = clBlack;
  DefFontSize   = 8;
  DefTreeState  = true;

{ TProgOpt }

constructor TProgOpt.Create;
begin
  inherited Create;
  LoadDefOptions;
end;

procedure TProgOpt.LoadDefOptions;
begin
  Options.TreeState := DefTreeState;
  Options.FontSize  := DefFontSize;
  Options.FontName  := DefFontName;
  Options.FontColor := DefFontColor;
end;

procedure TProgOpt.LoadFromFile(AFileName: TFileName);
var f: file of TOptions; FlName: TFileName;
begin
  if AFileName = '' then FlName := OptFileName
  else FlName := AFileName;
  if not FileExists(FlName) then
  begin
    LoadDefOptions;
    Exit;
  end;
  AssignFile(f,FlName);
  Reset(f);
  try
    Read(f,Options);
  finally
    CloseFile(f);
  end;
end;

procedure TProgOpt.SaveToFile(AFileName: TFileName);
var f: file of TOptions;
begin
  if AFileName <> '' then AssignFile(f,AFileName)
  else AssignFile(f,OptFileName);
  Rewrite(f);
  try
    Write(f,Options);
  finally
    CloseFile(f);
  end;
end;

end.
