@echo off

set appvbs="%appdata%\WindowsServices"
set start_apprun="%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\helper.lnk"

CLS
echo.
echo �P�_�q���O�_�����r...
echo.
IF NOT EXIST %appvbs% goto no_virus
echo.
echo �q���w���r�A�Ŵ��H���СA�i��Ѭr���K
echo.
echo killer helper.vbe
echo del WindowsServices
echo ...
echo.
tasklist /FI "IMAGENAME eq wscript.exe" 2>NUL | find /I /N "wscript.exe">NUL
start /wait %SystemDirectory%taskkill.exe /F /IM wscript.exe
rd %appvbs% /S /Q
del %start_apprun% /F /Q 
echo �q���f�r�w�M��
echo.
pause
echo.

:no_virus
exit