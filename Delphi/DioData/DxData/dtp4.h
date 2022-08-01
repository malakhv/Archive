//---------------------------------------------------------------------------

#ifndef dtp4H
#define dtp4H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Qrctrls.hpp>
#include <QuickRpt.hpp>
#include <QRCtrls.hpp>
//---------------------------------------------------------------------------
typedef struct DtRep44Summary
{
 float  Q,Q1,t1,t2,t3,t4,v1,v2,v3,v4,m1,m2;
 float  Qmax,Q1max,v1max,v2max,v3max,v4max;
 int    t1Cnts,t2Cnts,t3Cnts,t4Cnts;
} TDtRep44Summary;

class TdtPreview44 : public TForm
{
__published:	// IDE-managed Components
        TQuickRep *qr2;
        TQRStringsBand *sband1;
        TQRShape *QRShape10;
        TQRShape *QRShape9;
        TQRShape *QRShape6;
        TQRShape *QRShape5;
        TQRShape *QRShape4;
        TQRShape *QRShape3;
        TQRShape *QRShape2;
        TQRShape *QRShape1;
        TQRExpr *q1;
        TQRExpr *q2;
        TQRExpr *q3;
        TQRExpr *q4;
        TQRExpr *q5;
        TQRExpr *q6;
        TQRShape *QRShape8;
        TQRShape *QRShape36;
        TQRShape *QRShape41;
        TQRShape *QRShape42;
        TQRShape *QRShape43;
        TQRExpr *QRExpr2;
        TQRExpr *QRExpr3;
        TQRExpr *QRExpr4;
        TQRExpr *QRExpr6;
        TQRExpr *QRExpr7;
        TQRExpr *QRExpr8;
        TQRExpr *QRExpr9;
        TQRStringsBand *smd;
        TQRExpr *QRExpr1;
        TQRLabel *QRLabel1;
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
        TQRShape *QRShape29;
        TQRShape *QRShape30;
        TQRLabel *QRLabel23;
        TQRLabel *hrSNum;
        TQRShape *QRShape35;
        TQRLabel *QRLabel22;
        TQRShape *QRShape27;
        TQRLabel *QRLabel5;
        TQRShape *QRShape28;
        TQRLabel *QRLabel6;
        TQRShape *QRShape37;
        TQRShape *QRShape38;
        TQRLabel *QRLabel7;
        TQRShape *QRShape39;
        TQRLabel *QRLabel8;
        TQRLabel *QRLabel9;
        TQRShape *QRShape40;
        TQRLabel *QRLabel10;
        TQRLabel *QRLabel11;
        TQRLabel *QRLabel15;
        TQRSysData *QRSysData1;
        TQRStringsBand *smb;
        TQRShape *QRShape17;
        TQRShape *QRShape45;
        TQRShape *QRShape33;
        TQRShape *QRShape31;
        TQRShape *QRShape20;
        TQRShape *QRShape19;
        TQRShape *QRShape18;
        TQRShape *QRShape16;
        TQRShape *QRShape15;
        TQRShape *QRShape14;
        TQRShape *QRShape13;
        TQRShape *QRShape12;
        TQRShape *QRShape11;
        TQRExpr *QRExpr10;
        TQRExpr *QRExpr11;
        TQRExpr *QRExpr12;
        TQRExpr *QRExpr13;
        TQRExpr *QRExpr14;
        TQRLabel *QRLabel3;
        TQRShape *QRShape32;
        TQRShape *QRShape34;
        TQRLabel *QRLabel4;
        TQRShape *QRShape7;
        TQRShape *QRShape44;
        TQRExpr *QRExpr5;
        TQRExpr *QRExpr15;
        TQRExpr *QRExpr16;
        TQRExpr *QRExpr17;
        TQRExpr *QRExpr18;
        TQRLabel *qrInf;
        void __fastcall q1Print(TObject *sender, AnsiString &Value);
        void __fastcall sband1BeforePrint(TQRCustomBand *Sender,
          bool &PrintBand);
        void __fastcall smdAfterPrint(TQRCustomBand *Sender,
          bool BandPrinted);
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall dtTotalPrint(TObject *sender, AnsiString &Value);
        void __fastcall sband1AfterPrint(TQRCustomBand *Sender,
          bool BandPrinted);
        void __fastcall smbAfterPrint(TQRCustomBand *Sender,
          bool BandPrinted);
        void __fastcall smbBeforePrint(TQRCustomBand *Sender,
          bool &PrintBand);
private:	// User declarations
        TDtRep44Summary smr;
public:		// User declarations
        int     textColumn;
        int     textLines;
        __fastcall TdtPreview44(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TdtPreview44 *dtPreview44;
//---------------------------------------------------------------------------
#endif
