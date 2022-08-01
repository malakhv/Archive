//---------------------------------------------------------------------------
#ifndef cDDataRepH
#define cDDataRepH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <quickrpt.hpp>
#include <Qrctrls.hpp>
#include <Db.hpp>
#include <DBTables.hpp>
#include <qrprntr.hpp>
#include <QRCtrls.hpp>
#include <QuickRpt.hpp>
//---------------------------------------------------------------------------
class TDDataRep : public TForm
{
__published:	// IDE-managed Components
    TQuickRep *qrd;
    TQRLabel *QRLabel1;
private:	// User declarations
public:		// User declarations
    __fastcall TDDataRep(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TDDataRep *DDataRep;
//---------------------------------------------------------------------------
#endif
