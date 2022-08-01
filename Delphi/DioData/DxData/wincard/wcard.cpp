//---------------------------------------------------------------------------

#include <vcl.h>
#include "windrvr.h"
#pragma hdrstop
USERES("wcard.res");
USEFORM("wcrd.cpp", Form1);
//---------------------------------------------------------------------------
    void RegisterWinDriver()
    {
        HANDLE hWD;
        WD_LICENSE lic;

        hWD = WD_Open();
        if (hWD!=INVALID_HANDLE_VALUE)
        {
            // replace the following string with your license string
            strcpy(lic.cLicense, "68C9BECCEDE89D5060EF8FC5BD1BA552.Warlock//SSG");
            WD_License(hWD, &lic);
            WD_Close(hWD);
        }
    }

WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
 RegisterWinDriver();
        try
        {
                 Application->Initialize();
                 Application->CreateForm(__classid(TForm1), &Form1);
                 Application->Run();
        }
        catch (Exception &exception)
        {
                 Application->ShowException(&exception);
        }
        return 0;
}
//---------------------------------------------------------------------------
