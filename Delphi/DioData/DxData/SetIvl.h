//---------------------------------------------------------------------------
#ifndef SetIvlH
#define SetIvlH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TsetIvlFrm : public TForm
{
__published:	// IDE-managed Components
    TDateTimePicker *dtFrom;
    TDateTimePicker *dtTo;
    TLabel *Label1;
    TLabel *Label2;
    TButton *Button1;
    TBevel *Bevel1;
    TButton *Button2;
    void __fastcall Button1Click(TObject *Sender);
    void __fastcall FormActivate(TObject *Sender);
    void __fastcall Button2Click(TObject *Sender);
    
private:	// User declarations
public:		// User declarations
    bool selected;
    __fastcall TsetIvlFrm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TsetIvlFrm *setIvlFrm;
//---------------------------------------------------------------------------
#endif
