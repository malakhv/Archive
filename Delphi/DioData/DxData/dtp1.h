//---------------------------------------------------------------------------
#ifndef dtp1H
#define dtp1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <quickrpt.hpp>
#include <Qrctrls.hpp>
#include <QuickRpt.hpp>
#include <QRExport.hpp>
#include <QRCtrls.hpp>
//---------------------------------------------------------------------------
typedef struct DtRepSummary
{
 float  Q,t1,t2,v1,v2,v3,v4,m1,m2;
 float  Qmax,v1max,v2max,v3max,v4max;
 int    t1Cnts,t2Cnts;
} TDtRepSummary;

class TdtPreview : public TForm
{
__published:	// IDE-managed Components
    TQuickRep *qr2;
        TQRStringsBand *sband1;
        TQRExpr *QRExpr1;
        TQRExpr *qEx;
        TQRExpr *QRExpr3;
        TQRBand *QRBand3;
        TQRExpr *QRExpr4;
        TQRExpr *QRExpr6;
        TQRExpr *QRExpr7;
        TQRExpr *QRExpr8;
        TQRExpr *QRExpr9;
        TQRExpr *QRExpr5;
        TQRExpr *UbatEx;
        TQRShape *QRShape1;
        TQRShape *QRShape2;
        TQRShape *QRShape3;
        TQRShape *QRShape4;
        TQRShape *QRShape5;
        TQRShape *QRShape6;
        TQRShape *QRShape7;
        TQRShape *QRShape8;
        TQRShape *QRShape9;
        TQRShape *QRShape10;
        TQRShape *QRShape11;
        TQRShape *QRShape12;
        TQRShape *QRShape13;
        TQRShape *QRShape14;
        TQRShape *QRShape15;
        TQRShape *QRShape16;
        TQRShape *QRShape17;
        TQRShape *QRShape18;
        TQRShape *QRShape19;
        TQRShape *QRShape20;
        TQRBand *QRBand1;
        TQRLabel *qrhl1;
        TQRShape *QRShape21;
        TQRLabel *QRLabel12;
        TQRShape *QRShape22;
        TQRLabel *QRLabel13;
        TQRShape *QRShape23;
        TQRLabel *QRLabel14;
        TQRShape *QRShape24;
        TQRShape *QRShape25;
        TQRLabel *QRLabel16;
        TQRShape *QRShape26;
        TQRLabel *QRLabel17;
        TQRShape *QRShape27;
        TQRLabel *QRLabel18;
        TQRShape *QRShape28;
        TQRLabel *QRLabel19;
        TQRShape *QRShape29;
        TQRLabel *QRLabel20;
        TQRShape *QRShape30;
        TQRLabel *QRLabel22;
        TQRLabel *QRLabel23;
        TQRMemo *qmh;
        TQRLabel *QRLabel11;
        TQRLabel *qrwd;
        TQRMemo *qml;
        TQRBand *QRBand2;
        TQRExpr *QRExpr11;
        TQRLabel *QRLabel15;
        TQRLabel *qrdtp;
        TQRLabel *hrsl;
        TQRBand *QRBand4;
        TQRLabel *QRLabel21;
        TQRShape *QRShape31;
        TQRShape *QRShape32;
        TQRShape *QRShape33;
        TQRShape *QRShape34;
        TQRShape *QRShape35;
        TQRShape *QRShape36;
        TQRShape *QRShape37;
        TQRShape *QRShape38;
        TQRLabel *QRLabel1;
        TQRLabel *QRLabel2;
        TQRLabel *QRLabel3;
        TQRLabel *QRLabel4;
        TQRLabel *QRLabel5;
        TQRLabel *QRLabel6;
        TQRLabel *QRLabel7;
        TQRLabel *QRLabel8;
        TQRLabel *QRLabel9;
        TQRLabel *QRLabel10;
        TQRShape *QRShape39;
        TQRShape *QRShape40;
        TQRShape *QRShape41;
        TQRShape *QRShape42;
        TQRShape *QRShape43;
        TQRShape *QRShape44;
        TQRShape *QRShape45;
        TQRShape *QRShape46;
        TQRShape *QRShape47;
        TQRShape *QRShape48;
        TQRLabel *QRLabel24;
        TQRLabel *QRLabel25;
        TQRLabel *QRLabel26;
        TQRLabel *QRLabel27;
        TQRLabel *QRLabel28;
        TQRLabel *QRLabel29;
        TQRLabel *QRLabel30;
        TQRLabel *QRLabel31;
        TQRLabel *QRLabel32;
        TQRLabel *QRLabel33;
        TQRLabel *qSum;
        TQRLabel *t1Expr;
        TQRLabel *t2Expr;
        TQRLabel *v1Sum;
        TQRLabel *v2Sum;
        TQRShape *QRShape49;
        TQRLabel *QRLabel34;
        TQRShape *QRShape50;
        TQRShape *QRShape51;
        TQRShape *QRShape53;
        TQRShape *QRShape52;
  TQRLabel *dtExpr;
  TQRShape *QRShape54;
        void __fastcall QRExpr1Print(TObject *sender, AnsiString &Value);
        void __fastcall sband1BeforePrint(TQRCustomBand *Sender,
          bool &PrintBand);
        void __fastcall QRBand4BeforePrint(TQRCustomBand *Sender,
          bool &PrintBand);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall QRBand1AfterPrint(TQRCustomBand *Sender,
          bool BandPrinted);
        void __fastcall qrInfPrint(TObject *sender, AnsiString &Value);
  void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
        TDtRepSummary smr;
public:		// User declarations
        int     textColumn;
        int     textLines;
        bool    Nakop;
    __fastcall TdtPreview(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TdtPreview *dtPreview;
//---------------------------------------------------------------------------
#endif
