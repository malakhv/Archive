unit GlobalUnit;
interface

type TNodeInfo = record
       Index: integer;    //������ � �������
       Top  : integer;    // ���������� ��������
       left : integer;    //     ������ ����
     end;

type TWaysInfo = record
       Source  : integer; // ��������
       Receiver: integer; // ��������
       Length: Integer;   // ����� ����
      end;

const node_info_size = SizeOf(TNodeInfo);
const ways_info_size = SizeOf(TWaysInfo);

var F: File;



implementation

end.
