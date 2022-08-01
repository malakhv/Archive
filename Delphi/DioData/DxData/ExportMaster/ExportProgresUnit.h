//---------------------------------------------------------------------------

#ifndef ExportProgresUnitH
#define ExportProgresUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "CGAUGES.h"
//---------------------------------------------------------------------------
class TExportProgresForm : public TForm
{
__published:	// IDE-managed Components
  TCGauge *Progress;
  TLabel *lblInfo;
  void __fastcall FormShow(TObject *Sender);
private:	// User declarations
  AnsiString GetInfo();
  void SetInfo(AnsiString Value);

public:		// User declarations
  __property AnsiString Info = {read = GetInfo, write = SetInfo};
  __fastcall TExportProgresForm(TComponent* Owner);
  void AddProgress(int Value);

};
//---------------------------------------------------------------------------
extern PACKAGE TExportProgresForm *ExportProgresForm;
//---------------------------------------------------------------------------
#endif
