//---------------------------------------------------------------------------

#ifndef WordExprtUnitH
#define WordExprtUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
//---------------------------------------------------------------------------
class TWordExprtForm : public TForm
{
__published:	// IDE-managed Components
  TPanel *btnPanel;
  TButton *btnCancel;
  TButton *btnOK;
  TLabel *lblShablon;
  TComboBox *cbShablon;
  TSpeedButton *btnAddShablon;
  TCheckBox *cbPassword;
  TLabel *lblDocName;
  TEdit *edDocName;
  TBevel *Bevel1;
  TLabel *lblCount;
  TCheckBox *crColData;
  TCheckBox *cbColQ;
  TCheckBox *cbColT1;
  TCheckBox *cbColT2;
  TCheckBox *cbColV1;
  TCheckBox *cbColV2;
  TCheckBox *cbColV3;
  TCheckBox *cbColV4;
  TCheckBox *cbColTOkr;
  TCheckBox *cbColU;
  TCheckBox *cbMSWordOpen;
  TCheckBox *cbDeltaT;
  void __fastcall btnOKClick(TObject *Sender);
  void __fastcall btnCancelClick(TObject *Sender);
  void __fastcall cbShablonChange(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
private:	// User declarations
  byte EDioType;
  AnsiString EReportFileDir;
  void SetDioType(byte Value);
  AnsiString GetReportFileName();
public:		// User declarations
  __property byte DioType = {read = EDioType, write = SetDioType};
  __property AnsiString ReportFileName = {read = GetReportFileName};
  __fastcall TWordExprtForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TWordExprtForm *WordExprtForm;
//---------------------------------------------------------------------------
#endif
