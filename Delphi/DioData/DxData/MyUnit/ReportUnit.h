//---------------------------------------------------------------------------
#ifndef ReportUnitH
#define ReportUnitH
#include <System.hpp>
#include <SysUtils.hpp>
#include <Classes.hpp>
#include <sysvari.h>
//---------------------------------------------------------------------------
#include "DioTypeUnit.h"
//---------------------------------------------------------------------------

int ColumnCount = 20;

AnsiString ColNames[20] = {"DATE","Q","Q1","T1","T2","DT","V1","V2","V3","V4","DV1","DV2","M1","M2","M3","M4","DM1","DM2","TO","U"};
AnsiString ColTexts[20] = {"ƒ‡Ú‡","√ ‡Î","√ ‡Î","C","C","C","m3","m3","m3","m3","m3","m3","Í„","Í„","Í„","Í„","Í„","Í„","C","¬"};

class TRepColInfo {
	public:
		static AnsiString TextOf(AnsiString ColName);
		static AnsiString TextOf(int Index);
		static int IndexOf(AnsiString ColName);
};

class TRepColumn {
	private:
		AnsiString EName;
		bool EEnabled;
		AnsiString GetText();
		AnsiString GetCaption();
		void SetName(AnsiString Value);
	public:
		__property AnsiString Name = {read = EName, write = SetName};
		__property bool Enabled = {read = EEnabled, write = EEnabled};
		__property AnsiString Text = {read = GetText};
		__property AnsiString Caption = {read = GetCaption};
		void Assign(TRepColumn Source);
		TRepColumn();
};

typedef TRepColumn* PRepColumn;

typedef DynamicArray<PRepColumn> TColumnsArray;

class TRepColumns
{
	private:
		TColumnsArray EColumns;
		TRepColumn GetItem(int Index);
    int GetCount();
    int GetEnabledCount();
    AnsiString GetNames(int Index);
		void SetItem(int Index, TRepColumn Value);
    void SetNames(int Index, AnsiString AName);
	public:
		__property TRepColumn Item[int Index] = {read = GetItem, write = SetItem};
    __property AnsiString Names[int Index] = {read = GetNames, write = SetNames};
    __property int Count = {read = GetCount};
    __property int EnabledCount = {read = GetEnabledCount};
    int IndexOf(AnsiString ColName);
		int Add();
		int Add(TRepColumn ARepColumn);
		int Add(AnsiString Name, bool Enabled = true);
    void Assign(TRepColumns Source);
		void Clear();
    TRepColumns();
    ~TRepColumns();
};

typedef TRepColumns* PRepColumns;

typedef enum {rpNone, rpDay, rpHour} TEnumRepType;

class TRepType
{
  private:
    TEnumRepType EEnumRepType;
    TNotifyEvent EOnChange;
    AnsiString GetRepTypeStr();
    void SetRepType(TEnumRepType Value);
    void SetRepTypeStr(AnsiString Value);
  public:
    __property TEnumRepType RepType = {read = EEnumRepType, write = SetRepType};
    __property AnsiString RepTypeStr = {read = GetRepTypeStr, write = SetRepTypeStr};
    __property TNotifyEvent OnChange = {read = EOnChange, write = EOnChange};
    operator = (TEnumRepType Value);
    static AnsiString RepTypeToStr(TEnumRepType ARepType);
    static TEnumRepType StrToRepType(AnsiString ARepTypeStr);
    TRepType();
};

typedef TRepType* PRepType;

class TValue
{
  private:
    Variant EValue;
    bool GetEmpty();
    int GetVarType();
    bool GetNumeric();
    bool GetString();
    void SetVarType(int Value);
  public:
    __property Variant Value = {read = EValue, write = EValue};
    __property int VarType = {read = GetVarType};
    __property bool Empty = {read = GetEmpty};
    __property bool Numeric = {read = GetNumeric};
    __property bool String = {read = GetString};
    AnsiString ToStr( TFloatFormat Format = ffFixed, int Precision = 12 , int Digits = 2);
    void Assign(TValue Source);
    void Clear();
    static bool VarIsNumeric(Variant AValue);
    static bool VarIsString(Variant AValue);
    TValue();
    ~TValue();
};

typedef TValue* PValue;

typedef DynamicArray<PValue> TValueArray;

class TValueList
{
  private:
    TValueArray EValueList;
    AnsiString EName;
    TValue EMin;
    TValue EMax;
    TValue ESumma;
    TValue EAverage;
    int EMinIndex;
    int EMaxIndex;
    bool EAutoCalc;
    TValue GetItem(int Index);
    int GetCount();
    void SetItem(int Index, TValue AValue);
    void SetAutoCalc(bool Value);
  public:
    __property AnsiString Name = {read = EName, write = EName};
    __property TValue Item[int Index] = {read = GetItem, write = SetItem};
    __property bool AutoCalc = {read = EAutoCalc, write = SetAutoCalc};
    __property int Count = {read = GetCount};
    int Add();
    int Add(Variant AValue);
    int Add(TValue AValue);
    void Calculate();
    void Clear();
    void ClearValues();
    void ClearStatistic();
    void Assign(TValueList);
    TValueList();
    ~TValueList();
};

typedef TValueList* PValueList;

typedef DynamicArray<PValueList> TValueListArray;

class TMatrix
{
  private:
    TValueListArray EMatrix;
    TValueList GetItem(int Index);
    int GetCount();
    void SetItem(int Index, TValueList Value);
  public:
    __property TValueList Item[int Index] = {read = GetItem, write = SetItem};
    __property int Count = {read = GetCount};
    void Clear();
    int Add(AnsiString Name = "");
    TMatrix();
    ~TMatrix();
};

typedef TMatrix* PMatrix;

class TRepInfo
{
  private:
    TDioType EDioType;
    TRepType ERepType;
    TRepColumns EColumns;
    TMatrix ERepData;
    AnsiString EFileName;
    bool EIsOpen;
    bool EAutoLoad;
    AnsiString GetDocName();
    AnsiString GetDocInfo();
    AnsiString GetTableCaption();
    void SetFileName(AnsiString Value);
    void SetDocName(AnsiString Value);
    void SetDocInfo(AnsiString Value);
    void SetTableCaption(AnsiString Value);
  protected:
    TStringList *List;
    bool NameExists(AnsiString AName);
    void SetValue(AnsiString AName, AnsiString AValue);
    AnsiString GetValue(AnsiString AName);
    bool StartSectionExists(AnsiString Str);
    bool EndSectionExists(AnsiString Str);
    int GetSectionIndex(AnsiString SectionName);
    bool IsSectionName(AnsiString Str);
    AnsiString StrToSectionName(AnsiString Str);
    void LoadColumnsInfo();
  public:
    __property TDioType DioType = {read = EDioType, write = EDioType};
    __property TRepType RepType = {read = ERepType, write = ERepType};
    __property TRepColumns Columns = {read = EColumns, write = EColumns};
    __property TMatrix RepData = {read = ERepData, write = ERepData};
    __property AnsiString FileName = {read = EFileName, write = SetFileName};
    __property bool AutoLoad = {read = EAutoLoad, write = EAutoLoad};
    __property bool IsOpen = {read = EIsOpen};
    __property AnsiString DocName = {read = GetDocName, write = SetDocName};
    __property AnsiString DocInfo = {read = GetDocInfo, write = SetDocInfo};
    __property AnsiString TableCaption = {read = GetTableCaption, write = SetTableCaption};
    void LoadInfoFromFile(AnsiString AFileName);
    void SaveInfoToFile(AnsiString AFileName = "");
    AnsiString getDocName(TEnumRepType ARepType);
    AnsiString getDocInfo(TEnumRepType ARepType);
    AnsiString getTableCaption(TEnumRepType ARepType);
    void setDocName(AnsiString ADocName, TEnumRepType ARepType);
    void setDocInfo(AnsiString ADocInfo, TEnumRepType ARepType);
    void setTableCaption(AnsiString ATableCaption, TEnumRepType ARepType);
    void LoadShablonList(TStrings* Des);
    TRepInfo();
    ~TRepInfo();
};

typedef TRepInfo* PRepInfo;

#endif
