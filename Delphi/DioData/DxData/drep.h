//---------------------------------------------------------------------------
#ifndef drepH
#define drepH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <quickrpt.hpp>
#include <Qrctrls.hpp>
#include <QRCtrls.hpp>
#include <QuickRpt.hpp>
//---------------------------------------------------------------------------
class Tqdr : public TForm
{
__published:	// IDE-managed Components
    TQuickRep *qdr1;
    TQRBand *TitleBand1;
    TQRGroup *QRGroup1;
    TQRBand *QRBand1;
    TQRLabel *QRLabel1;
private:	// User declarations
public:		// User declarations
    __fastcall Tqdr(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tqdr *qdr;
//---------------------------------------------------------------------------
#endif
