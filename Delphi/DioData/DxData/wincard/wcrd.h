#ifndef wcrdH
#define wcrdH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <CheckLst.hpp>
#include <ComCtrls.hpp>
#include <Buttons.hpp>
#include "CGAUGES.h"
//---------------------------------------------------------------------------
#define dio3T3V 0xaa
#define dio2T4V 0xff
#define dio4T4V 0xa8

typedef struct CInfoStruct {
 UCHAR icCount;
 UCHAR dioType;
}TCInfoStruct;

        class TcardMan : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TButton *getDataBtn;
        TButton *Button2;
        TComboBox *devList;
        TCGauge *pb1;
        TLabel *pName;
        TButton *Button1;
        TButton *Button3;
        TCheckBox *toDayData;
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall getDataBtnClick(TObject *Sender);
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall FormPaint(TObject *Sender);
        void __fastcall Button2Click(TObject *Sender);
        void __fastcall Button3Click(TObject *Sender);
        void __fastcall devListChange(TObject *Sender);
private:
public:		// User declarations
        UCHAR eData[32768];
        TCInfoStruct cardInfo;
        __fastcall TcardMan(TComponent* Owner);
         void getCardInfo(void);
        bool eDataValid;
};
//---------------------------------------------------------------------------
extern PACKAGE TcardMan *cardMan;
//---------------------------------------------------------------------------
#endif
