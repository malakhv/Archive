//---------------------------------------------------------------------------
#ifndef cValsH
#define cValsH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <quickrpt.hpp>
#include <Grids.hpp>
//---------------------------------------------------------------------------
class TcfVals : public TForm
{
__published:	// IDE-managed Components
    TButton *Button1;
    TButton *cValsPrint;
        TStringGrid *iGrid;
    void __fastcall Button1Click(TObject *Sender);
    void __fastcall FormActivate(TObject *Sender);

    void __fastcall cValsPrintClick(TObject *Sender);
    
    
    
    
private:	// User declarations
public:		// User declarations
    float   q1,q2,t1,t2,t3,t4,k1,k2,k3,k4,v1,v2,v3,v4,m1,m2,bs,ta;
    unsigned char ErrCd,dioType;
    int hrs,snum;
    __fastcall TcfVals(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TcfVals *cfVals;
//---------------------------------------------------------------------------
#endif
