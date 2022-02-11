@REM The script for make a content.dat file for BeerHub app
@REM Author: Mikhail.Malakhov

rd /S /Q "out"

mkdir out
mkdir out\tmp

copy beer_hub_1.0.db out\tmp\data.db

robocopy data\ out\tmp /e /copyall


call "tools\win\time.bat" time_str
echo build=%username% %date% %time_str% >> out\tmp\meta


tools\win\7z.exe a out\content.zip .\out\tmp\*

tools\win\crypto.exe -e out\content.zip out\content.dat

rd /S /Q "out\tmp"

:: del /f /q "out\content.zip"