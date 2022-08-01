//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "dstgs.h"
#include "dirselect.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
Tstgs *stgs;
//---------------------------------------------------------------------------
__fastcall Tstgs::Tstgs(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall Tstgs::Button1Click(TObject *Sender)
{
  int fh;

  if(FileExists("config.dmx"))
    DeleteFile("config.dmx");
   fh=FileCreate("config.dmx");
   FileWrite(fh,mainDir->Text.c_str(),mainDir->Text.Length());
   FileWrite(fh,"\n",1);
   FileWrite(fh,(eachNumDir->Checked==false)?"0\n":"1\n",2);
   FileWrite(fh,(saveBeforeExit->Checked==false)?"0\n":"1\n",2);
   FileClose(fh);
    Close();
}
//---------------------------------------------------------------------------
void __fastcall Tstgs::Button2Click(TObject *Sender)
{
   ods->ShowModal();
    mainDir->Text=GetCurrentDir();
}
//---------------------------------------------------------------------------
void __fastcall Tstgs::Button3Click(TObject *Sender)
{
 fntd->Execute();
 FName->Text=fntd->Font->Name+","+IntToStr(fntd->Font->Size);
}
//---------------------------------------------------------------------------

void __fastcall Tstgs::FormActivate(TObject *Sender)
{
  int fh;
  int iFileLength;
  int iBytesRead;
  char *pszBuffer;

  if(FileExists("config.dmx"))
  {
   fh=FileOpen("config.dmx",fmOpenRead);
      FileSeek(fh,0,0);
      pszBuffer = new char[iFileLength+1];
      iBytesRead = FileRead(fh, pszBuffer, iFileLength);

   FileClose(fh);
   delete [] pszBuffer;
  }

 FName->Text=fntd->Font->Name+","+IntToStr(fntd->Font->Size);
}

