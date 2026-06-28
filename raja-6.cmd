@echo off
setlocal EnableExtensions
setlocal EnableDelayedExpansion

:: ============================================================
::  RAJA ACTIVATOR v6.0 - AUTO EDITION DETECTION
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

:: ============================================================
::  ENVIRONMENT SETUP
:: ============================================================

set "SysPath=%SystemRoot%\System32"
set "Path=%SystemRoot%\System32;%SystemRoot%;%SystemRoot%\System32\Wbem;%SystemRoot%\System32\WindowsPowerShell\v1.0\"
if exist "%SystemRoot%\Sysnative\reg.exe" (
    set "SysPath=%SystemRoot%\Sysnative"
    set "Path=%SystemRoot%\Sysnative;%SystemRoot%;%SystemRoot%\Sysnative\Wbem;%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\;%Path%"
)

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
    echo   Restarting with admin rights...
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
    pause >nul
    exit /b
)

:: ============================================================
::  GET WINDOWS VERSION & EDITION (EXACT DETECTION)
:: ============================================================

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
::  CHECK SUPPORT
:: ============================================================

if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*Edition~*.mum" (
    cls
    echo.
    echo ============================================================
    echo   RAJA ACTIVATOR - SERVER EDITION NOT SUPPORTED
    echo ============================================================
    echo.
    echo   HWID Activation is not supported on Windows Server.
    pause >nul
    exit /b
)

if %winbuild% LSS 10240 (
    cls
    echo.
    echo ============================================================
    echo   RAJA ACTIVATOR - UNSUPPORTED OS
    echo ============================================================
    echo.
    echo   This tool only supports Windows 10 and Windows 11.
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
::  CHECK EVALUATION VERSION
:: ============================================================

if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-*EvalEdition~*.mum" (
    reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v EditionID 2>nul | find /i "Eval" >nul && (
        cls
        echo.
        echo ============================================================
        echo   RAJA ACTIVATOR - EVALUATION EDITION DETECTED
        echo ============================================================
        echo.
        echo   Evaluation editions cannot be activated outside of their evaluation period.
        echo.
        echo   Use TSforge activation option from the main menu to reset evaluation period.
        pause >nul
        exit /b
    )
)

:: ============================================================
::  MAIN MENU - SHOW EXACT DETECTED EDITION
:: ============================================================

:main_menu
cls
echo.
echo ============================================================
echo              ⚡ RAJA ACTIVATOR v6.0
echo              ====================
echo              Auto Edition Detection
echo              By @priyanshu
echo ============================================================
echo.
echo   System Information (Detected)
echo   -----------------------------
echo   OS      : !winedition!
echo   Version : %winver% (Build %winbuild%)
echo   Edition : !edition_type!
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
echo   ║             (Auto-detected exact edition)               ║
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
echo   ❌ Invalid option!
timeout /t 2 >nul
goto :main_menu

:: ============================================================
::  ACTIVATE WINDOWS - EXACT EDITION DETECTION
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
echo   Type      : !edition_type!
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

echo   ⏳ Starting HWID Activation...
echo   ⏳ Please wait, this may take 2-3 minutes...
echo.
echo ============================================================
echo   Activation Log:
echo ============================================================
echo.

:: ============================================================
::  PURE HWID ACTIVATION - AUTO EDITION DETECTION
:: ============================================================

%psc% "
$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Get SKU
$osSKU = (Get-WmiObject -Class Win32_OperatingSystem).OperatingSystemSKU

# HWID Keys Database - Sabhi editions ke liye
$hwidKeys = @{
    '4' = 'XGVPP-NMH47-7TTHJ-W3FW7-8HV2C'     # Enterprise
    '27' = '3V6Q6-NQXCX-V8YXR-9QCYV-QPFCT'   # EnterpriseN
    '48' = 'VK7JG-NPHTM-C97JM-9MPGT-3V66T'   # Professional
    '49' = '2B87N-8KFHP-DKV6R-Y2C8J-PKCKT'   # ProfessionalN
    '98' = '4CPRK-NM3K3-X6XXQ-RXX86-WXCHW'   # CoreN
    '99' = 'N2434-X9D7W-8PF6X-8DV9T-8TYMD'   # CoreCountrySpecific
    '100' = 'BT79Q-G7N6G-PGBYW-4YWX6-6F4BT'  # CoreSingleLanguage
    '101' = 'YTMG3-N6DKC-DKB77-7M9GH-8HVX7'  # Core
    '119' = 'XKCNC-J26Q9-KFHD2-FKTHY-KD72Y'  # PPIPro
    '121' = 'YNMGQ-8RYV3-4PGQ3-C8XTP-7CFBY'  # Education
    '122' = '84NGF-MHBT6-FXBX8-QWJK7-DRR8H'  # EducationN
    '125' = 'KCNVH-YKWX8-GJJB9-H9FDT-6F7W2'  # EnterpriseS
    '126' = '2DBW3-N2PJG-MVHW3-G7TDK-9HKR4'  # EnterpriseSN
    '138' = 'G3KNM-CHG6T-R36X3-9QDG6-8M8K9'  # ProfessionalSingleLanguage
    '139' = 'HNGCC-Y38KG-QVK8D-WMWRK-X86VK'  # ProfessionalCountrySpecific
    '161' = 'DXG7C-N36C4-C4HTG-X4T3X-2YV77'  # ProfessionalWorkstation
    '162' = 'WYPNQ-8C467-V2W6J-TX4WX-WT2RQ'  # ProfessionalWorkstationN
    '164' = '8PTT6-RNW4C-6V7J2-C2D3X-MHBPB'  # ProfessionalEducation
    '165' = 'GJTYN-HDMQY-FRR76-HVGC7-QPF8P'  # ProfessionalEducationN
    '175' = 'NJCF7-PW8QT-3324D-688JX-2YV66'  # ServerRdsh
    '178' = 'V3WVW-N2PV2-CGWC3-34QGF-VMJ2C'  # Cloud
    '179' = 'NH9J3-68WK7-6FB93-4K3DF-DJ4F6'  # CloudN
    '188' = 'XQQYW-NFFMW-XJPBH-K8732-CKFFD'  # IoTEnterprise
    '191' = 'QPM6N-7J2WJ-P88HH-P3YRH-YY74H'  # IoTEnterpriseS
    '202' = 'K9VKN-3BGWV-Y624W-MCRMQ-BHDCD'  # CloudEditionN
    '203' = 'KY7PN-VR6RX-83W6Y-6DDYQ-T6R4W'  # CloudEdition
}

# Exact edition ke hisaab se key select karo
$key = $hwidKeys[[string]$osSKU]

if (-not $key) {
    Write-Host 'Unsupported edition for HWID activation.'
    exit 1
}

# Key install karo
Write-Host "Installing product key for detected edition..."
$sls = Get-WmiObject -Class SoftwareLicensingService
$sls.InstallProductKey($key)

# Activate karo
$spp = Get-WmiObject -Class SoftwareLicensingProduct | Where-Object { 
    $_.ApplicationID -eq '55c92734-d682-4d71-983e-d6ec3f16059f' -and 
    $_.PartialProductKey -ne $null -and 
    $_.LicenseDependsOn -eq $null 
}

$spp | ForEach-Object { $_.Activate() }

Write-Host 'Activation completed!'
"

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
    echo   📌 Type           : !edition_type!
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
echo              ⚡ RAJA ACTIVATOR v6.0
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