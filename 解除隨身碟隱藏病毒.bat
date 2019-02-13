@ECHO OFF

set appvbs="%appdata%\WindowsServices"
set start_apprun="%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\helper.lnk"

:start_menu
CLS
echo.
echo ==========================
echo * USB 隱藏式病毒清除程式 *
echo ==========================
echo *                        *
echo * 1. 自動清除(執行2+3)   *
echo *                        *
echo * 2. 清除電腦病毒        *
echo *                        *
echo * 3. 清除USB中毒         *
echo *    -------------       *
echo * 4. 安裝防疫軟體        *
echo *    -------------       *
echo * 5. 離開                *
echo *                        *
echo ==========================
echo * 本程式限helper.vbs病毒 *
echo * 病徵:USB檔案消失剩連結 *
echo * ---------------------- *
echo * paul@ezpo.net  ver:2.0 *
echo ==========================
echo.

set /p itemList="請輸入 1-5 動作> "
echo. 
echo. 
if %itemList% == 1 goto AutoCleanVirus
if %itemList% == 2 goto CleanPC
if %itemList% == 3 goto CleanUSB
if %itemList% == 4 goto SetupCV
if %itemList% == 5 goto exitBye
echo.
echo 指令錯誤，請重新輸入！
echo.
pause
cls
goto start_menu

:AutoCleanVirus
IF EXIST %appvbs% goto CleanPC
goto CleanUSB

:CleanPC
CLS
echo.
echo 判斷電腦是否有中毒...
echo.
IF NOT EXIST %appvbs% goto no_virus
tasklist /FI "IMAGENAME eq wscript.exe" 2>NUL | find /I /N "wscript.exe">NUL
start /wait %SystemDirectory%taskkill.exe /F /IM wscript.exe
rd %appvbs% /S /Q
del %start_apprun% /F /Q 
echo 電腦病毒已清除
echo.
pause
echo.
IF %itemList% == 1 goto AutoCleanVirus
goto start_menu

:no_virus
echo.
echo 偵測後沒有中毒!或中毒的類型不是helper.vbs
echo.
pause
goto start_menu

:SetupCV
echo.
echo 安裝防疫軟體
echo.
xcopy /y /q "%CD%\隨身碟隱藏病毒防疫.bat" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\"
echo.
echo 安裝成功！
echo.
pause
goto start_menu

:CleanUSB
echo.
set /p U_Drive="請輸入你的隨身碟代碼(只需輸入英文): "
echo.
echo 判斷USB是否有中毒
echo.
set USBDrive=%U_Drive%:"
cd /d "%USBDrive%"
IF "%CD%" == "%UserProfile%\Desktop" goto errDrive
IF not exist "%CD%\WindowsServices" goto no_virus


echo.
echo 開始清除病毒，請稍待片刻! 勿關機或拔除USB隨身碟
echo.

:try1
echo.
echo 正在試著將檔案還原到隨身碟
echo.
robocopy _\ . /move /e
if errorlevel 1 goto try2
goto usbCleanVirus

:try2
echo.
echo 警告！磁碟機已滿或發生其它錯誤
echo 正在試著將檔案備份到本機
mkdir "%temp%\usb_backup"
robocopy _\ "%temp%\usb_backup\" /move /e
if errorlevel 1 goto try3
goto usbCleanVirus

:try3
echo.
rd "%temp%\usb_backup\" /S /Q 
echo 備份失敗，請洽GOOGLE大神
echo 關鍵字: helper.vbs 病毒
echo.
goto exitBye

:errDrive
cls
echo.
echo.
echo 隨身碟代碼錯誤，請重新輸入，只需輸入一個英文字!
echo.
echo 如 E:\ 只需要輸入 E ... F:\ 只需要輸入 F
echo.
pause
cls
goto CleanUSB

:usbCleanVirus
echo.
echo 檔案還原完成!
echo.
echo ====================
echo.
rd "%CD%\WindowsServices" /S /Q 
rd "%CD%\_" /S /Q 
del "*.lnk" /F /Q 
echo.
echo 病毒清除完成,請正常移除隨身磁~
echo.

:exitBye
echo.
echo 程式即將結束，謝謝！
echo.
pause
echo.
exit