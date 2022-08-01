unit OSMPInt;

interface

type

  TOSMPWrkProg = procedure (AFileName, AMsg: PChar; WrkResult: boolean = true);

  TOSMPWork = function (AppDir, SiteDir: PChar; IsCopy: boolean = false;
    OSMPWrkProg: TOSMPWrkProg = nil): boolean; StdCall;

implementation

end.
