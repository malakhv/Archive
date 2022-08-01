//---------------------------------------------------------------------------
#include <vcl.h>
#include "windrvr.h"
#include "abf.h"
#include "dmf.h"
#pragma hdrstop
USEFORM("ddata.cpp", Form1);
USEFORM("DCon\FDCon.cpp", DCon);
USEFORM("cvrep.cpp", cValsRep);
USEFORM("cVals\cVals.cpp", cfVals);
USEFORM("dtp1.cpp", dtPreview);
USEFORM("SetIvl.cpp", setIvlFrm);
USEFORM("dfr.cpp", DF);
USEFORM("prdIvlSet.cpp", prnIvl);
USEFORM("hrRep.cpp", hrPreview);
USEFORM("sMessage\sMessage.cpp", sMsg);
USEFORM("abf.cpp", aboutForm);
USEFORM("dmf.cpp", dampForm);
USEFORM("hr44.cpp", hrPreview44);
USEFORM("dtp4.cpp", dtPreview44);
USEFORM("configForm.cpp", config);
USEFORM("devD.cpp", devDescr);
USEFORM("dtp3.cpp", dtPreview33);
USEFORM("wincard\wcrd.cpp", cardMan);
USEFORM("ExportMaster\ExportMasterUnit.cpp", MasterExportForm);
USEFORM("ExportMaster\ExportProgresUnit.cpp", ExportProgresForm);
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
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR t, int)
{
 RegisterWinDriver();
    try
    {
        Application->Initialize();
        Application->Title = "Архив показаний DIO-99M";
                 Application->CreateForm(__classid(TForm1), &Form1);
     Application->CreateForm(__classid(TDCon), &DCon);
     Application->CreateForm(__classid(TcValsRep), &cValsRep);
     Application->CreateForm(__classid(TcfVals), &cfVals);
     Application->CreateForm(__classid(TdtPreview), &dtPreview);
     Application->CreateForm(__classid(TsetIvlFrm), &setIvlFrm);
     Application->CreateForm(__classid(TDF), &DF);
     Application->CreateForm(__classid(TprnIvl), &prnIvl);
     Application->CreateForm(__classid(ThrPreview), &hrPreview);
     Application->CreateForm(__classid(TsMsg), &sMsg);
     Application->CreateForm(__classid(TaboutForm), &aboutForm);
     Application->CreateForm(__classid(TdampForm), &dampForm);
     Application->CreateForm(__classid(ThrPreview44), &hrPreview44);
     Application->CreateForm(__classid(TdtPreview44), &dtPreview44);
     Application->CreateForm(__classid(Tconfig), &config);
     Application->CreateForm(__classid(TdevDescr), &devDescr);
     Application->CreateForm(__classid(TdtPreview33), &dtPreview33);
     Application->CreateForm(__classid(TcardMan), &cardMan);
     Application->CreateForm(__classid(TExportProgresForm), &ExportProgresForm);
     Application->CreateForm(__classid(TMasterExportForm), &MasterExportForm);
     if(strcmp(t,"dump")==0) {
                        dampForm->Show();
                        dampForm->Update();
                       }
                 Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
