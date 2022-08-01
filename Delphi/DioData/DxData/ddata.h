//---------------------------------------------------------------------------
#ifndef ddataH
#define ddataH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Grids.hpp>
#include <ComCtrls.hpp>
#include <Menus.hpp>
#include <ToolWin.hpp>
#include <Chart.hpp>
#include <ExtCtrls.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
#include <Series.hpp>
#include <Dialogs.hpp>
#include <Db.hpp>
#include <DBTables.hpp>
#include <DBGrids.hpp>
#include <Tabs.hpp>
#include <Tabnotbk.hpp>
#include <Buttons.hpp>
#include <ImgList.hpp>
#include <Graphics.hpp>
#include "DataUnit.h"
/*
typedef struct dtopConfig
{
        bool bandsBreak[10];
        int gh;
} TdtopConfig;

typedef struct fnRec
{
  AnsiString fn;
} TfnRec;
typedef TfnRec* PfnRec;

typedef struct fDescript
{
  char addr[200];
  char owner[200];
  char res01[500];
  char res02[500];
} TfDescript;
typedef TfDescript* pfDescript;


// структура для описания приборов.. сохраняется в отдельном файле от данных
typedef struct devARec
{
  unsigned int sNum;
  AnsiString devAbout;
} TdevARec;
typedef TdevARec* PdevARec;

typedef struct HData {
public:
 AnsiString dt;
 byte   hr;
 float  Q,Q1,t1,t2,t3,t4,V1,V2,V3,V4,V5,ta,Ubat;
}THData;

typedef struct HDataSL {
public:
 char dt[12];
 byte   hr;
 float  Q,Q1,t1,t2,t3,t4,V1,V2,V3,V4,V5,ta,Ubat;

}THDataSL;

typedef THData* PHData;
typedef THDataSL* PHDataSL;

typedef struct CSData {
public:
 byte refComboIndex;
 byte sysCfg;
 float  Q,Q1,t1,t2,t3,t4,V1,V2,V3,V4,V5,m1,m2,m3,m4,ta,bs;
 unsigned int hrs,snum;
 byte ErrCd;
 byte dioType;
 float  k1,k2,k3,k4,k5;
 TDateTime  archCompDate;
}TCSData;

typedef TCSData* PCSData;  */
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
    TMainMenu *MainMenu1;
    TMenuItem *N1;
    TMenuItem *N4;
    TMenuItem *N5;
    TMenuItem *N6;
    TToolBar *tb1;
    TToolButton *ToolButton1;
    TToolButton *ToolButton2;
    TToolButton *ToolButton3;
    TStatusBar *sb1;
    TImageList *ImageList1;
    TToolButton *csb;
    TToolButton *ToolButton6;
    TToolBar *ToolBar2;
    TComboBox *DSel;
    TComboBox *RefCombo;
    TToolButton *ToolButton8;
    TToolButton *ToolButton9;
    TToolButton *ToolButton10;
    TLabel *Label1;
    TToolButton *ToolButton11;
    TToolButton *ToolButton12;
    TSaveDialog *sd;
    TPopupMenu *comsel;
    TMenuItem *COM11;
    TMenuItem *COM21;
    TMenuItem *COM31;
    TMenuItem *COM41;
    TMenuItem *N2;
    TMenuItem *COM12;
    TMenuItem *COM22;
    TMenuItem *COM32;
    TMenuItem *COM42;
    TMenuItem *N3;
    TMenuItem *N8;
    TMenuItem *N9;
    TMenuItem *N10;
    TToolButton *ToolButton5;
    TMenuItem *N11;
    TMenuItem *N13;
    TPrintDialog *pd1;
    TMenuItem *N15;
    TToolButton *FileOpenButton;
    TOpenDialog *od;
    TMenuItem *N16;
    TCoolBar *cbar;
    TPanel *Panel1;
    TPanel *cdiPanel;
    TMenuItem *N7;
    TMenuItem *N17;
    TPanel *Panel2;
    TTreeView *dtTree;
        TToolButton *bkBut;
        TToolButton *fwBut;
        TToolButton *ToolButton13;
        TToolButton *ToolButton14;
        TCoolBar *CoolBar1;
        TToolButton *ToolButton4;
        TLabel *dtl;
        TMenuItem *abf;
        TLabel *LabelUrl;
        TPopupMenu *qaPopup;
        TMenuItem *N12;
        TMenuItem *N18;
        TMenuItem *showDescript;
        TMenuItem *A1;
        TMenuItem *N19;
        TSpeedButton *SpeedButton1;
        TStringGrid *iGrid;
  TMenuItem *N14;
  TMenuItem *mnMSWordExprt;
  TSaveDialog *SaveDialog;
  TToolButton *btnWordExport;
  TToolButton *ToolButton7;
    void __fastcall ToolButton2Click(TObject *Sender);
    
    
    void __fastcall RefComboChange(TObject *Sender);
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
    void __fastcall DSelChange(TObject *Sender);
    void __fastcall FormActivate(TObject *Sender);
    
    void __fastcall ToolButton8Click(TObject *Sender);
    
    
    void __fastcall ToolButton1Click(TObject *Sender);
    void __fastcall N4Click(TObject *Sender);
    void __fastcall csbClick(TObject *Sender);
    void __fastcall COM11Click(TObject *Sender);
    void __fastcall COM21Click(TObject *Sender);
    void __fastcall COM31Click(TObject *Sender);
    void __fastcall COM41Click(TObject *Sender);
    void __fastcall comselPopup(TObject *Sender);
    void __fastcall N6Click(TObject *Sender);
    
    void __fastcall N2Click(TObject *Sender);
    
    void __fastcall COM12Click(TObject *Sender);
    void __fastcall COM22Click(TObject *Sender);
    void __fastcall COM32Click(TObject *Sender);
    void __fastcall COM42Click(TObject *Sender);
    void __fastcall N8Click(TObject *Sender);

    void __fastcall ToolButton5Click(TObject *Sender);
    void __fastcall N10Click(TObject *Sender);
    void __fastcall abfClick(TObject *Sender);
    void __fastcall N15Click(TObject *Sender);

    void __fastcall FileOpenButtonClick(TObject *Sender);
    
    void __fastcall N16Click(TObject *Sender);
    void __fastcall N17Click(TObject *Sender);
    
    void __fastcall dtTreeDblClick(TObject *Sender);
        void __fastcall bkButClick(TObject *Sender);
        void __fastcall fwButClick(TObject *Sender);
        void __fastcall ToolButton13Click(TObject *Sender);
        void __fastcall ToolButton4Click(TObject *Sender);
        void __fastcall LabelUrlClick(TObject *Sender);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
        void __fastcall N12Click(TObject *Sender);
        void __fastcall qaPopupPopup(TObject *Sender);
        void __fastcall A1Click(TObject *Sender);
        void __fastcall SpeedButton1Click(TObject *Sender);
        void __fastcall N13Click(TObject *Sender);
        void __fastcall showDescriptClick(TObject *Sender);
  void __fastcall mnMSWordExprtClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
    dtopConfig cf;
    bool    coolBarOpened;
    bool    allSaved;
    float   oldt1,oldt2,oldt3,oldt4;

    float far Dec_2_Float(unsigned char ex,unsigned char a1,unsigned char a2,
                        unsigned char a3);
    void  Float_2_Dec(float iee);
    void  UpdateHGrid();
    void  ClearHData();
    void  UpdateGraps();
    void  storePHDataL(PHData astr,unsigned char *recvBuf);
    void  storePHDataH(PHData astr,unsigned char *recvBuf);
    __fastcall TForm1(TComponent* Owner);
    void  SortListByDate(void);
    bool  getCSData(PCSData as); // извлекает интеграторы
    void  updateCoolBar();
    void  updateDtTree();
    void  addFileToTree(AnsiString fn);
    void  loadFile(AnsiString fn);
    int   findDate(TDateTime dt);
        saveConfig();
        loadConfig();
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
