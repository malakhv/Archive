{ The pair of Key and related Value. }
Pair<TKey, TValue> = record
    Key: TKey;
    Value: TValue;
    function HasValue: Boolean;
end;

function Pair<TKey, TValue>.HasValue: Boolean;
var t: TTypeKind;
begin
    Result := SizeOf(Self.Value) > 0;
    WriteLn(SizeOf(Self.Value));
end;
