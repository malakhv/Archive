//---------------------------------------------------------------------------

#ifndef prdIvlSetH
#define prdIvlSetH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <CheckLst.hpp>
//---------------------------------------------------------------------------
class TprnIvl : public TForm
{
__published:	// IDE-managed Components
        TPageControl *hdtPage;
        TTabSheet *hdtSheet;
        TTabSheet *hrdtSheet;
        TButton *Button1;
        TButton *Button2;
        TDateTimePicker *prnIvlFrom;
        TDateTimePicker *prnIvlTo;
        TLabel *Label1;
        TLabel *Label2;
        TComboBox *fsCombo;
        TCheckListBox *clb;
        TButton *Button3;
        TButton *Button4;
        TCheckBox *cbNakop;
        TCheckBox *cbExportMSWord;
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall Button2Click(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall Button3Click(TObject *Sender);
        void __fastcall Button4Click(TObject *Sender);
  void __fastcall cbNakopClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
        bool selected;
        bool Nakop;
        TDateTime       dtFrom;
        TDateTime       dtTo;
        __fastcall TprnIvl(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TprnIvl *prnIvl;
//---------------------------------------------------------------------------
#endif
