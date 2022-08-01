//---------------------------------------------------------------------------

#ifndef devDH
#define devDH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TdevDescr : public TForm
{
__published:	// IDE-managed Components
        TButton *Button1;
        TEdit *addrEdit;
        TLabel *Label1;
        TEdit *ownerEdit;
        TLabel *Label2;
        TButton *Button2;
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall Button2Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TdevDescr(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TdevDescr *devDescr;
//---------------------------------------------------------------------------
#endif
