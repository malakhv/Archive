//---------------------------------------------------------------------------
#ifndef dstgsH
#define dstgsH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
class Tstgs : public TForm
{
__published:	// IDE-managed Components
    TButton *Button1;
    TBevel *Bevel1;
    TLabel *Label1;
    TEdit *mainDir;
    TCheckBox *saveBeforeExit;
    TCheckBox *eachNumDir;
    TFontDialog *fntd;
    TEdit *FName;
    TLabel *Label2;
    void __fastcall Button1Click(TObject *Sender);
    void __fastcall FormActivate(TObject *Sender);
    
    void __fastcall Button2Click(TObject *Sender);
    void __fastcall Button3Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
    __fastcall Tstgs(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tstgs *stgs;
//---------------------------------------------------------------------------
#endif
