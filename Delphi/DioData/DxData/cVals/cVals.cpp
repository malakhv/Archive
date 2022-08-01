//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "cVals.h"
#include "cVRep.h"
#include "wincard\wcrd.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TcfVals *cfVals;

const char* f22[18]={"Серийный номер","Тепловая энергия (Гкал)","Температура 1 (oC)",
"Температура 2 (oC)","Объем 1 (m3)","Объем 2 (m3)","Объем 3 (m3)","Объем 4 (m3)",
"Масса 1 (т)","Масса 2 (т)","k1 (л/имп)","k2 (л/имп)","k3 (л/имп)",
"k4 (л/имп)","Батарея (Вольт)","Темпер. окр. среды (oC)","Наработка (ч)","Время"};

const char* f33[17]={"Серийный номер","Тепловая энергия 1 (Гкал)","Температура 1 (oC)",
"Температура 2 (oC)","Объем 1 (m3)","Объем 2 (m3)","Тепловая энергия 2 (Гкал)","Объем 3 (m3)",
"Масса 1 (т)","Масса 2 (т)","k1 (л/имп)","k2 (л/имп)","k3 (л/имп)",
"Батарея (Вольт)","Темпер. окр. среды (oC)","Наработка (ч)","Время"};
//---------------------------------------------------------------------------
__fastcall TcfVals::TcfVals(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TcfVals::Button1Click(TObject *Sender)
{
 Close();
}
//---------------------------------------------------------------------------
void __fastcall TcfVals::FormActivate(TObject *Sender)
{
iGrid->ColWidths[0]=150;
iGrid->ColWidths[1]=130;
int iRows;
 switch(dioType) {
        case dio2T4V:
                iRows=18;
                iGrid->RowCount=iRows;
                for(int i=0;i<iRows;i++)
                        iGrid->Cells[0][i]=AnsiString(f22[i]);
        iGrid->Cells[1][0]=IntToStr(snum);
        iGrid->Cells[1][1]=FloatToStrF(q1,ffFixed,12,3);
        iGrid->Cells[1][2]=(ErrCd&0x01)?(AnsiString("Не подключен.")):(FloatToStrF(t1,ffFixed,5,2));
        iGrid->Cells[1][3]=(ErrCd&0x02)?(AnsiString("Не подключен.")):(FloatToStrF(t2,ffFixed,5,2));
        iGrid->Cells[1][4]=FloatToStrF(v1,ffFixed,12,3);
        iGrid->Cells[1][5]=FloatToStrF(v2,ffFixed,12,3);
        iGrid->Cells[1][6]=FloatToStrF(v3,ffFixed,12,3);
        iGrid->Cells[1][7]=FloatToStrF(v4,ffFixed,12,3);
        iGrid->Cells[1][8]=FloatToStrF(m1,ffFixed,12,3);
        iGrid->Cells[1][9]=FloatToStrF(m2,ffFixed,12,3);
        iGrid->Cells[1][10]=FloatToStrF(k1,ffFixed,12,2);
        iGrid->Cells[1][11]=FloatToStrF(k2,ffFixed,12,2);
        iGrid->Cells[1][12]=FloatToStrF(k3,ffFixed,12,2);
        iGrid->Cells[1][13]=FloatToStrF(k4,ffFixed,12,2);
        iGrid->Cells[1][14]=FloatToStrF(bs,ffFixed,5,2);
        iGrid->Cells[1][15]=FloatToStrF(ta,ffFixed,5,1);
        iGrid->Cells[1][16]=IntToStr(hrs);
        iGrid->Cells[1][17]=DateToStr(Date())+"   "+TimeToStr(Time());
        break;
        case dio3T3V:
                iRows=17;
                iGrid->RowCount=iRows;
                for(int i=0;i<iRows;i++)
                        iGrid->Cells[0][i]=AnsiString(f33[i]);
        iGrid->Cells[1][0]=IntToStr(snum);
        iGrid->Cells[1][1]=FloatToStrF(q1,ffFixed,12,3);
        iGrid->Cells[1][2]=(ErrCd&0x01)?(AnsiString("Не подключен.")):(FloatToStrF(t1,ffFixed,5,2));
        iGrid->Cells[1][3]=(ErrCd&0x02)?(AnsiString("Не подключен.")):(FloatToStrF(t2,ffFixed,5,2));
        iGrid->Cells[1][4]=FloatToStrF(v1,ffFixed,12,3);
        iGrid->Cells[1][5]=FloatToStrF(v2,ffFixed,12,3);
        iGrid->Cells[1][6]=FloatToStrF(q2,ffFixed,12,3);
        iGrid->Cells[1][7]=FloatToStrF(v3,ffFixed,12,3);
        iGrid->Cells[1][8]=FloatToStrF(m1,ffFixed,12,3);
        iGrid->Cells[1][9]=FloatToStrF(m2,ffFixed,12,3);
        iGrid->Cells[1][10]=FloatToStrF(k1,ffFixed,12,2);
        iGrid->Cells[1][11]=FloatToStrF(k2,ffFixed,12,2);
        iGrid->Cells[1][12]=FloatToStrF(k3,ffFixed,12,2);
        iGrid->Cells[1][13]=FloatToStrF(bs,ffFixed,5,2);
        iGrid->Cells[1][14]=FloatToStrF(ta,ffFixed,5,1);
        iGrid->Cells[1][15]=IntToStr(hrs);
        iGrid->Cells[1][16]=DateToStr(Date())+"   "+TimeToStr(Time());
        break;
 }
}
//---------------------------------------------------------------------------
void __fastcall TcfVals::cValsPrintClick(TObject *Sender)
{
switch(dioType) {
case dio2T4V:
 cValsRep->qld->Caption=DateToStr(Date())+"   "+TimeToStr(Time());
 cValsRep->qln->Caption=IntToStr(snum);
 cValsRep->qlh->Caption=IntToStr(hrs);
 cValsRep->qlb->Caption=FloatToStrF(bs,ffFixed,5,2);
 cValsRep->qta->Caption=FloatToStrF(ta,ffFixed,5,1);

 cValsRep->qlq->Caption=FloatToStrF(q1,ffFixed,12,3);
 cValsRep->qlv1->Caption=FloatToStrF(v1,ffFixed,12,3);
 cValsRep->qlv2->Caption=FloatToStrF(v2,ffFixed,12,3);
 cValsRep->qlv3->Caption=FloatToStrF(v3,ffFixed,12,3);
 cValsRep->qlv4->Caption=FloatToStrF(v4,ffFixed,12,3);
 cValsRep->qlm1->Caption=FloatToStrF(m1,ffFixed,12,3);
 cValsRep->qlm2->Caption=FloatToStrF(m2,ffFixed,12,3);
 cValsRep->qlt1->Caption=(ErrCd&0x01)?(AnsiString("Не подключен.")):(FloatToStrF(t1,ffFixed,5,2));
 cValsRep->qlt2->Caption=(ErrCd&0x02)?(AnsiString("Не подключен.")):(FloatToStrF(t2,ffFixed,5,2));
 cValsRep->qlk1->Caption=FloatToStrF(k1,ffFixed,12,2);
 cValsRep->qlk2->Caption=FloatToStrF(k2,ffFixed,12,2);
 cValsRep->qlk3->Caption=FloatToStrF(k3,ffFixed,12,2);
 cValsRep->qlk4->Caption=FloatToStrF(k4,ffFixed,12,2);
 cValsRep->vRep->Preview();
 break;
 }
}
//---------------------------------------------------------------------------





