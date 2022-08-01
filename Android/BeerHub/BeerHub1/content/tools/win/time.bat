@REM Print a current time in format HH:MM:SS
@REM Author: Mikhail.Malakhov

@ECHO OFF

set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%

set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%

set secs=%time:~6,2%
if "%secs:~0,1%" == " " set secs=0%secs:~1,1%

set t=%hour%:%min%:%secs%

set "%~1=%t%"
