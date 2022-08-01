//---------------------------------------------------------------------------

#ifndef ExportMasterUnitH
#define ExportMasterUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Graphics.hpp>
#include <Buttons.hpp>
#include <Dialogs.hpp>
#include <ComCtrls.hpp>
#include "ReportUnit.h"
//---------------------------------------------------------------------------
class TMasterExportForm : public TForm
{
__published:	// IDE-managed Components
  TImage *LogoImage;
  TPanel *btnPanel;
  TPanel *StartPanel;
  TLabel *lblHead;
  TLabel *Label2;
  TLabel *Label3;
  TButton *btnCancel;
  TButton *btnNext;
  TButton *btnPrev;
  TLabel *Label1;
  TPanel *SavePanel;
  TLabel *PageSaveHead;
  TLabel *PageSaveText;
  TBevel *PageSaveLine1;
  TEdit *edDocFileName;
  TCheckBox *cbSaveAs;
  TCheckBox *cbOpenMSWord;
  TSpeedButton *btnSaveDocFile;
  TBevel *PageSaveLine2;
  TEdit *edPswrdOpen;
  TEdit *edPswrdWrite;
  TCheckBox *cbPswrdGenerate;
  TLabel *lblPswrdOpen;
  TLabel *lblPswrdWrite;
  TSaveDialog *SaveDialog;
  TPanel *TimePanel;
  TPanel *ViewPanel;
  TPanel *Panel3;
  TLabel *lblTimePanelHead;
  TLabel *lblTimePanelText;
  TDateTimePicker *dtpStartDate;
  TDateTimePicker *dtpEndDate;
  TLabel *Label6;
  TLabel *Label7;
  TCheckBox *cbNakop;
  TLabel *Label4;
  TLabel *Label5;
  TComboBox *cbShablon;
  TLabel *lblShablon;
  TSpeedButton *btnAddShablon;
  TLabel *lblCount;
  TCheckBox *crColDate;
  TCheckBox *cbColQ;
  TCheckBox *cbColT1;
  TCheckBox *cbColT2;
  TCheckBox *cbColV1;
  TCheckBox *cbColV2;
  TCheckBox *cbColV3;
  TCheckBox *cbColV4;
  TCheckBox *cbColTOkr;
  TCheckBox *cbColU;
  TCheckBox *cbColDT;
  void __fastcall cbSaveAsClick(TObject *Sender);
  void __fastcall cbPswrdGenerateClick(TObject *Sender);
  void __fastcall btnSaveDocFileClick(TObject *Sender);
  void __fastcall cbShablonChange(TObject *Sender);
  void __fastcall btnNextClick(TObject *Sender);
  void __fastcall btnPrevClick(TObject *Sender);
  void __fastcall btnCancelClick(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
private:
  byte EPageIndex;
  byte EPageCount;
  void SetPageIndex(byte Value);
  // Имя файла
  AnsiString EReportFileDir;
  AnsiString GetReportFileName();
  // Работа с начальной и конечной датой
  TDateTime EDateTo;
  TDateTime EDateFrom;
  void SetDateTo(TDateTime Value);
  void SetDateFrom(TDateTime Value);
  // Работа с информацией о таблице
  int GetColCount();
  void __fastcall SetDioType(TObject* Sender);
public:
  PRepInfo RepInfo;
  __fastcall TMasterExportForm(TComponent* Owner);
  __property byte PageIndex = {read = EPageIndex, write = SetPageIndex};
  __property byte PageCount = {read = EPageCount};
  __property AnsiString ReportFileName = {read = GetReportFileName};
  __property TDateTime DateTo = {read = EDateTo, write = SetDateTo};
  __property TDateTime DateFrom = {read = EDateFrom, write = SetDateFrom};
  byte NextPage();
  byte PrevPage();
};
//---------------------------------------------------------------------------
extern PACKAGE TMasterExportForm *MasterExportForm;
//---------------------------------------------------------------------------
#endif
