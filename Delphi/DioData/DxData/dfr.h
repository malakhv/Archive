//---------------------------------------------------------------------------
#ifndef dfrH
#define dfrH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Grids.hpp>
#include <Menus.hpp>
#include <ComCtrls.hpp>
#include <ToolWin.hpp>
#include <ExtCtrls.hpp>
#include "PERFGRAP.h"
#include <chartfx3.hpp>
#include <OleCtrls.hpp>
#include <vcfi.hpp>
#include <Chart.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
#include <Series.hpp>
//---------------------------------------------------------------------------
   unsigned char DGridHdA[13]={2,2,2,2,2,2,2,2,2,2,2,2,2};
   unsigned char DGridCA[13]={2,1,1,1,1,1,1,1,1,1,1,1,1};

class TDF : public TForm
{
__published:	// IDE-managed Components
    TStringGrid *DGrid;
    TPopupMenu *PopupMenu1;
    TMenuItem *N7;
        TSplitter *Splitter1;
        TCoolBar *CoolBar1;
        TChart *graphWin;
        TPopupMenu *grapMenu;
        TMenuItem *N1;
        TMenuItem *N2;
        TMenuItem *N3;
        TMenuItem *N4;
        TMenuItem *N9;
        TMenuItem *N10;
        TMenuItem *N11;
        TMenuItem *N12;
        TLineSeries *Series1;
        TLineSeries *Series2;
        TLineSeries *Series3;
        TLineSeries *Series4;
        TLineSeries *Series5;
        TLineSeries *Series6;
        TLineSeries *Series7;
        TLineSeries *Series8;
        TLineSeries *Series9;
        TLineSeries *Series10;
        TMenuItem *N5;
    void __fastcall DGridDrawCell(TObject *Sender, int Col, int Row,
          TRect &Rect, TGridDrawState State);
    
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall N7Click(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
        void __fastcall Splitter1Moved(TObject *Sender);
        void __fastcall N1Click(TObject *Sender);
        void __fastcall N2Click(TObject *Sender);
        void __fastcall N3Click(TObject *Sender);
        void __fastcall N4Click(TObject *Sender);
        void __fastcall DGridMouseUp(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
        void __fastcall N12Click(TObject *Sender);
        void __fastcall N10Click(TObject *Sender);
        void __fastcall N5Click(TObject *Sender);
private:
        int FgraphMode;
        bool Fgraph3D;	// User declarations
public:		// User declarations
        TClipboard *cbrd;
// выравнивание столбцов 0 - left, 1 - right, 2 - center.
    __fastcall TDF(TComponent* Owner);
        updateGraph();
    __property int graphMode  = { read=FgraphMode, write=FgraphMode, default=0 };
        __property bool graph3D  = { read=Fgraph3D, write=Fgraph3D, default=true };
};
//---------------------------------------------------------------------------
extern PACKAGE TDF *DF;
//---------------------------------------------------------------------------
#endif
