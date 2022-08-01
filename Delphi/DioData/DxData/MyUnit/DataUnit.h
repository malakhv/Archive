//---------------------------------------------------------------------------

#ifndef DataUnitH
#define DataUnitH
#include <System.hpp>
//---------------------------------------------------------------------------
typedef struct dtopConfig {
  bool bandsBreak[10];
  int gh;
} TdtopConfig;

typedef struct fnRec {
  AnsiString fn;
} TfnRec;

typedef TfnRec* PfnRec;

typedef struct fDescript {
  char addr[200];
  char owner[200];
  char res01[500];
  char res02[500];
} TfDescript;

typedef TfDescript* pfDescript;

// структура для описания приборов.. сохраняется в отдельном файле от данных
typedef struct devARec {
  unsigned int sNum;
  AnsiString devAbout;
} TdevARec;

typedef TdevARec* PdevARec;

typedef struct HData {
  AnsiString dt;
  byte   hr;
  float  Q,Q1,t1,t2,t3,t4,V1,V2,V3,V4,V5,ta,Ubat;
} THData;

typedef THData* PHData;

typedef struct HDataSL {
  char dt[12];
  byte   hr;
  float  Q,Q1,t1,t2,t3,t4,V1,V2,V3,V4,V5,ta,Ubat;
} THDataSL;

typedef THDataSL* PHDataSL;

typedef struct CSData {
  byte refComboIndex;
  byte sysCfg;
  float  Q,Q1,t1,t2,t3,t4,V1,V2,V3,V4,V5,m1,m2,m3,m4,ta,bs;
  unsigned int hrs,snum;
  byte ErrCd;
  byte dioType;
  float  k1,k2,k3,k4,k5;
  TDateTime  archCompDate;
} TCSData;

typedef TCSData* PCSData;
#endif
