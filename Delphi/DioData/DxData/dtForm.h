//---------------------------------------------------------------------------

#ifndef dtFormH
#define dtFormH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TdtTreeForm : public TForm
{
__published:	// IDE-managed Components
        TTreeView *dtTree;
private:	// User declarations
public:		// User declarations
        __fastcall TdtTreeForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TdtTreeForm *dtTreeForm;
//---------------------------------------------------------------------------
#endif
