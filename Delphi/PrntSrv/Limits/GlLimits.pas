unit GlLimits;

interface

const
  LimitType1 = '�� ����������';
  LimitType2 = '�� �������';
  LimitType3 = '���������';
  LimitType0 = 'No Data';

const
  minFormClientH = 334;
  minFormClientW = 418;

type
  TNewLimit = record
    PageLimit: integer;
  end;

type
  TProgOptions = record
    NewLimit: TNewLimit;
  end;


var
  ProgOptions: TProgOptions;
  AppDir: string;

procedure LoadDefOptions;

implementation

procedure LoadDefOptions;
begin
  ProgOptions.NewLimit.PageLimit := 50;
end;

end.
