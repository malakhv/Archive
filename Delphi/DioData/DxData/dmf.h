//---------------------------------------------------------------------------

#ifndef dmfH
#define dmfH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TdampForm : public TForm
{
__published:	// IDE-managed Components
        TMemo *dm;
        TMemo *dm1;
        TLabel *Label1;
        TLabel *Label2;
        void __fastcall FormPaint(TObject *Sender);
private:	// User declarations
public:		// User declarations
        byte pa[64];
        byte pa0[64];
        __fastcall TdampForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TdampForm *dampForm;
//---------------------------------------------------------------------------
#endif
