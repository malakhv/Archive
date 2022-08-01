//---------------------------------------------------------------------------
#ifndef DirSelectH
#define DirSelectH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cdiroutl.h"
#include <Grids.hpp>
#include <Outline.hpp>
//---------------------------------------------------------------------------
class Tods : public TForm
{
__published:	// IDE-managed Components
    TCDirectoryOutline *CDirectoryOutline1;
    TButton *Button1;
    void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
    __fastcall Tods(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tods *ods;
//---------------------------------------------------------------------------
#endif
 