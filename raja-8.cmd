@echo off
title RAJA ACTIVATOR - Educational Edition
color 07
setlocal EnableExtensions
setlocal EnableDelayedExpansion

:: ============================================================
::  RAJA ACTIVATOR v12.0 - EDUCATIONAL EDITION
::  __________________________________________________________
::  
::  ⚡ Windows 10/11 Digital License (HWID) Activation
::  ⚡ 100% MAS Logic (Extracted for Educational Use)
::  ⚡ For Cybersecurity Lab & Research Purpose
::  __________________________________________________________
::  
::  Support: @priyanshu
::  Instagram: https://www.instagram.com/priyanshu.cfg
:: ============================================================

:: ============================================================
::  CONFIGURATION SECTION
:: ============================================================

:: Default key for Windows 10/11 Pro
:: Change if needed for other editions:
:: Home: YTMG3-N6DKC-DKB77-7M9GH-8HVX7
:: Enterprise: XGVPP-NMH47-7TTHJ-W3FW7-8HV2C
set "key=VK7JG-NPHTM-C97JM-9MPGT-3V66T"

:: Core Variables (MAS Exact)
set "tdir=%ProgramData%\Microsoft\Windows\ClipSVC\GenuineTicket"
set "spp=SoftwareLicensingProduct"
set "sps=SoftwareLicensingService"
set "nul=>nul 2>&1"
set "nul1=1>nul"
set "nul2=2>nul"
set "nul6=2^>nul"

:: PowerShell Path
set "ps=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
set "psc=%ps% -nop -c"

:: ============================================================
::  ADMIN CHECK (Lab Environment Safe)
:: ============================================================

fltmc >nul 2>&1 || (
    echo.
    echo ============================================================
    echo   ⚠️  ADMIN RIGHTS REQUIRED
    echo ============================================================
    echo.
    echo   Please right-click and select "Run as administrator"
    echo.
    echo   This is required for licensing operations in lab.
    echo.
    pause
    exit /b
)

:: ============================================================
::  GET WINDOWS INFO (For Display Purpose)
:: ============================================================

for /f "tokens=2 delims=[]" %%G in ('ver') do for /f "tokens=2,3,4 delims=. " %%H in ("%%~G") do set "winbuild=%%J"
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName 2^>nul') do set "winedition_raw=%%b"
for /f "skip=2 tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\ProductOptions" /v OSProductPfn 2^>nul') do set "sku=%%a"

set "winver=Windows 10"
if %winbuild% GEQ 22000 set "winver=Windows 11"

set "winedition=!winedition_raw!"
if %winbuild% GEQ 22000 set "winedition=!winedition_raw:Windows 10=Windows 11!"

echo "!winedition!" | find /i "Pro" >nul && set "edition_type=Pro" || (
echo "!winedition!" | find /i "Home" >nul && set "edition_type=Home" || (
echo "!winedition!" | find /i "Enterprise" >nul && set "edition_type=Enterprise" || (
echo "!winedition!" | find /i "Education" >nul && set "edition_type=Education" || set "edition_type=Standard"
)))

:: ============================================================
::  CHECK INTERNET (Required for Activation)
:: ============================================================

ping -n 1 8.8.8.8 >nul 2>&1
if %errorlevel% neq 0 (
    cls
    echo.
    echo ============================================================
    echo   ⚡ RAJA ACTIVATOR - INTERNET REQUIRED
    echo ============================================================
    echo.
    echo   Internet connection is required for HWID activation.
    echo   This allows system to register hardware ID with Microsoft.
    echo.
    echo   💬 Support: @priyanshu
    echo.
    pause
    exit /b
)

:: ============================================================
::  CHECK IF ALREADY ACTIVATED
:: ============================================================

set _perm=
%psc% "(([WMISEARCHER]'SELECT Name FROM %spp% WHERE LicenseStatus=1 AND GracePeriodRemaining=0 AND PartialProductKey IS NOT NULL AND LicenseDependsOn is NULL').Get()).Name" 2>nul | findstr /i "Windows" >nul && set _perm=1

:: ============================================================
::  MAIN MENU
:: ============================================================

:main_menu
cls
echo.
echo ============================================================
echo              ⚡ RAJA ACTIVATOR v12.0
echo              ======================
echo           Digital License (HWID) Activation
echo              Educational Edition
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
echo   ❌ Invalid option!
timeout /t 2 >nul
goto :main_menu

:: ============================================================
::  ACTIVATE WINDOWS - PURE HWID LOGIC
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
echo   Method    : Digital License (HWID)
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

echo   ⏳ Starting Digital License Activation...
echo   ⏳ Please wait, this may take 2-3 minutes...
echo.
echo ============================================================
echo   Activation Log:
echo ============================================================
echo.

:: ============================================================
::  STEP 1: CLEAN PREVIOUS TICKETS
:: ============================================================

echo [1/5] Cleaning previous temporary files...
if not exist "%tdir%\" md "%tdir%\" %nul%
if exist "%tdir%\Genuine*" del /f /q "%tdir%\Genuine*" %nul%
if exist "%tdir%\*.xml" del /f /q "%tdir%\*.xml" %nul%

:: ============================================================
::  STEP 2: GENERATE SIGNED TICKET (MAS Core)
:: ============================================================

echo [2/5] Generating signed GenuineTicket...

%psc% "
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ErrorActionPreference = 'Stop'

function SignProperties {
    param ($Properties, $rsa)
    $sha256 = [Security.Cryptography.SHA256]::Create()
    $bytes = [Text.Encoding]::UTF8.GetBytes($Properties)
    $hash = $sha256.ComputeHash($bytes)
    $signature = $rsa.SignHash($hash, [Security.Cryptography.HashAlgorithmName]::SHA256, [Security.Cryptography.RSASignaturePadding]::Pkcs1)
    return [Convert]::ToBase64String($signature)
}

[byte[]] $key = 0x07,0x02,0x00,0x00,0x00,0xA4,0x00,0x00,0x52,0x53,0x41,0x32,0x00,0x04,0x00,0x00,
0x01,0x00,0x01,0x00,0x29,0x87,0xBA,0x3F,0x52,0x90,0x57,0xD8,0x12,0x26,0x6B,0x38,
0xB2,0x3B,0xF9,0x67,0x08,0x4F,0xDD,0x8B,0xF5,0xE3,0x11,0xB8,0x61,0x3A,0x33,0x42,
0x51,0x65,0x05,0x86,0x1E,0x00,0x41,0xDE,0xC5,0xDD,0x44,0x60,0x56,0x3D,0x14,0x39,
0xB7,0x43,0x65,0xE9,0xF7,0x2B,0xA5,0xF0,0xA3,0x65,0x68,0xE9,0xE4,0x8B,0x5C,0x03,
0x2D,0x36,0xFE,0x28,0x4C,0xD1,0x3C,0x3D,0xC1,0x90,0x75,0xF9,0x6E,0x02,0xE0,0x58,
0x97,0x6A,0xCA,0x80,0x02,0x42,0x3F,0x6C,0x15,0x85,0x4D,0x83,0x23,0x6A,0x95,0x9E,
0x38,0x52,0x59,0x38,0x6A,0x99,0xF0,0xB5,0xCD,0x53,0x7E,0x08,0x7C,0xB5,0x51,0xD3,
0x8F,0xA3,0x0D,0xA0,0xFA,0x8D,0x87,0x3C,0xFC,0x59,0x21,0xD8,0x2E,0xD9,0x97,0x8B,
0x40,0x60,0xB1,0xD7,0x2B,0x0A,0x6E,0x60,0xB5,0x50,0xCC,0x3C,0xB1,0x57,0xE4,0xB7,
0xDC,0x5A,0x4D,0xE1,0x5C,0xE0,0x94,0x4C,0x5E,0x28,0xFF,0xFA,0x80,0x6A,0x13,0x53,
0x52,0xDB,0xF3,0x04,0x92,0x43,0x38,0xB9,0x1B,0xD9,0x85,0x54,0x7B,0x14,0xC7,0x89,
0x16,0x8A,0x4B,0x82,0xA1,0x08,0x02,0x99,0x23,0x48,0xDD,0x75,0x9C,0xC8,0xC1,0xCE,
0xB0,0xD7,0x1B,0xD8,0xFB,0x2D,0xA7,0x2E,0x47,0xA7,0x18,0x4B,0xF6,0x29,0x69,0x44,
0x30,0x33,0xBA,0xA7,0x1F,0xCE,0x96,0x9E,0x40,0xE1,0x43,0xF0,0xE0,0x0D,0x0A,0x32,
0xB4,0xEE,0xA1,0xC3,0x5E,0x9B,0xC7,0x7F,0xF5,0x9D,0xD8,0xF2,0x0F,0xD9,0x8F,0xAD,
0x75,0x0A,0x00,0xD5,0x25,0x43,0xF7,0xAE,0x51,0x7F,0xB7,0xDE,0xB7,0xAD,0xFB,0xCE,
0x83,0xE1,0x81,0xFF,0xDD,0xA2,0x77,0xFE,0xEB,0x27,0x1F,0x10,0xFA,0x82,0x37,0xF4,
0x7E,0xCC,0xE2,0xA1,0x58,0xC8,0xAF,0x1D,0x1A,0x81,0x31,0x6E,0xF4,0x8B,0x63,0x34,
0xF3,0x05,0x0F,0xE1,0xCC,0x15,0xDC,0xA4,0x28,0x7A,0x9E,0xEB,0x62,0xD8,0xD8,0x8C,
0x85,0xD7,0x07,0x87,0x90,0x2F,0xF7,0x1C,0x56,0x85,0x2F,0xEF,0x32,0x37,0x07,0xAB,
0xB0,0xE6,0xB5,0x02,0x19,0x35,0xAF,0xDB,0xD4,0xA2,0x9C,0x36,0x80,0xC6,0xDC,0x82,
0x08,0xE0,0xC0,0x5F,0x3C,0x59,0xAA,0x4E,0x26,0x03,0x29,0xB3,0x62,0x58,0x41,0x59,
0x3A,0x37,0x43,0x35,0xE3,0x9F,0x34,0xE2,0xA1,0x04,0x97,0x12,0x9D,0x8C,0xAD,0xF7,
0xFB,0x8C,0xA1,0xA2,0xE9,0xE4,0xEF,0xD9,0xC5,0xE5,0xDF,0x0E,0xBF,0x4A,0xE0,0x7A,
0x1E,0x10,0x50,0x58,0x63,0x51,0xE1,0xD4,0xFE,0x57,0xB0,0x9E,0xD7,0xDA,0x8C,0xED,
0x7D,0x82,0xAC,0x2F,0x25,0x58,0x0A,0x58,0xE6,0xA4,0xF4,0x57,0x4B,0xA4,0x1B,0x65,
0xB9,0x4A,0x87,0x46,0xEB,0x8C,0x0F,0x9A,0x48,0x90,0xF9,0x9F,0x76,0x69,0x03,0x72,
0x77,0xEC,0xC1,0x42,0x4C,0x87,0xDB,0x0B,0x3C,0xD4,0x74,0xEF,0xE5,0x34,0xE0,0x32,
0x45,0xB0,0xF8,0xAB,0xD5,0x26,0x21,0xD7,0xD2,0x98,0x54,0x8F,0x64,0x88,0x20,0x2B,
0x14,0xE3,0x82,0xD5,0x2A,0x4B,0x8F,0x4E,0x35,0x20,0x82,0x7E,0x1B,0xFE,0xFA,0x2C,
0x79,0x6C,0x6E,0x66,0x94,0xBB,0x0A,0xEB,0xBA,0xD9,0x70,0x61,0xE9,0x47,0xB5,0x82,
0xFC,0x18,0x3C,0x66,0x3A,0x09,0x2E,0x1F,0x61,0x74,0xCA,0xCB,0xF6,0x7A,0x52,0x37,
0x1D,0xAC,0x8D,0x63,0x69,0x84,0x8E,0xC7,0x70,0x59,0xDD,0x2D,0x91,0x1E,0xF7,0xB1,
0x56,0xED,0x7A,0x06,0x9D,0x5B,0x33,0x15,0xDD,0x31,0xD0,0xE6,0x16,0x07,0x9B,0xA5,
0x94,0x06,0x7D,0xC1,0xE9,0xD6,0xC8,0xAF,0xB4,0x1E,0x2D,0x88,0x06,0xA7,0x63,0xB8,
0xCF,0xC8,0xA2,0x6E,0x84,0xB3,0x8D,0xE5,0x47,0xE6,0x13,0x63,0x8E,0xD1,0x7F,0xD4,
0x81,0x44,0x38,0xBF

$rsa = New-Object Security.Cryptography.RSACryptoServiceProvider
$rsa.ImportCspBlob($key)
$SessionIdStr = 'OSMajorVersion=5;OSMinorVersion=1;OSPlatformId=2;PP=0;Pfn=Microsoft.Windows.%sku%.X19-98841_8wekyb3d8bbwe;PKeyIID=465145217131314304264339481117862266242033457260311819664735280;'
$SessionId = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($SessionIdStr + [char]0))
$PropertiesStr = 'OA3xOriginalProductId=;OA3xOriginalProductKey=;SessionId=' + $SessionId + ';TimeStampClient=2022-10-11T12:00:00Z'
$SignatureStr = SignProperties $PropertiesStr $rsa

$xml = '<?xml version=''1.0'' encoding=''utf-8''?><genuineAuthorization xmlns=''http://www.microsoft.com/DRM/SL/GenuineAuthorization/1.0''><version>1.0</version><genuineProperties origin=''sppclient''><properties>' + $PropertiesStr + '</properties><signatures><signature name=''clientLockboxKey'' method=''rsa-sha256''>' + $SignatureStr + '</signature></signatures></genuineProperties></genuineAuthorization>'
[IO.File]::WriteAllText('$env:ProgramData\Microsoft\Windows\ClipSVC\GenuineTicket\GenuineTicket', $xml, [System.Text.Encoding]::ASCII)
"

copy /y /b "%tdir%\GenuineTicket" "%tdir%\GenuineTicket.xml" %nul%
if not exist "%tdir%\GenuineTicket.xml" (
    echo ❌ GenuineTicket.xml Generation Failed!
    goto :activation_failed
)
echo ✅ GenuineTicket.xml generated successfully.

:: ============================================================
::  STEP 3: TICKET INJECTION (ClipSVC + ClipUp)
:: ============================================================

echo [3/5] Injecting ticket via ClipSVC...
%psc% "Start-Job { Restart-Service ClipSVC } | Wait-Job -Timeout 20 | Out-Null"
timeout /t 2 %nul%

copy /y /b "%tdir%\GenuineTicket" "%tdir%\GenuineTicket.xml" %nul%
clipup -v -o

if exist "%tdir%\Genuine*" del /f /q "%tdir%\Genuine*" %nul%

:: ============================================================
::  STEP 4: INSTALL PRODUCT KEY
:: ============================================================

echo [4/5] Installing product key [%key%]...
%psc% "
try {
    $sls = Get-WmiObject -Class SoftwareLicensingService
    $sls.InstallProductKey('%key%')
    Write-Host 'Key installed successfully!'
} catch {
    Write-Host 'Error installing key: ' $_.Exception.Message
}
"

:: Refresh License Status
%psc% "$null=(([WMICLASS]'%sps%').GetInstances()).RefreshLicenseStatus()"

:: ============================================================
::  STEP 5: ACTIVATE
:: ============================================================

echo [5/5] Activating Windows...
%psc% "
try {
    $spp = Get-WmiObject -Class SoftwareLicensingProduct | Where-Object { 
        $_.ApplicationID -eq '55c92734-d682-4d71-983e-d6ec3f16059f' -and 
        $_.PartialProductKey -ne $null -and 
        $_.LicenseDependsOn -eq $null 
    }
    foreach ($p in $spp) {
        try { 
            $p.Activate() | Out-Null 
        } catch { 
            Write-Host 'Activation error: ' $_.Exception.Message 
        }
    }
    Write-Host 'Activation completed!'
} catch {
    Write-Host 'Error: ' $_.Exception.Message
}
"

:: Final Refresh
%psc% "$null=(([WMICLASS]'%sps%').GetInstances()).RefreshLicenseStatus()"

:: ============================================================
::  CHECK RESULT
:: ============================================================

:activation_failed
set _perm=
%psc% "(([WMISEARCHER]'SELECT Name FROM %spp% WHERE LicenseStatus=1 AND GracePeriodRemaining=0 AND PartialProductKey IS NOT NULL AND LicenseDependsOn is NULL').Get()).Name" 2>nul | findstr /i "Windows" >nul && set _perm=1

echo.
echo ============================================================
echo.

if defined _perm (
    echo   ✅ !winedition! is activated with a Digital License
    echo.
    echo ============================================================
    echo   🎉 Congratulations! Your Windows is now permanently
    echo      activated with a Digital License.
    echo.
    echo   📌 Edition        : !winedition!
    echo   📌 Version        : %winver%
    echo   📌 Type           : !edition_type!
    echo   ✅ Activation Type : Digital License (HWID)
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
echo              ⚡ RAJA ACTIVATOR v12.0
echo              ======================
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
echo ============================================================
echo.
timeout /t 3 >nul
exit /b