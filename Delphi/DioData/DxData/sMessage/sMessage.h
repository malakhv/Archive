//---------------------------------------------------------------------------

#ifndef sMessageH
#define sMessageH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TsMsg : public TForm
{
__published:	// IDE-managed Components
        TLabel *lbl;
        void __fastcall FormPaint(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TsMsg(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TsMsg *sMsg;
//---------------------------------------------------------------------------
#endif
