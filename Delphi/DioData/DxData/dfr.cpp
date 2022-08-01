//---------------------------------------------------------------------------
#include <vcl.h>
#include <Clipbrd.hpp>
#pragma hdrstop

#include "dfr.h"
#include "ddata.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "PERFGRAP"
#pragma resource "*.dfm"

TDF *DF;

   float DGridCW[11];

//---------------------------------------------------------------------------
__fastcall TDF::TDF(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TDF::DGridDrawCell(TObject *Sender, int Col, int Row,
      TRect &Rect, TGridDrawState State)
{
 if(!State.Contains(gdSelected))
  {
  if(Row & 0x01)
   {
    DGrid->Canvas->Brush->Color=clInfoBk;
   }
   int l,taCol;
   if(DGrid->ColCount==10)
   {
    taCol=8;
    l=DGrid->Cells[8][Row].Length();
    }
   if(DGrid->ColCount==11)
   {
    taCol=9;
    l=DGrid->Cells[9][Row].Length();
  }
   if(DGrid->ColCount==13)
   {
    taCol=11;
    l=DGrid->Cells[0][Row].Length();
    }
 if((Row>0)&(l!=0))
{
TFontStyles FStyle;
FStyle << fsBold;

  if(DGrid->Cells[taCol][Row].ToInt()<-10) {
    DGrid->Canvas->Font->Color=clBlue;
   if(Col==taCol)
    DGrid->Canvas->Font->Style=FStyle;
    } //if
  if(DGrid->Cells[taCol][Row].ToInt()>50)  {
    DGrid->Canvas->Font->Color=clRed;
   if(Col==taCol)
    DGrid->Canvas->Font->Style=FStyle;
    } //if
   }
  }
 int tx,ty;

   switch((Row==0)?DGridHdA[Col]:DGridCA[Col]) {
    case(0):  // left
        tx=Rect.Left+2;
        ty=Rect.Top+(Rect.Bottom-Rect.Top)/2-DGrid->Canvas->TextHeight(DGrid->Cells[Col][Row])/2;
        break;
    case(1):  // right
        tx=Rect.Right-DGrid->Canvas->TextWidth(DGrid->Cells[Col][Row])-4;
        ty=Rect.Top+(Rect.Bottom-Rect.Top)/2-DGrid->Canvas->TextHeight(DGrid->Cells[Col][Row])/2;
        break;
    case(2):  // center
        tx=Rect.Left+(Rect.Right-Rect.Left)/2-DGrid->Canvas->TextWidth(DGrid->Cells[Col][Row])/2;
        ty=Rect.Top+(Rect.Bottom-Rect.Top)/2-DGrid->Canvas->TextHeight(DGrid->Cells[Col][Row])/2;
        break;
   };
    DGrid->Canvas->Rectangle(Rect.Left,Rect.Top,Rect.Right,Rect.Bottom);
    DGrid->Canvas->TextRect(Rect,tx,ty,DGrid->Cells[Col][Row]);
}
//---------------------------------------------------------------------------



void __fastcall TDF::FormCreate(TObject *Sender)
{
cbrd=new TClipboard();

DGrid->Cells[0][0]="Дата/час";
DGrid->Cells[1][0]="Q";
DGrid->Cells[2][0]="t1";
DGrid->Cells[3][0]="t2";
DGrid->Cells[4][0]="V1";
DGrid->Cells[5][0]="V2";
DGrid->Cells[6][0]="V3";
DGrid->Cells[7][0]="V4";
DGrid->Cells[8][0]="t окр.";
DGrid->Cells[9][0]="Бат.";
}
//---------------------------------------------------------------------------

void __fastcall TDF::N7Click(TObject *Sender)
{
    cbrd->Clear();
    AnsiString cbbuf="";

    for(int j=DGrid->Selection.Top;j<=DGrid->Selection.Bottom;j++) {
    for(int i=DGrid->Selection.Left;i<=DGrid->Selection.Right;i++) {
      cbbuf=cbbuf+DGrid->Cells[i][j]+'\t'; }
      cbbuf+='\n';
     }
    cbrd->SetTextBuf(cbbuf.c_str());
}
//---------------------------------------------------------------------------

void __fastcall TDF::FormDestroy(TObject *Sender)
{
    delete cbrd;
}
//---------------------------------------------------------------------------
void __fastcall TDF::Splitter1Moved(TObject *Sender)
{
 graphWin->Height=CoolBar1->Height;
}
//---------------------------------------------------------------------------
TDF::updateGraph()
{
  char colLetter;
  int srst=0;
  bool subsMode=false;
  double prevVal;
  int soff;

 N1->Checked=false;
 N2->Checked=false;
 N3->Checked=false;
 N4->Checked=false;
 N5->Checked=false;

  switch(graphMode) {
   case 0:
   N1->Checked=true;
   break;
   case 1:
   N2->Checked=true;
   break;
   case 2:
   N3->Checked=true;
   break;
   case 3:
   N4->Checked=true;
   break;
   case 4:
   N5->Checked=true;
   break;
  }
     if (graph3D)
        srst=5;
  graphWin->Title->Text->Clear();
        switch(graphMode) {
                case 0: // потребленное тепло
                colLetter='Q';
                graphWin->Title->Text->Add("Интегрированная потребленная тепловая энергия (ГКал)");
                break;
                case 4: // потребленное тепло
                colLetter='Q';
                graphWin->Title->Text->Add("Потребленная тепловая энергия (ГКал)");
                subsMode=true;
                break;
                case 1: // объем
                colLetter='V';
                graphWin->Title->Text->Add("Объем накопительный (m3)");
                break;
                case 2: // расход
                colLetter='V';
                graphWin->Title->Text->Add("Расход (m3/ч или m3/сутки)");
                subsMode=true;
                break;
                case 3: // температура
                colLetter='t';
                graphWin->Title->Text->Add("Температура (oC)");
                break;
        } //switch
   int seriesNum=0;
   TColor sColor;
   for(int i=0;i<graphWin->SeriesList->Count;i++) {
           graphWin->Series[i]->Name=AnsiString(colLetter)+IntToStr(i+1);
           graphWin->Series[i]->Clear();
           graphWin->Series[i]->Active=false;
           }
   for(int i=1;i<DGrid->ColCount;i++) {
     if(DGrid->Cells[i][0][1]==colLetter) {

soff=0;
 if(subsMode) {
    if((DGrid->Selection.Top>1)) {
        prevVal=StrToFloat(DGrid->Cells[i][DGrid->Selection.Top-1]);
        soff=0;
    }
     else {
        soff=1;
        prevVal=StrToFloat(DGrid->Cells[i][1]);
        }  //if
     } //if
      sColor=graphWin->Series[seriesNum+srst]->SeriesColor;
       graphWin->Series[seriesNum+srst]->Active=true;
        for(int j=(DGrid->Selection.Top+soff);j<DGrid->Selection.Bottom+1;j++) {
          AnsiString sLabel=DGrid->Cells[0][j];
          double value=StrToFloatDef(DGrid->Cells[i][j],0);
                if(subsMode) {
                        float s=value;
                        value-=prevVal;
                        prevVal=s;
                        }
          graphWin->Series[seriesNum+srst]->Add(value,sLabel,sColor);
          } //for
          seriesNum++;
     } //if
   }//for
}
//---------------------------------------------------------------------------
void __fastcall TDF::N1Click(TObject *Sender)
{
 graphMode=0;
 updateGraph();
}
//---------------------------------------------------------------------------

void __fastcall TDF::N2Click(TObject *Sender)
{
 graphMode=1;
 updateGraph();
}
//---------------------------------------------------------------------------

void __fastcall TDF::N3Click(TObject *Sender)
{
 graphMode=2;
 updateGraph();
}
//---------------------------------------------------------------------------

void __fastcall TDF::N4Click(TObject *Sender)
{
 graphMode=3;
 updateGraph();
}
//---------------------------------------------------------------------------

void __fastcall TDF::DGridMouseUp(TObject *Sender, TMouseButton Button,
      TShiftState Shift, int X, int Y)
{
 updateGraph();
}
//---------------------------------------------------------------------------


void __fastcall TDF::N12Click(TObject *Sender)
{
 graph3D=!graph3D;
 N12->Checked=graph3D;
 graphWin->View3D=graph3D;
 updateGraph();
}
//---------------------------------------------------------------------------

void __fastcall TDF::N10Click(TObject *Sender)
{
 graphWin->PrintLandscape();
}
//---------------------------------------------------------------------------

void __fastcall TDF::N5Click(TObject *Sender)
{
 graphMode=4;
 updateGraph();
}
//---------------------------------------------------------------------------

