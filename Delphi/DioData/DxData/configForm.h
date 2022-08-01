//---------------------------------------------------------------------------

#ifndef configFormH
#define configFormH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <FileCtrl.hpp>
#include "cdiroutl.h"
#include <Grids.hpp>
#include <Outline.hpp>
//---------------------------------------------------------------------------
typedef struct configFile
{
  char  dataDir[160];
  char  res1[160];
} TconfigFile;


class Tconfig : public TForm
{
__published:	// IDE-managed Components
        TPageControl *PageControl1;
        TTabSheet *TabSheet1;
        TButton *Button1;
        TEdit *dpe;
        TLabel *Label1;
        TDirectoryListBox *DirectoryListBox1;
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall DirectoryListBox1Change(TObject *Sender);
        void __fastcall DirectoryListBox1Click(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall Tconfig(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tconfig *config;
//---------------------------------------------------------------------------
#endif
