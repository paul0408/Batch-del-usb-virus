@echo off

set appvbs="%appdata%\WindowsServices"
set start_apprun="%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\helper.lnk"

CLS
echo.
echo 判斷電腦是否有中毒...
echo.
IF NOT EXIST %appvbs% goto no_virus
echo.
echo 電腦已中毒，勿插隨身碟，進行解毒中…
echo.
echo killer helper.vbe
echo del WindowsServices
echo ...
echo.
tasklist /FI "IMAGENAME eq wscript.exe" 2>NUL | find /I /N "wscript.exe">NUL
start /wait %SystemDirectory%taskkill.exe /F /IM wscript.exe
rd %appvbs% /S /Q
del %start_apprun% /F /Q 
echo 電腦病毒已清除
echo.
pause
echo.

:no_virus
exit