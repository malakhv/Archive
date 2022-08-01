unit ViewUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TViewForm = class(TForm)
    Image: TImage;
    procedure FormShow(Sender: TObject);
    procedure ImageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewForm: TViewForm;

implementation

uses MainUnit;

{$R *.dfm}

procedure TViewForm.FormShow(Sender: TObject);
begin
 image.Picture.LoadFromFile(MainUnit.ViewFileName); 
end;

procedure TViewForm.ImageClick(Sender: TObject);
begin
 Close;
end;

end.
