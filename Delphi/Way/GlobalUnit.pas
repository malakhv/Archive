unit GlobalUnit;
interface

type TNodeInfo = record
       Index: integer;    //Индекс в массиве
       Top  : integer;    // Координаты верхнего
       left : integer;    //     левого угла
     end;

type TWaysInfo = record
       Source  : integer; // Источник
       Receiver: integer; // Приемник
       Length: Integer;   // Длина пути
      end;

const node_info_size = SizeOf(TNodeInfo);
const ways_info_size = SizeOf(TWaysInfo);

var F: File;



implementation

end.
