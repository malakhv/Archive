//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "configForm.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cdiroutl"
#pragma resource "*.dfm"
Tconfig *config;
//---------------------------------------------------------------------------
__fastcall Tconfig::Tconfig(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall Tconfig::Button1Click(TObject *Sender)
{
 Close();        
}
//---------------------------------------------------------------------------
void __fastcall Tconfig::DirectoryListBox1Change(TObject *Sender)
{
 dpe->Text=DirectoryListBox1->Directory;
}
//---------------------------------------------------------------------------
void __fastcall Tconfig::DirectoryListBox1Click(TObject *Sender)
{
 dpe->Text=DirectoryListBox1->Directory;
}
//---------------------------------------------------------------------------
void __fastcall Tconfig::FormActivate(TObject *Sender)
{
 dpe->Text=DirectoryListBox1->Directory;
}
//---------------------------------------------------------------------------
