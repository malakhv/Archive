//---------------------------------------------------------------------------

#ifndef abfH
#define abfH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Graphics.hpp>
#include <jpeg.hpp>
#include <ImgList.hpp>
//---------------------------------------------------------------------------
class TaboutForm : public TForm
{
__published:	// IDE-managed Components
        TTimer *Timer1;
        TImage *Image1;
        void __fastcall Timer1Timer(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
        void __fastcall Image1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        bool   noTimer;
        __fastcall TaboutForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TaboutForm *aboutForm;
//---------------------------------------------------------------------------
#endif
