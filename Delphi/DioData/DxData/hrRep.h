//---------------------------------------------------------------------------

#ifndef hrRepH
#define hrRepH
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
typedef struct HrRepSummary
{
 float  Q,t1,t2,v1,v2,v3,v4,m1,m2;
 float  Qmax,v1max,v2max,v3max,v4max;
 int    t1Cnts,t2Cnts;
} THrRepSummary;


class ThrPreview : public TForm
{
__published:	// IDE-managed Components
        TQuickRep *qr2;
        TQRStringsBand *sband1;
        TQRStringsBand *smd;
        TQRExpr *QRExpr1;
        TQRExpr *QRExpr2;
        TQRExpr *qEx;
        TQRExpr *QRExpr3;
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
        TQRLabel *QRLabel1;
        TQRLabel *QRLabel2;
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
        TQRSysData *QRSysData1;
        TQRStringsBand *smb;
        TQRExpr *QRExpr10;
        TQRShape *QRShape11;
        TQRExpr *QRExpr11;
        TQRExpr *QRExpr12;
        TQRExpr *QRExpr13;
        TQRExpr *QRExpr14;
        TQRLabel *QRLabel3;
        TQRShape *QRShape12;
        TQRShape *QRShape13;
        TQRShape *QRShape14;
        TQRShape *QRShape15;
        TQRShape *QRShape16;
        TQRShape *QRShape17;
        TQRShape *QRShape18;
        TQRShape *QRShape19;
        TQRLabel *hrSNum;
        TQRExpr *QRExpr15;
        TQRExpr *QRExpr16;
        TQRShape *QRShape20;
        TQRShape *QRShape31;
        TQRShape *QRShape32;
        TQRShape *QRShape33;
        TQRShape *QRShape34;
        TQRLabel *QRLabel4;
        TQRLabel *qrInf;
	TQRBand *QRBand2;
	TQRExpr *QRExpr17;
	TQRLabel *QRLabel15;
        void __fastcall hrExPrint(TObject *sender, AnsiString &Value);
        void __fastcall sband1BeforePrint(TQRCustomBand *Sender,
          bool &PrintBand);
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall qr2EndPage(TCustomQuickRep *Sender);
        void __fastcall hrTotalPrint(TObject *sender, AnsiString &Value);
        void __fastcall smbBeforePrint(TQRCustomBand *Sender,
          bool &PrintBand);
        void __fastcall qr2StartPage(TCustomQuickRep *Sender);
        void __fastcall sband1AfterPrint(TQRCustomBand *Sender,
          bool BandPrinted);
        void __fastcall smdAfterPrint(TQRCustomBand *Sender,
          bool BandPrinted);
        void __fastcall smbAfterPrint(TQRCustomBand *Sender,
          bool BandPrinted);
private:	// User declarations
        THrRepSummary smr;
        int     textColumn;
        bool    hasNewPage;
        int     lastHr;
        int     textLines;
public:		// User declarations
        __fastcall ThrPreview(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE ThrPreview *hrPreview;
//---------------------------------------------------------------------------
#endif
