@echo off
setlocal EnableExtensions
setlocal EnableDelayedExpansion

:: ============================================================
::  RAJA ACTIVATOR v3.0 - HWID ONLY
::  __________________________________________________________
::  
::  ⚡ One Click Windows Activation
::  ⚡ Auto Detects: 10/11, Home/Pro/Enterprise
::  ⚡ Digital License (HWID) Method
::  ⚡ Permanent Activation
::  __________________________________________________________
::  
::  Support: @priyanshu
::  Instagram: https://www.instagram.com/priyanshu.cfg
:: ============================================================

set "masver=3.11"
set "_act=1"
set "_NoEditionChange=1"
set "_debug=0"

:: ============================================================
::  ENVIRONMENT SETUP
:: ============================================================

set "SysPath=%SystemRoot%\System32"
set "Path=%SystemRoot%\System32;%SystemRoot%;%SystemRoot%\System32\Wbem;%SystemRoot%\System32\WindowsPowerShell\v1.0\"
if exist "%SystemRoot%\Sysnative\reg.exe" (
    set "SysPath=%SystemRoot%\Sysnative"
    set "Path=%SystemRoot%\Sysnative;%SystemRoot%;%SystemRoot%\Sysnative\Wbem;%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\;%Path%"
)

set "ComSpec=%SysPath%\cmd.exe"
set "ps=%SysPath%\WindowsPowerShell\v1.0\powershell.exe"
set "psc=%ps% -nop -c"

:: ============================================================
::  CHECK ADMIN RIGHTS
:: ============================================================

net session >nul 2>&1
if %errorlevel% neq 0 (
    cls
    echo.
    echo ============================================================
    echo   RAJA ACTIVATOR - ADMIN RIGHTS REQUIRED
    echo ============================================================
    echo.
    echo   This script needs Administrator privileges to run.
    echo   Restarting with admin rights...
    echo.
    timeout /t 2 >nul
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: ============================================================
::  CHECK INTERNET CONNECTION
:: ============================================================

ping -n 1 8.8.8.8 >nul 2>&1
if %errorlevel% neq 0 (
    cls
    echo.
    echo ============================================================
    echo   RAJA ACTIVATOR - INTERNET REQUIRED
    echo ============================================================
    echo.
    echo   Please connect to the internet and try again.
    echo.
    echo   Press any key to exit...
    pause >nul
    exit /b
)

:: ============================================================
::  GET WINDOWS VERSION & EDITION (EXACT DETECTION)
:: ============================================================

:: Get Build Number
for /f "tokens=2 delims=[]" %%G in ('ver') do for /f "tokens=2,3,4 delims=. " %%H in ("%%~G") do set "winbuild=%%J"

:: Get Exact Edition Name from Registry
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName 2^>nul') do set "winedition_raw=%%b"

:: Get SKU ID
for /f "skip=2 tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\ProductOptions" /v OSProductPfn 2^>nul') do set "sku=%%a"

:: Detect Windows Version (10 or 11)
set "winver=Windows 10"
if %winbuild% GEQ 22000 set "winver=Windows 11"

:: ============================================================
::  FIX EDITION NAME (EXACT DETECTION)
:: ============================================================

:: If Windows 11, replace "Windows 10" with "Windows 11"
set "winedition=!winedition_raw!"
if %winbuild% GEQ 22000 set "winedition=!winedition_raw:Windows 10=Windows 11!"

:: Detect Edition Type (Home/Pro/Enterprise/Education)
echo "!winedition!" | find /i "Pro" >nul && set "edition_type=Pro" || (
echo "!winedition!" | find /i "Home" >nul && set "edition_type=Home" || (
echo "!winedition!" | find /i "Enterprise" >nul && set "edition_type=Enterprise" || (
echo "!winedition!" | find /i "Education" >nul && set "edition_type=Education" || set "edition_type=Standard"
)))

:: ============================================================
::  CHECK SERVER EDITION
:: ============================================================

if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*Edition~*.mum" (
    cls
    echo.
    echo ============================================================
    echo   RAJA ACTIVATOR - SERVER EDITION DETECTED
    echo ============================================================
    echo.
    echo   HWID Activation is not supported on Windows Server.
    echo.
    echo   Press any key to exit...
    pause >nul
    exit /b
)

:: ============================================================
::  CHECK UNSUPPORTED OS
:: ============================================================

if %winbuild% LSS 10240 (
    cls
    echo.
    echo ============================================================
    echo   RAJA ACTIVATOR - UNSUPPORTED OS
    echo ============================================================
    echo.
    echo   This tool only supports Windows 10 and Windows 11.
    echo   Your OS Build: %winbuild%
    echo.
    echo   Press any key to exit...
    pause >nul
    exit /b
)

:: ============================================================
::  CHECK IF ALREADY ACTIVATED
:: ============================================================

set _perm=
set "spp=SoftwareLicensingProduct"

%psc% "(([WMISEARCHER]'SELECT Name FROM %spp% WHERE LicenseStatus=1 AND GracePeriodRemaining=0 AND PartialProductKey IS NOT NULL AND LicenseDependsOn is NULL').Get()).Name" 2>nul | findstr /i "Windows" >nul && set _perm=1

:: ============================================================
::  MAIN MENU - ONLY HWID OPTION
:: ============================================================

:main_menu
cls
echo.
echo ============================================================
echo              ⚡ RAJA ACTIVATOR v3.0
echo              ====================
echo              One Click HWID Activation
echo              By @priyanshu
echo ============================================================
echo.
echo   System Information
echo   ------------------
echo   OS      : !winedition!
echo   Version : %winver% (Build %winbuild%)
echo   SKU     : %sku%
if defined _perm (
echo   Status  : ✅ ACTIVATED (Digital License)
) else (
echo   Status  : ❌ NOT ACTIVATED
)
echo.
echo ============================================================
echo.
echo   ╔═════════════════════════════════════════════════════════╗
echo   ║                                                         ║
echo   ║     [ 1 ]  ⚡ Activate !winedition!                     ║
echo   ║             (HWID Digital License)                      ║
echo   ║                                                         ║
echo   ║     [ 0 ]  ❌ Exit                                      ║
echo   ║                                                         ║
echo   ╚═════════════════════════════════════════════════════════╝
echo.
echo ============================================================
echo.
echo   💬 Support: @priyanshu
echo   🔗 Instagram: https://www.instagram.com/priyanshu.cfg
echo.
echo ============================================================
echo.

set /p choice="  Select Option [1 or 0]: "

if "%choice%"=="1" goto :activate_windows
if "%choice%"=="0" goto :exit_script

echo.
echo   ❌ Invalid option! Please select 1 or 0.
timeout /t 2 >nul
goto :main_menu

:: ============================================================
::  ACTIVATE WINDOWS - HWID ONLY
:: ============================================================

:activate_windows
cls
echo.
echo ============================================================
echo   ⚡ RAJA ACTIVATOR - ACTIVATING !winedition!
echo ============================================================
echo.
echo   Edition   : !winedition!
echo   Version   : %winver%
echo   Method    : HWID Digital License
echo   Validity  : Permanent
echo.
echo   💬 Support: @priyanshu
echo   🔗 https://www.instagram.com/priyanshu.cfg
echo.
echo ============================================================
echo.

if defined _perm (
    echo   ⚠️  !winedition! is already activated!
    echo.
    echo   Press [1] to Activate Anyway
    echo   Press [0] to Go Back
    echo.
    set /p "rechoice=  Select [1 or 0]: "
    if "%rechoice%"=="0" goto :main_menu
    if not "%rechoice%"=="1" (
        echo Invalid option!
        timeout /t 2 >nul
        goto :activate_windows
    )
    echo.
)

echo   ⏳ Downloading activation module...
%psc% "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12"

echo   ⏳ Starting activation for !winedition!...
echo   ⏳ Please wait, this may take 2-3 minutes...
echo.
echo ============================================================
echo   Activation Log:
echo ============================================================
echo.

:: ===== SILENT HWID ACTIVATION - NO MAS MENU =====
%psc% "Invoke-Expression -Command ((Invoke-RestMethod 'https://get.activated.win') + ' /HWID /NoEditionChange')"

:: ============================================================
::  CHECK RESULT
:: ============================================================

set _perm=
%psc% "(([WMISEARCHER]'SELECT Name FROM %spp% WHERE LicenseStatus=1 AND GracePeriodRemaining=0 AND PartialProductKey IS NOT NULL AND LicenseDependsOn is NULL').Get()).Name" 2>nul | findstr /i "Windows" >nul && set _perm=1

echo.
echo ============================================================
echo.

if defined _perm (
    echo   ✅ SUCCESS! !winedition! Activated Permanently!
    echo.
    echo ============================================================
    echo   🎉 Congratulations! Your Windows is now activated with
    echo      a Digital License.
    echo.
    echo   📌 Edition        : !winedition!
    echo   📌 Version        : %winver%
    echo   ✅ Activation Type : HWID (Digital License)
    echo   ✅ Validity        : Permanent
    echo   ✅ Status          : Activated
    echo.
    echo   💬 Support: @priyanshu
    echo   🔗 https://www.instagram.com/priyanshu.cfg
    echo ============================================================
) else (
    echo   ❌ Activation Failed!
    echo.
    echo ============================================================
    echo   ⚠️ Something went wrong during activation.
    echo.
    echo   📌 Edition : !winedition!
    echo.
    echo   Possible reasons:
    echo   - Internet connection issue
    echo   - Antivirus blocking the script
    echo   - System file corruption
    echo   - Unsupported edition
    echo.
    echo   💬 For support: @priyanshu
    echo   🔗 https://www.instagram.com/priyanshu.cfg
    echo ============================================================
)

echo.
echo ============================================================
echo.
echo   💬 Support: @priyanshu
echo   🔗 https://www.instagram.com/priyanshu.cfg
echo.

echo.
echo   Press any key to return to main menu...
pause >nul
goto :main_menu

:: ============================================================
::  EXIT
:: ============================================================

:exit_script
cls
echo.
echo ============================================================
echo              ⚡ RAJA ACTIVATOR v3.0
echo              ====================
echo              By @priyanshu
echo.
echo   Thank you for using RAJA Activator!
echo.
echo   💬 Support: @priyanshu
echo   🔗 https://www.instagram.com/priyanshu.cfg
echo.
echo ============================================================
echo   ⚠️ This tool is for educational purposes only.
echo   Please support Microsoft by purchasing a genuine license.
echo.
echo   ✅ Supported Editions (Auto-Detected):
echo   - Windows 10/11 Home
echo   - Windows 10/11 Pro
echo   - Windows 10/11 Enterprise
echo   - Windows 10/11 Education
echo ============================================================
echo.
timeout /t 3 >nul
exit /b

:: ============================================================
::  END OF SCRIPT
:: ============================================================