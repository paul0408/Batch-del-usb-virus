@ECHO OFF

set appvbs="%appdata%\WindowsServices"
set start_apprun="%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\helper.lnk"

:start_menu
CLS
echo.
echo ==========================
echo * USB ���æ��f�r�M���{�� *
echo ==========================
echo *                        *
echo * 1. �۰ʲM��(����2+3)   *
echo *                        *
echo * 2. �M���q���f�r        *
echo *                        *
echo * 3. �M��USB���r         *
echo *    -------------       *
echo * 4. �w�˨��̳n��        *
echo *    -------------       *
echo * 5. ���}                *
echo *                        *
echo ==========================
echo * ���{����helper.vbs�f�r *
echo * �f�x:USB�ɮ׮����ѳs�� *
echo * ---------------------- *
echo * paul@ezpo.net  ver:2.0 *
echo ==========================
echo.

set /p itemList="�п�J 1-5 �ʧ@> "
echo. 
echo. 
if %itemList% == 1 goto AutoCleanVirus
if %itemList% == 2 goto CleanPC
if %itemList% == 3 goto CleanUSB
if %itemList% == 4 goto SetupCV
if %itemList% == 5 goto exitBye
echo.
echo ���O���~�A�Э��s��J�I
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
echo �P�_�q���O�_�����r...
echo.
IF NOT EXIST %appvbs% goto no_virus
tasklist /FI "IMAGENAME eq wscript.exe" 2>NUL | find /I /N "wscript.exe">NUL
start /wait %SystemDirectory%taskkill.exe /F /IM wscript.exe
rd %appvbs% /S /Q
del %start_apprun% /F /Q 
echo �q���f�r�w�M��
echo.
pause
echo.
IF %itemList% == 1 goto AutoCleanVirus
goto start_menu

:no_virus
echo.
echo ������S�����r!�Τ��r���������Ohelper.vbs
echo.
pause
goto start_menu

:SetupCV
echo.
echo �w�˨��̳n��
echo.
xcopy /y /q "%CD%\�H�������ïf�r����.bat" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\"
echo.
echo �w�˦��\�I
echo.
pause
goto start_menu

:CleanUSB
echo.
set /p U_Drive="�п�J�A���H���ХN�X(�u�ݿ�J�^��): "
echo.
echo �P�_USB�O�_�����r
echo.
set USBDrive=%U_Drive%:"
cd /d "%USBDrive%"
IF "%CD%" == "%UserProfile%\Desktop" goto errDrive
IF not exist "%CD%\WindowsServices" goto no_virus


echo.
echo �}�l�M���f�r�A�еy�ݤ���! �������Ωް�USB�H����
echo.

:try1
echo.
echo ���b�յ۱N�ɮ��٭���H����
echo.
robocopy _\ . /move /e
if errorlevel 1 goto try2
goto usbCleanVirus

:try2
echo.
echo ĵ�i�I�Ϻо��w���εo�ͨ䥦���~
echo ���b�յ۱N�ɮ׳ƥ��쥻��
mkdir "%temp%\usb_backup"
robocopy _\ "%temp%\usb_backup\" /move /e
if errorlevel 1 goto try3
goto usbCleanVirus

:try3
echo.
rd "%temp%\usb_backup\" /S /Q 
echo �ƥ����ѡA�Ь�GOOGLE�j��
echo ����r: helper.vbs �f�r
echo.
goto exitBye

:errDrive
cls
echo.
echo.
echo �H���ХN�X���~�A�Э��s��J�A�u�ݿ�J�@�ӭ^��r!
echo.
echo �p E:\ �u�ݭn��J E ... F:\ �u�ݭn��J F
echo.
pause
cls
goto CleanUSB

:usbCleanVirus
echo.
echo �ɮ��٭짹��!
echo.
echo ====================
echo.
rd "%CD%\WindowsServices" /S /Q 
rd "%CD%\_" /S /Q 
del "*.lnk" /F /Q 
echo.
echo �f�r�M������,�Х��`�����H����~
echo.

:exitBye
echo.
echo �{���Y�N�����A���¡I
echo.
pause
echo.
exit