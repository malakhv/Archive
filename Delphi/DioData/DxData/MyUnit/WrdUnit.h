//---------------------------------------------------------------------------

#ifndef WrdUnitH
#define WrdUnitH
//---------------------------------------------------------------------------
#include <ComObj.hpp>
#include <sysvari.h>
#include "DataUnit.h"

class TWordApp
{
  private:
    Variant EWordApp;
    Variant EDocuments;
    Variant ESelection;
    Variant EFind;
    Variant Tables;
    Variant DataTable;
    bool ETerminateAppOnFree;
    void SetVisible(bool Value);
    bool GetVisible();
    int GetDocCount();
    Variant GetActiveDocument();
    Variant GetSelectionRange();
    void SetSelectionRange(Variant Value);
  public:
    __property bool Visible = { read = GetVisible, write = SetVisible};
    __property bool TerminateAppOnFree = { read = ETerminateAppOnFree, write = ETerminateAppOnFree};
    __property int DocCount = {read = GetDocCount};
    __property Variant ActiveDocument = {read = GetActiveDocument};
    __property Variant SelectionRange = {read = GetSelectionRange, write = SetSelectionRange};
    bool CreateWordApp(bool LoadDocs = true);
    void WordAppClose();
    bool AddDocument(AnsiString DocPath = "");
    Variant AddTable(Variant Range, int ColCount, int RowCount);
    bool SaveDocument(AnsiString FileName, AnsiString ReadPswrd = "", AnsiString WritePswrd = "");
    bool FindAndReplace(AnsiString FindText, AnsiString NewText);
    bool Find(AnsiString FindText);
    bool IsEmpty(Variant Value);
    void AddStaticInfo(CSData data);
    void SetTableBorder(Variant ATable);
    __fastcall TWordApp(bool AutoCreate);
    __fastcall ~TWordApp();
};
#endif
