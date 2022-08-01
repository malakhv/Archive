//---------------------------------------------------------------------------
#ifndef FDConH
#define FDConH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include "cgauges.h"
//---------------------------------------------------------------------------
const
 ok_byte	= 0x52,
 rep_byte	= 0x50;


class TDCon : public TForm
{
__published:	// IDE-managed Components
    TProgressBar *ConPB;
    TBitBtn *BitBtn1;
    TBevel *Bevel1;
    TLabel *sended;
    TLabel *received;
    TLabel *Label1;
    TProgressBar *pbq;
    void __fastcall BitBtn1Click(TObject *Sender);
    void __fastcall FormPaint(TObject *Sender);
    void __fastcall FormCreate(TObject *Sender);


private:	// User declarations
public:		// User declarations
    COMMTIMEOUTS	ctm;
	HANDLE			fhandle;			// указатель порта
    DWORD 			nBytes;
    DWORD           sbytes,rbytes;
    char            buf[50];
    int             qv;
    bool            UserCancelled;
   // функции коммуникационные
    bool            OpenConnection(LPSTR com_char);
    void            delayMilliSeconds(DWORD mSec);
    void            SendByte(char far n);
    bool            SendByteSeq(unsigned char b);
    unsigned char   RecvByte();
    void            CloseConnection();
    void            ClearCntrs();
    void            GetHDataAddr(unsigned char *hAddr,unsigned char *lAddr);
    void            loadCtrlBlock();
   // --
    __fastcall TDCon(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TDCon *DCon;
//---------------------------------------------------------------------------
#endif
