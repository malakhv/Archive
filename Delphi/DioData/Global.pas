unit Global;

interface

uses SysUtils, DioDataLib, DioInfoLib, DioTypeLib, XMLDioList;

var
  AppDir: TFileName;
  DioData: TDioData;
  DioInfo: TDioInfo;
  DioType: TDioType;
  IDioList: IXMLDioList;

implementation

const
  DefDioList = 'DioList.xml';

initialization
begin
  DioData := TDioData.Create;
  DioInfo := TDioInfo.Create;
  DioType := TDioType.Create;
end;

finalization
begin
  if Assigned(DioData) then DioData.Free;
  if Assigned(DioInfo) then DioInfo.Free;
  if Assigned(DioType) then DioType.Free;
end;

end.
