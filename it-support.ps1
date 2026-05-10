# it-support.ps1
$batchCode = @'
@echo off
:: Tu kiem tra va xin quyen Admin ngay trong Batch
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process -FilePath '%0' -Verb RunAs"
    exit /b
)
title IT SUPPORT PROFESSIONAL TOOLKIT v26.5
mode con: cols=120 lines=30

:: Tao ky tu ESC de chay mau ANSI
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "ESC=%%b"

:: Dinh nghia mau
set "G=%ESC%[92m"
set "Y=%ESC%[93m"
set "C=%ESC%[96m"
set "W=%ESC%[97m"
set "R=%ESC%[91m"
set "Res=%ESC%[0m"

:menu
cls
echo.
echo  %G%====================================================================================================================%Res%
echo                                     %W%IT SUPPORT PROFESSIONAL TOOLKIT - VERSION 26.5%Res%
echo  %G%====================================================================================================================%Res%
echo.
echo     %Y%[ 1. HE THONG ]%Res%          %Y%[ 2. PHAN CUNG ]%Res%       %Y%[ 3. MANG ^& INTERNET ]%Res%    %Y%[ 4. MAY IN ]%Res%
echo.
echo      %G%1.%Res% Xem thong so PC       %G%7.%Res% Don dep rac         %G%13.%Res% Get MAC ^& SN         %G%19.%Res% Restart Spooler
echo      %G%2.%Res% Kiem tra o cung       %G%8.%Res% Sua loi SFC/DISM    %G%14.%Res% Cau hinh IP/DNS      %G%20.%Res% Xoa ket lenh in
echo      %G%3.%Res% Kiem tra RAM          %G%9.%Res% Dong ung dung treo  %G%15.%Res% Ping check GW/DNS    %G%21.%Res% In trang Test
echo      %G%4.%Res% Kiem tra User        %G%10.%Res% On/Off Win Update   %G%16.%Res% TCPing/Tracertcp     %G%22.%Res% Liet ke d/s in
echo      %G%5.%Res% Kiem tra Bitlocker   %G%11.%Res% Restart Explorer    %G%17.%Res% Xem Pass Wi-Fi       %G%23.%Res% ----13h35-------
echo      %G%6.%Res% Kiem tra             %G%12.%Res% Xu ly Task          %G%18.%Res% Reset Mang           %G%24.%Res% ---------------
echo.
echo     %C%[ 5. TRUY CAP ]%Res%        %C%[ 6. MO NHANH 2 ]%Res%       %C%[ 7. CAI DAT ]%Res%         %C%[ 8. FIX LOI AUTODESK ]%Res%
echo.
echo     %G%25.%Res% Control Panel        %G%30.%Res% Print Management    %G%35.%Res% Bo cai OFFICE        %G%--%Res% ---------------
echo     %G%26.%Res% Task Manager         %G%31.%Res% Network Connection  %G%36.%Res% %G%Active WIN/OFFICE%Res%    %G%--%Res% ---------------
echo     %G%27.%Res% Services (msc)       %G%32.%Res% Registry Editor     %G%37.%Res% Ung dung mien phi    %G%--%Res% ---------------
echo     %G%28.%Res% Device Manager       %G%33.%Res% Advanced Firewall   %G%38.%Res% Tool PDF Editor      %G%--%Res% ---------------
echo     %G%29.%Res% Windows Settings     %G%34.%Res% Uninstall Programs  %G%--%Res% -------------------   %G%--%Res% ---------------
echo.
echo   %R%[ R ]%Res% Khoi dong lai PC   %R%[ S ]%Res% Tat may PC       %W%[ 0 ] Thoat tool%Res%
echo  %G%====================================================================================================================%Res%
set /p opt="  %W%>>> Lua chon cua ban: %Res%"

:: --- DIEU HUONG LOGIC ---
if /i "%opt%"=="1" goto systemInfo
if /i "%opt%"=="2" goto hddInfo
if /i "%opt%"=="3" goto ramInfo
if /i "%opt%"=="4" goto listUsers
if /i "%opt%"=="5" goto bitlocker
if /i "%opt%"=="6" goto listapp
if /i "%opt%"=="7" goto cleanJunk
if /i "%opt%"=="8" goto repairSys
if /i "%opt%"=="9" goto killTaskres
if /i "%opt%"=="10" goto wuchange
if /i "%opt%"=="11" goto resExp
if /i "%opt%"=="12" goto runTasks
if /i "%opt%"=="13" goto getMacSN
if /i "%opt%"=="14" goto Navigation
if /i "%opt%"=="15" goto doublePing
if /i "%opt%"=="16" goto checkport
if /i "%opt%"=="17" goto wifiPass
if /i "%opt%"=="18" goto netReset
if /i "%opt%"=="19" goto restartSpooler
if /i "%opt%"=="20" goto clearQueue
if /i "%opt%"=="21" goto printTest
if /i "%opt%"=="22" goto listPrinters
if /i "%opt%"=="23" goto 
if /i "%opt%"=="24" goto 
if /i "%opt%"=="25" goto control panel & goto menu
if /i "%opt%"=="26" goto taskmgr & goto menu
if /i "%opt%"=="27" start services.msc & goto menu
if /i "%opt%"=="28" start devmgmt.msc & goto menu
if /i "%opt%"=="29" start ms-settings: & goto menu
if /i "%opt%"=="30" start printmanagement.msc & goto menu
if /i "%opt%"=="31" start ncpa.cpl & goto menu
if /i "%opt%"=="32" start regedit & goto menu
if /i "%opt%"=="33" start wf.msc & goto menu
if /i "%opt%"=="34" start Appwiz.cpl & goto menu
if /i "%opt%"=="35" goto MENU_OFFICE
if /i "%opt%"=="36" goto activeMAS
if /i "%opt%"=="37" goto installappfree
if /i "%opt%"=="38" goto acrobat
if /i "%opt%"=="39" goto
if /i "%opt%"=="40" goto
if /i "%opt%"=="41" goto
if /i "%opt%"=="42" goto
if /i "%opt%"=="43" goto
if /i "%opt%"=="44" goto
if /i "%opt%"=="r" goto restart
if /i "%opt%"=="s" goto shutdown
if /i "%opt%"=="0" exit
goto menu

:: --- CAC HAM XU LY ---

:installappfree
cls
:: 1. Kiem tra va Tu dong cai dat/Cap nhat Winget
winget --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Khong tim thay Winget. Dang tien hanh tai va cai dat...
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
        "$progressPreference = 'SilentlyContinue';" ^
        "Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile .\winget.msixbundle;" ^
        "Add-AppxPackage -Path .\winget.msixbundle;" ^
        "Remove-Item .\winget.msixbundle;"
    echo [OK] Da kich hoat Winget.
)

:: 2. Lam moi nguon tai de tranh treo
winget source update >nul 2>&1

:: 3. Chay chuong trinh chinh
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$apps = @(" ^
    "@{Name='7-Zip'; ID='7zip.7zip'}," ^
    "@{Name='Coc Coc'; ID='CocCoc.CocCoc'}," ^
    "@{Name='Core Temp'; ID='ALCPU.CoreTemp'}," ^
    "@{Name='CrystalDiskInfo'; ID='CrystalDewWorld.CrystalDiskInfo'}," ^
    "@{Name='Evernote'; ID='Evernote.Evernote'}," ^
    "@{Name='Everything'; ID='voidtools.Everything'}," ^
    "@{Name='Firefox'; ID='Mozilla.Firefox'}," ^
    "@{Name='Foxit PDF Reader'; ID='Foxit.FoxitReader'}," ^
    "@{Name='Google Chrome'; ID='Google.Chrome'}," ^
    "@{Name='Google Drive'; ID='Google.Drive'}," ^
    "@{Name='K-Lite Codec Pack Full'; ID='CodecGuide.K-LiteCodecPack.Full'}," ^
    "@{Name='Kaspersky'; ID='Kaspersky.Kaspersky'}," ^
    "@{Name='Microsoft Teams'; ID='Microsoft.Teams'}," ^
    "@{Name='Notepad++'; ID='Notepad++.Notepad++'}," ^
    "@{Name='OneDrive'; ID='Microsoft.OneDrive'}," ^
    "@{Name='PDF24 Creator'; ID='PDF24.PDF24Creator'}," ^
    "@{Name='Synology Chat'; ID='Synology.ChatClient'}," ^
    "@{Name='TreeSize Free'; ID='JAMSoftware.TreeSizeFree'}," ^
    "@{Name='UltraViewer'; ID='UltraViewer.UltraViewer'}," ^
    "@{Name='UniKey'; ID='UniKey.UniKey'}," ^
    "@{Name='WeChat'; ID='Tencent.WeChat'}," ^
    "@{Name='WinRAR'; ID='RARLab.WinRAR'}," ^
    "@{Name='Zalo'; ID='Zalo.Zalo'}" ^
    ");" ^
    "while($true) {" ^
    "    Clear-Host;" ^
    "    Write-Host '--- DANG QUET UNG DUNG TREN MAY... ---' -ForegroundColor Yellow;" ^
    "    $installedList = winget list --accept-source-agreements 2>$null | Out-String;" ^
    "    $validChoice = $false;" ^
    "    while(-not $validChoice) {" ^
    "        Clear-Host;" ^
    "        Write-Host '----- DANH SACH UNG DUNG (OFFICIAL) -----' -ForegroundColor Cyan;" ^
    "        for ($i=0; $i -lt $apps.Count; $i++) {" ^
    "            $displayName = '{0,2}. {1}' -f ($i+1), $apps[$i].Name;" ^
    "            if ($installedList -like \"*$($apps[$i].ID)*\") {" ^
    "                Write-Host $displayName -ForegroundColor Green;" ^
    "            } else {" ^
    "                Write-Host $displayName;" ^
    "            }" ^
    "        };" ^
    "        Write-Host '----------------------------------';" ^
    "        Write-Host 'A. Cai dat/Nang cap TAT CA';" ^
    "        Write-Host 'U. CAP NHAT TOAN BO app tren may';" ^
    "        Write-Host 'Q. THOAT VE MENU CHINH' -ForegroundColor Red;" ^
    "        $choice = Read-Host 'Nhap lua chon (vd: 1,3,5)';" ^
    "        if ($choice -eq 'Q' -or $choice -eq 'q') { return } " ^
    "        if ($choice -eq 'U' -or $choice -eq 'u') { $validChoice = $true; break } " ^
    "        if ($choice -eq 'A' -or $choice -eq 'a') { $targets = $apps; $validChoice = $true; break } " ^
    "        try {" ^
    "            if ([string]::IsNullOrWhiteSpace($choice)) { throw };" ^
    "            $indices = $choice.Split(',').Trim();" ^
    "            $targets = foreach ($idx in $indices) {" ^
    "                $n = [int]$idx;" ^
    "                if ($n -lt 1 -or $n -gt $apps.Count) { throw };" ^
    "                $apps[$n-1]" ^
    "            };" ^
    "            $validChoice = $true;" ^
    "        } catch {" ^
    "            Write-Host 'Lua chon khong hop le!' -ForegroundColor Red;" ^
    "            Start-Sleep -Seconds 2; Clear-Host; break;" ^
    "        }" ^
    "    }" ^
    "    if ($validChoice) {" ^
    "        foreach ($app in $targets) {" ^
    "            Write-Host \"`n[*] Dang kiem tra: $($app.Name)...\" -ForegroundColor Cyan;" ^
    "            $isInstalled = winget list --id $app.ID -e --accept-source-agreements 2>$null;" ^
    "            if ($isInstalled -match $app.ID) {" ^
    "                Write-Host '   -> Da co. Dang check Update...' -ForegroundColor Yellow;" ^
    "                $res = winget upgrade --id $app.ID --silent --accept-package-agreements --accept-source-agreements 2>$null;" ^
    "                if ($res -match 'No available upgrade found') { Write-Host '   -> Ung dung da o phien ban moi nhat.' -ForegroundColor Blue } else { Write-Host '   -> Cap nhat thanh cong!' -ForegroundColor Green }" ^
    "            } else {" ^
    "                Write-Host '   -> Chua co, dang cai dat...' -ForegroundColor Red;" ^
    "                winget install --id $app.ID -e --silent --accept-package-agreements --accept-source-agreements;" ^
    "                Write-Host '   -> Da cai dat hoan tat!' -ForegroundColor Green;" ^
    "            }" ^
    "        }" ^
    "        Write-Host 'Xoa rac va lam moi danh sach...';" ^
    "        Remove-Item \"$env:TEMP\*\" -Recurse -Force -ErrorAction SilentlyContinue;" ^
    "        Start-Sleep -Seconds 3;" ^
    "    }" ^
    "}"
pause
goto menu

:bitlocker
cls
echo ======================================================
echo           %Y%[ CONG CU QUAN LY BITLOCKER]%Res%
echo ======================================================
echo 1. Kiem tra trang thai BitLocker tat ca o dia
echo 2. Tat Bitlocker cho 1 o dia cu the (Vi du: C:)
echo 3. Tat BitLocker cho TAT CA o dia dang bao ve
echo 4. Theo doi tien trinh giai ma (Real-time)
echo 5. Thoat ve menu chinh
echo ======================================================
set /p choice="Chon lua chon cua ban (1-5): "

if "%choice%"=="1" goto :status
if "%choice%"=="2" goto :disable_one
if "%choice%"=="3" goto :disable_all
if "%choice%"=="4" goto :monitor
if "%choice%"=="5" goto menu
goto :bitlocker

:status
echo.
echo --- TRANG THAI BITLOCKER ---
powershell -command "Get-BitLockerVolume | Select-Object MountPoint, VolumeStatus, ProtectionStatus, EncryptionPercentage | Format-Table -AutoSize"
pause
goto :bitlocker

:disable_one
set "drive="
set /p drive="Nhap ky tu o dia (Vi du C hoac C:): "
if "%drive%"=="" goto :bitlocker

:: Tu dong them dau hai cham neu thieu
if "%drive:~-1%" NEQ ":" set "drive=%drive%:"

echo [!] Dang kiem tra o %drive%...
:: Kiem tra trang thai truoc khi tat de tranh loi 0x80310008
powershell -command "$v = Get-BitLockerVolume -MountPoint '%drive%'; if ($v.ProtectionStatus -eq 'On') { Disable-BitLocker -MountPoint '%drive%'; Write-Host '[OK] Da bat dau giai ma o %drive%.' -ForegroundColor Green } else { Write-Host '[!] O %drive% hien dang TAT BitLocker, khong can giai ma.' -ForegroundColor Yellow }"
pause
goto :bitlocker

:disable_all
echo.
echo [!] Dang kiem tra tat ca cac o dia...
powershell -command "$vols = Get-BitLockerVolume | Where-Object { $_.ProtectionStatus -eq 'On' }; if ($vols) { Disable-BitLocker -MountPoint $vols; Write-Host '[OK] Da kich hoat giai ma cho cac o dang bat.' -ForegroundColor Green } else { Write-Host '[!] Khong tim thay o dia nao dang bat BitLocker.' -ForegroundColor Yellow }"
pause
goto :bitlocker

:monitor
echo.
echo --- DANG THEO DOI (Nhan Ctrl+C de dung) ---
powershell -command "while($true) { Clear-Host; Write-Host '--- Tien trinh giai ma (Nhan Ctrl+C de thoat) ---'; Get-BitLockerVolume | Select-Object MountPoint, ProtectionStatus, EncryptionPercentage | Format-Table -AutoSize; Start-Sleep -Seconds 5 }"
goto :bitlocker

:activeMAS
cls
echo %Y%=====================================================%Res%
echo       %Y%[ DANG KET NOI DEN MAY CHU MAS...]%Res%
echo =====================================================%Res%
echo.
echo %C%Luu y: May tinh can co ket noi Internet.%Res%
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://get.activated.win | iex"
goto menu

:acrobat
cls
title Acrobat V%ver% - Developed by CongNV
mode 82, 30
set "ver=1.5"
set "path64=%ProgramFiles%\Adobe\Acrobat DC\Acrobat"
set "path32=%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat"
set "source=%TEMP%\SourceAcrobat"
echo:     ________________________________________________________________________
echo:
echo:                           Cai dat va kich hoat Acrobat
echo:                              developed by -CongNV
echo:     ________________________________________________________________________ 
echo:         [1] FULL: Tai, Cai dat ^& Kich hoat tu dong
echo:         [2] Chi Kich hoat (Neu da cai san)
echo:         [3] Extras        ^|  Advanced Options
echo:         [4] Recovery      ^|  Restore Defaults
echo:         ________________________________________________________________
echo:
echo:         [0] Exit
echo:     ________________________________________________________________________ 
echo.
choice /C:12340 /N
set "userChoice=%errorlevel%"

if %userChoice%==1 goto DownloadInstall
if %userChoice%==2 goto DownloadPatch
if %userChoice%==3 goto ExtraSubmenu
if %userChoice%==4 goto RestoreDefaultsSubmenu
if %userChoice%==5 exit /b

:DownloadInstall
if exist "%source%" rmdir /s /q "%source%"
md "%source%"
cls
echo:     ==^> Dang tai Adobe Acrobat DC...
curl --ssl-no-revoke --progress-bar -L -o "%source%\Acrobat.zip" https://trials.adobe.com/AdobeProducts/APRO/Acrobat_HelpX/win32/Acrobat_DC_Web_x64_WWMUI.zip

if not exist "%source%\Acrobat.zip" (
    echo [LOI] Khong the tai file. Kiem tra mang hoac Antivirus.
    pause & goto acrobat
)

:: --- PHAN XU LY ANTIVIRUS MANH TAY ---
echo:     ==^> Dang tam tat Windows Defender de tranh loi giai nen...
powershell -Command "Add-MpPreference -ExclusionPath '%source%'" >nul 2>&1
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true" >nul 2>&1
:: -------------------------------------

echo:     ==^> Dang giai nen Adobe Acrobat (Vui long doi)...
powershell -Command "Expand-Archive -Path '%source%\Acrobat.zip' -DestinationPath '%source%' -Force"
del /f "%source%\Acrobat.zip"

echo:     ==^> Dang cai dat, vui long uncheck genuine service -> nhan next ->finish...
start /wait "" "%source%\Adobe Acrobat\setup.exe" /quiet
goto DownloadPatch

:DownloadPatch
cls
if not exist "%path64%\Acrobat.exe" if not exist "%path32%\Acrobat.exe" (
    echo [LOI] Khong tim thay Adobe Acrobat. Vui long cai dat truoc.
    pause & goto acrobat
)

if not exist "%source%" md "%source%"
echo:     ==^> Dang tai file Patch...
curl --ssl-no-revoke --progress-bar -L -o "%source%\Patch.zip" https://github.com/GenP-V/Acropolis/releases/latest/download/AcrobatV.zip

:: --- Dam bao Exclusion va Tat Real-time cho Patch ---
powershell -Command "Add-MpPreference -ExclusionPath '%source%'" >nul 2>&1
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true" >nul 2>&1
timeout /t 2 /nobreak >nul

echo:     ==^> Dang giai nen Patch...
powershell -Command "Expand-Archive -Path '%source%\Patch.zip' -DestinationPath '%source%' -Force"
del /f "%source%\Patch.zip"

:ProcessPatch
echo:     ==^> Dang dong cac tien trinh Adobe...
powershell -Command "Get-Service -DisplayName Adobe* | Stop-Service -Force -ErrorAction SilentlyContinue; $p = Get-Process | Where-Object {$_.CompanyName -match 'Adobe' -or $_.Path -match 'Adobe'}; if($p){$p | Stop-Process -Force -ErrorAction SilentlyContinue}"

for %%P in ("%path64%" "%path32%") do (
    if exist "%%~P\Acrobat.exe" (
        echo    - Dang xu ly tai: %%~P
        for %%F in (acrotray.exe Acrobat.dll acrodistdll.dll) do (
            if exist "%%~P\%%F" if not exist "%%~P\%%F.bak" copy "%%~P\%%F" "%%~P\%%F.bak" >nul
            if exist "%source%\%%F" xcopy /y "%source%\%%F" "%%~P\" >nul
        )
        if exist "%%~P\Adobe Crash Processor.exe" move /y "%%~P\Adobe Crash Processor.exe" "%%~P\Adobe Crash Processor.exe.bak" >nul
    )
)

:DisableUpdater
sc config "AdobeARMservice" start= disabled >nul 2>&1
sc stop "AdobeARMservice" >nul 2>&1

:AddHosts
::powershell -NoProfile -Command "$h='C:\Windows\System32\drivers\etc\hosts'; $w=(Invoke-RestMethod -Uri 'http://isdumb.one' -UseBasicParsing).Split(\"`n\").Trim() | ?{$_ -ne ''}; $c=Get-Content $h; $s='#region Adobe'; $e='#endregion'; if($c -contains $s){$start=$c.IndexOf($s); $end=$c.IndexOf($e); $c=$c[0..($start-1)] + $c[($end+1)..$c.Length]}; Set-Content $h ($c + $s + $w + $e) -Force"
echo:     ==^> Dang tai danh sach host adobe..
set "hostsURL=https://raw.githubusercontent.com/itsup-ftel/tools/refs/heads/main/file/hostsadobe.txt"
set "tempHosts=%TEMP%\adobe_hosts.txt"

:: Thử tải từ GitHub
echo:     ==^> Dang thu tai danh sach adobe xuong...
curl --ssl-no-revoke -L -s -f -o "%tempHosts%" "%hostsURL%"

:: Kiểm tra nếu tải thất bại (file không tồn tại hoặc rỗng)
if %errorlevel% neq 0 (
    echo:     [!] Khong the ket noi GitHub. Dang chuyen sang danh sach thu cong...
    (
        echo 127.0.0.1 192.150.14.69
        echo 127.0.0.1 192.150.18.101
        echo 127.0.0.1 192.150.18.108
        echo 127.0.0.1 192.150.22.40
        echo 127.0.0.1 192.150.8.100
        echo 127.0.0.1 192.150.8.118
        echo 127.0.0.1 199.7.52.190
        echo 127.0.0.1 199.7.54.72
        echo 127.0.0.1 209.34.83.67
        echo 127.0.0.1 209.34.83.73
        echo 127.0.0.1 18.207.85.246
        echo 127.0.0.1 52.6.155.20
        echo 127.0.0.1 52.10.49.85
        echo 127.0.0.1 23.22.30.141
        echo 127.0.0.1 34.215.42.13
        echo 127.0.0.1 52.84.156.37
        echo 127.0.0.1 65.8.207.109
        echo 127.0.0.1 3.220.11.113
        echo 127.0.0.1 3.221.72.231
        echo 127.0.0.1 3.216.32.253
        echo 127.0.0.1 3.208.248.199
        echo 127.0.0.1 3.219.243.226
        echo 127.0.0.1 13.227.103.57
        echo 127.0.0.1 34.192.151.90
        echo 127.0.0.1 34.237.241.83
        echo 127.0.0.1 44.240.189.42
        echo 127.0.0.1 52.20.222.155
        echo 127.0.0.1 52.208.86.132
        echo 127.0.0.1 54.208.86.132
        echo 127.0.0.1 63.140.38.120
        echo 127.0.0.1 63.140.38.160
        echo 127.0.0.1 63.140.38.169
        echo 127.0.0.1 63.140.38.219
        echo 127.0.0.1 18.228.243.121
        echo 127.0.0.1 18.230.164.221
        echo 127.0.0.1 54.156.135.114
        echo 127.0.0.1 54.221.228.134
        echo 127.0.0.1 54.224.241.105
        echo 127.0.0.1 100.24.211.130
        echo 127.0.0.1 162.247.242.20
        echo 127.0.0.1 3.233.129.217
        echo 127.0.0.1 ereg.adobe.de
        echo 127.0.0.1 hl2rcv.adobe.de
        echo 127.0.0.1 activate.adobe.de
        echo 127.0.0.1 adobe-dns.adobe.de
        echo 127.0.0.1 practivate.adobe.de
        echo 127.0.0.1 adobe-dns-3.adobe.de
        echo 127.0.0.1 adobe-dns-2.adobe.de
        echo 127.0.0.1 activate-sea.adobe.de
        echo 127.0.0.1 activate-sjc0.adobe.de
        echo 127.0.0.1 activate.wip3.adobe.de
        echo 127.0.0.1 wwis-dubc1-vip60.adobe.de
        echo 127.0.0.1 helpexamples.com
        echo 127.0.0.1 209-34-83-73.ood.opsource.net
        echo 127.0.0.1 licenses.adobe.com
        echo 127.0.0.1 license.adobe.com
        echo 127.0.0.1 lm-prd-da1.licenses.adobe.com
        echo 127.0.0.1 practivate-da1.adobe.com
        echo 127.0.0.1 3dns-1.adobe.com
        echo 127.0.0.1 3dns-2.adobe.com
        echo 127.0.0.1 3dns-3.adobe.com
        echo 127.0.0.1 3dns-4.adobe.com
        echo 127.0.0.1 3dns-5.adobe.com
        echo 127.0.0.1 3dns.adobe.com
        echo 127.0.0.1 activate-sea.adobe.com
        echo 127.0.0.1 activate-sjc0.adobe.com
        echo 127.0.0.1 activate.adobe.com
        echo 127.0.0.1 activate.wip.adobe.com
        echo 127.0.0.1 activate.wip1.adobe.com
        echo 127.0.0.1 activate.wip2.adobe.com
        echo 127.0.0.1 activate.wip3.adobe.com
        echo 127.0.0.1 activate.wip4.adobe.com
        echo 127.0.0.1 adobe-dns-1.adobe.com
        echo 127.0.0.1 adobe-dns-2.adobe.com
        echo 127.0.0.1 adobe-dns-3.adobe.com
        echo 127.0.0.1 adobe-dns-4.adobe.com
        echo 127.0.0.1 adobe-dns.adobe.com
        echo 127.0.0.1 adobe.activate.com
        echo 127.0.0.1 adobeereg.com
        echo 127.0.0.1 cmdls.adobe.com
        echo 127.0.0.1 crl.verisign.net
        echo 127.0.0.1 ereg.adobe.com
        echo 127.0.0.1 ereg.wip.adobe.com
        echo 127.0.0.1 ereg.wip1.adobe.com
        echo 127.0.0.1 ereg.wip2.adobe.com
        echo 127.0.0.1 ereg.wip3.adobe.com
        echo 127.0.0.1 ereg.wip4.adobe.com
        echo 127.0.0.1 genuine.adobe.com
        echo 127.0.0.1 hlrcv.stage.adobe.com
        echo 127.0.0.1 hl2rcv.adobe.com
        echo 127.0.0.1 ims-na1-prprod.adobelogin.com
        echo 127.0.0.1 lm.licenses.adobe.com
        echo 127.0.0.1 lmlicenses.wip4.adobe.com
        echo 127.0.0.1 na1r.services.adobe.com
        echo 127.0.0.1 na2m-pr.licenses.adobe.com
        echo 127.0.0.1 na2m-stg2.licenses.adobe.com
        echo 127.0.0.1 na4r.services.adobe.com
        echo 127.0.0.1 ocsp.spo1.verisign.com
        echo 127.0.0.1 ood.opsource.net
        echo 127.0.0.1 practivate.adobe
        echo 127.0.0.1 practivate.adobe.
        echo 127.0.0.1 practivate.adobe.com
        echo 127.0.0.1 practivate.adobe.ipp
        echo 127.0.0.1 practivate.adobe.newoa
        echo 127.0.0.1 practivate.adobe.ntp
        echo 127.0.0.1 prod-rel-ffc-ccm.oobesaas.adobe.com
        echo 127.0.0.1 s-2.adobe.com
        echo 127.0.0.1 s-3.adobe.com
        echo 127.0.0.1 tss-geotrust-crl.thawte.com
        echo 127.0.0.1 uds.licenses.adobe.com
        echo 127.0.0.1 wip1.adobe.com
        echo 127.0.0.1 wip2.adobe.com
        echo 127.0.0.1 wip3.adobe.com
        echo 127.0.0.1 wip4.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip100.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip101.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip102.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip103.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip104.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip105.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip106.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip107.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip108.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip109.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip110.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip111.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip112.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip113.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip114.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip115.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip116.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip117.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip118.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip119.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip120.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip121.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip122.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip123.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip124.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip125.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip30.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip31.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip32.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip33.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip34.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip35.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip36.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip37.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip38.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip39.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip40.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip41.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip42.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip43.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip44.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip45.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip46.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip47.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip48.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip49.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip50.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip51.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip52.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip53.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip54.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip55.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip56.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip57.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip58.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip59.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip60.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip61.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip62.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip63.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip64.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip65.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip66.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip67.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip68.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip69.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip70.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip71.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip72.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip73.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip74.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip75.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip76.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip77.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip78.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip79.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip80.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip81.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip82.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip83.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip84.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip85.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip86.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip87.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip88.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip89.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip90.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip91.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip92.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip93.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip94.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip95.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip96.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip97.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip98.adobe.com
        echo 127.0.0.1 wwis-dubc1-vip99.adobe.com
        echo 127.0.0.1 www.adobeereg.com
        echo 127.0.0.1 prod.adobegenuine.com
        echo 127.0.0.1 wip.adobe.com
        echo 127.0.0.1 199.232.114.137
        echo 127.0.0.1 bam.nr-data.net
        echo 127.0.0.1 www.wip.adobe.com
        echo 127.0.0.1 www.wip1.adobe.com
        echo 127.0.0.1 www.wip2.adobe.com
        echo 127.0.0.1 www.wip3.adobe.com
        echo 127.0.0.1 www.wip4.adobe.com
        echo 127.0.0.1 k.sni.global.fastly.net
        echo 127.0.0.1 workflow-ui-prod.licensingstack.com
        echo 127.0.0.1 adobe-dns-01.adobe.com
        echo 127.0.0.1 adobe.demdex.net
        echo 127.0.0.1 adobe.tt.omtrdc.net
        echo 127.0.0.1 adobedc.demdex.net
        echo 127.0.0.1 adobeid-na1.services.adobe.com
        echo 127.0.0.1 auth-cloudfront.prod.ims.adobejanus.com
        echo 127.0.0.1 auth.services.adobe.com
        echo 127.0.0.1 cc-cdn.adobe.com
        echo 127.0.0.1 cc-cdn.adobe.com.edgekey.net
        echo 127.0.0.1 cclibraries-defaults-cdn.adobe.com
        echo 127.0.0.1 cclibraries-defaults-cdn.adobe.com.edgekey.net
        echo 127.0.0.1 cn-assets.adobedtm.com.edgekey.net
        echo 127.0.0.1 crlog-crcn.adobe.com
        echo 127.0.0.1 crs.cr.adobe.com
        echo 127.0.0.1 ethos.ethos02-prod-irl1.ethos.adobe.net
        echo 127.0.0.1 geo2.adobe.com
        echo 127.0.0.1 services.prod.ims.adobejanus.com
        echo 127.0.0.1 ssl-delivery.adobe.com.edgekey.net
        echo 127.0.0.1 sstats.adobe.com
        echo 127.0.0.1 stls.adobe.com-cn.edgesuite.net
        echo 127.0.0.1 stls.adobe.com-cn.edgesuite.net.globalredir.akadns.net
        echo 127.0.0.1 gocart-web-prod-ue1-alb-1461435473.us-east-1.elb.amazonaws.com
        echo 127.0.0.1 use-stls.adobe.com.edgesuite.net
        echo 127.0.0.1 assets.adobedtm.com
        echo 127.0.0.1 adobe.io
        echo 127.0.0.1 ic.adobe.io
        echo 127.0.0.1 p13n.adobe.io
        echo 127.0.0.1 lcs-cops.adobe.io
        echo 127.0.0.1 lcs-robs.adobe.io
        echo 127.0.0.1 cctypekit.adobe.io
        echo 127.0.0.1 sj9n87sls.adobe.io
        echo 127.0.0.1 1b9khekel6.adobe.io
        echo 127.0.0.1 b5kbg2ggog.adobe.io
        echo 127.0.0.1 4vzokhpsbs.adobe.io
        echo 127.0.0.1 69tu0xswvq.adobe.io
        echo 127.0.0.1 5zgzzv92gn.adobe.io
        echo 127.0.0.1 dyzt55url8.adobe.io
        echo 127.0.0.1 gw8gfjbs05.adobe.io
        echo 127.0.0.1 dxyeyf6ecy.adobe.io
        echo 127.0.0.1 1hzopx6nz7.adobe.io
        echo 127.0.0.1 9ngulmtgqi.adobe.io
        echo 127.0.0.1 vcorzsld2a.adobe.io
        echo 127.0.0.1 fqaq3pq1o9.adobe.io
        echo 127.0.0.1 8ncdzpmmrg.adobe.io
        echo 127.0.0.1 jc95y2v12r.adobe.io
        echo 127.0.0.1 7sj9n87sls.adobe.io
        echo 127.0.0.1 r5hacgq5w6.adobe.io
        echo 127.0.0.1 7m31guub0q.adobe.io
        echo 127.0.0.1 vajcbj9qgq.adobe.io
        echo 127.0.0.1 2ftem87osk.adobe.io
        echo 127.0.0.1 ph0f2h2csf.adobe.io
        echo 127.0.0.1 guzg78logz.adobe.io
        echo 127.0.0.1 p7uxzbht8h.adobe.io
        echo 127.0.0.1 3d3wqt96ht.adobe.io
        echo 127.0.0.1 p0bjuoe16a.adobe.io
        echo 127.0.0.1 lre1kgz2u4.adobe.io
        echo 127.0.0.1 0mo5a70cqa.adobe.io
        echo 127.0.0.1 p7uxzbnt8h.adobe.io
        echo 127.0.0.1 ij0gdyrfka.adobe.io
        echo 127.0.0.1 23ynjitwt5.adobe.io
        echo 127.0.0.1 aoorovjtha.adobe.io
        echo 127.0.0.1 uzantvo0as.adobe.io
        echo 127.0.0.1 p9jaddiqux.adobe.io
        echo 127.0.0.1 27hqwvagdh.adobe.io
        echo 127.0.0.1 vgetwxoqno.adobe.io
        echo 127.0.0.1 9k046300lp.adobe.io
        echo 127.0.0.1 4u4udfpb9h.adobe.io
        echo 127.0.0.1 0ojupfm51u.adobe.io
        echo 127.0.0.1 a2104gz1mh.adobe.io
        echo 127.0.0.1 xo9j8bcw4a.adobe.io
        echo 127.0.0.1 drdqxhlcop.adobe.io
        echo 127.0.0.1 chlydkc9bz.adobe.io
        echo 127.0.0.1 fcbx058i0c.adobe.io
        echo 127.0.0.1 tqcbs617dw.adobe.io
        echo 127.0.0.1 pojvrj7ho5.adobe.io
        echo 127.0.0.1 i7pq6fgbsl.adobe.io
        echo 127.0.0.1 r3zj0yju1q.adobe.io
        echo 127.0.0.1 3ca52znvmj.adobe.io
        echo 127.0.0.1 7g2gzgk9g1.adobe.io
        echo 127.0.0.1 cd536oo20y.adobe.io
        echo 127.0.0.1 m59b4msyph.adobe.io
        echo 127.0.0.1 22gda3bxkb.adobe.io
        echo 127.0.0.1 fgh5v09kcn.adobe.io
        echo 127.0.0.1 ivbnpthtl2.adobe.io
        echo 127.0.0.1 cc-api-data.adobe.io
        echo 127.0.0.1 cai-splunk-proxy.adobe.io
        echo 127.0.0.1 edgeproxy-irl1.cloud.adobe.io
        echo 127.0.0.1 pv2bqhsp36w.prod.cloud.adobe.io
        echo 127.0.0.1 pv256ds6c99.prod.cloud.adobe.io
        echo 127.0.0.1 cv2l4573ukh.prod.cloud.adobe.io
        echo 127.0.0.1 pv24v41zibm.prod.cloud.adobe.io
        echo 127.0.0.1 iv2nn9r0j2r.prod.cloud.adobe.io
        echo 127.0.0.1 iv2yt8sqmh0.prod.cloud.adobe.io
        echo 127.0.0.1 iv218qmzox6.prod.cloud.adobe.io
        echo 127.0.0.1 cv218qmzox6.prod.cloud.adobe.io
        echo 127.0.0.1 cv2b0yc07ls.prod.cloud.adobe.io
        echo 127.0.0.1 cv2nn9r0j2r.prod.cloud.adobe.io
        echo 127.0.0.1 pv2yt8sqmh0.prod.cloud.adobe.io
        echo 127.0.0.1 iv256ds6c99.prod.cloud.adobe.io
        echo 127.0.0.1 pv2zp87w2eo.prod.cloud.adobe.io
        echo 127.0.0.1 iv2ys4tjt9x.prod.cloud.adobe.io
        echo 127.0.0.1 cv2ska86hnt.prod.cloud.adobe.io
        echo 127.0.0.1 iv24b15c1z0.prod.cloud.adobe.io
        echo 127.0.0.1 cv256ds6c99.prod.cloud.adobe.io
        echo 127.0.0.1 pv2ska86hnt.prod.cloud.adobe.io
        echo 127.0.0.1 iv2b0yc07ls.prod.cloud.adobe.io
        echo 127.0.0.1 iv2l4573ukh.prod.cloud.adobe.io
        echo 127.0.0.1 cv24v41zibm.prod.cloud.adobe.io
        echo 127.0.0.1 iv2ska86hnt.prod.cloud.adobe.io
        echo 127.0.0.1 pv2l4573ukh.prod.cloud.adobe.io
        echo 127.0.0.1 iv24v41zibm.prod.cloud.adobe.io
        echo 127.0.0.1 iv2zp87w2eo.prod.cloud.adobe.io
        echo 127.0.0.1 pv2ys4tjt9x.prod.cloud.adobe.io
        echo 127.0.0.1 cv2ys4tjt9x.prod.cloud.adobe.io
        echo 127.0.0.1 cv2fcqvzl1r.prod.cloud.adobe.io
        echo 127.0.0.1 pv2fcqvzl1r.prod.cloud.adobe.io
        echo 127.0.0.1 cv24b15c1z0.prod.cloud.adobe.io
        echo 127.0.0.1 pv24b15c1z0.prod.cloud.adobe.io
        echo 127.0.0.1 cv2bqhsp36w.prod.cloud.adobe.io
        echo 127.0.0.1 pv2b0yc07ls.prod.cloud.adobe.io
        echo 127.0.0.1 pv218qmzox6.prod.cloud.adobe.io
        echo 127.0.0.1 cv2yt8sqmh0.prod.cloud.adobe.io
        echo 127.0.0.1 iv2fcqvzl1r.prod.cloud.adobe.io
        echo 127.0.0.1 pv2nn9r0j2r.prod.cloud.adobe.io
        echo 127.0.0.1 cv2zp87w2eo.prod.cloud.adobe.io
        echo 127.0.0.1 iv2bqhsp36w.prod.cloud.adobe.io
        echo 127.0.0.1 fp.adobestats.io
        echo 127.0.0.1 yj8yx3y8zo.adobestats.io
        echo 127.0.0.1 mpsige2va9.adobestats.io
        echo 127.0.0.1 ujqx8lhpz4.adobestats.io
        echo 127.0.0.1 y2r8jzsv4p.adobestats.io
        echo 127.0.0.1 eq7dbze88m.adobestats.io
        echo 127.0.0.1 q9hjwppxeq.adobestats.io
        echo 127.0.0.1 skg7pqn0al.adobestats.io
        echo 127.0.0.1 9iay914wzy.adobestats.io
        echo 127.0.0.1 yuzuoqo0il.adobestats.io
        echo 127.0.0.1 2o3c6rbyfr.adobestats.io
        echo 127.0.0.1 vicsj37lhf.adobestats.io
        echo 127.0.0.1 nhc73ypmli.adobestats.io
        echo 127.0.0.1 oxiz2n3i4v.adobestats.io
        echo 127.0.0.1 2qjz50z5lf.adobestats.io
        echo 127.0.0.1 i2x2ius9o5.adobestats.io
        echo 127.0.0.1 lnwbupw1s7.adobestats.io
        echo 127.0.0.1 n746qg9j4i.adobestats.io
        echo 127.0.0.1 2621x1nzeq.adobestats.io
        echo 127.0.0.1 r9r6oomgms.adobestats.io
        echo 127.0.0.1 99pfl4vazm.adobestats.io
        echo 127.0.0.1 zekdqanici.adobestats.io
        echo 127.0.0.1 g9cli80sqp.adobestats.io
        echo 127.0.0.1 dyv9axahup.adobestats.io
        echo 127.0.0.1 17ov1u3gio.adobestats.io
        echo 127.0.0.1 7l4xxjhvkt.adobestats.io
        echo 127.0.0.1 wcxqmuxd4z.adobestats.io
        echo 127.0.0.1 l558s6jwzy.adobestats.io
        echo 127.0.0.1 85n85uoa1h.adobestats.io
        echo 127.0.0.1 zrao5tdh1t.adobestats.io
        echo 127.0.0.1 eftcpaiu36.adobestats.io
        echo 127.0.0.1 2qj10f8rdg.adobestats.io
        echo 127.0.0.1 ffs3xik41x.adobestats.io
        echo 127.0.0.1 g3y09mbaam.adobestats.io
        echo 127.0.0.1 x880ulw3h0.adobestats.io
        echo 127.0.0.1 jaircqa037.adobestats.io
        echo 127.0.0.1 ppn4fq68w7.adobestats.io
        echo 127.0.0.1 1ei1f4k9yk.adobestats.io
        echo 127.0.0.1 6j0onv1tde.adobestats.io
        echo 127.0.0.1 pljm140ld1.adobestats.io
        echo 127.0.0.1 50sxgwgngu.adobestats.io
        echo 127.0.0.1 u31z50xvp9.adobestats.io
        echo 127.0.0.1 2dhh9vsp39.adobestats.io
        echo 127.0.0.1 rb0u8l34kr.adobestats.io
        echo 127.0.0.1 3odrrlydxt.adobestats.io
        echo 127.0.0.1 3u6k9as4bj.adobestats.io
        echo 127.0.0.1 curbpindd3.adobestats.io
        echo 127.0.0.1 4dviy9tb3o.adobestats.io
        echo 127.0.0.1 yb6j6g0r1n.adobestats.io
        echo 127.0.0.1 0bj2epfqn1.adobestats.io
        echo 127.0.0.1 ura7zj55r9.adobestats.io
        echo 127.0.0.1 xesnl0ss94.adobestats.io
        echo 127.0.0.1 xbd20b9wqa.adobestats.io
        echo 127.0.0.1 cr2fouxnpm.adobestats.io
        echo 127.0.0.1 zmg3v61bbr.adobestats.io
        echo 127.0.0.1 bk7y1gneyk.adobestats.io
        echo 127.0.0.1 dx0nvmv4hz.adobestats.io
        echo 127.0.0.1 eyiu19jd5w.adobestats.io
        echo 127.0.0.1 561r5c3bz1.adobestats.io
        echo 127.0.0.1 54cu4v5twu.adobestats.io
        echo 127.0.0.1 6eidhihhci.adobestats.io
        echo 127.0.0.1 31q40256l4.adobestats.io
        echo 127.0.0.1 bs2yhuojzm.adobestats.io
        echo 127.0.0.1 p50zgina3e.adobestats.io
        echo 127.0.0.1 yri0bsu0ak.adobestats.io
        echo 127.0.0.1 zu8yy3jkaz.adobestats.io
        echo 127.0.0.1 m59cps6x3n.adobestats.io
        echo 127.0.0.1 kgj0gsg3cf.adobestats.io
        echo 127.0.0.1 uf0onoepoe.adobestats.io
        echo 127.0.0.1 28t4psttw7.adobestats.io
        echo 127.0.0.1 hjs70w1pdi.adobestats.io
        echo 127.0.0.1 klw4np5a1x.adobestats.io
        echo 127.0.0.1 lz2x4rks1u.adobestats.io
        echo 127.0.0.1 pc6sk9bygv.adobestats.io
        echo 127.0.0.1 t9phy8ywkd.adobestats.io
        echo 127.0.0.1 dfnm3epsb7.adobestats.io
        echo 127.0.0.1 5ky0dijg73.adobestats.io
        echo 127.0.0.1 124hzdrtoi.adobestats.io
        echo 127.0.0.1 69rxfbohle.adobestats.io
        echo 127.0.0.1 9uffo0j6wj.adobestats.io
        echo 127.0.0.1 kwi5n2ruax.adobestats.io
        echo 127.0.0.1 nh8wam2qd9.adobestats.io
        echo 127.0.0.1 rm3xrk61n1.adobestats.io
        echo 127.0.0.1 rmnia8d0tr.adobestats.io
        echo 127.0.0.1 vrz9w7o7yv.adobestats.io
        echo 127.0.0.1 5m62o8ud26.adobestats.io
        echo 127.0.0.1 esx6aswt5e.adobestats.io
        echo 127.0.0.1 hwfqhlenbg.adobestats.io
        echo 127.0.0.1 je5ufnklzs.adobestats.io
        echo 127.0.0.1 jmx50quqz0.adobestats.io
        echo 127.0.0.1 jsxfc5yij1.adobestats.io
        echo 127.0.0.1 vfsjlgw02v.adobestats.io
        echo 127.0.0.1 yshuhythub.adobestats.io
        echo 127.0.0.1 zrbzvc9mel.adobestats.io
        echo 127.0.0.1 rj669kv2lc.adobestats.io
        echo 127.0.0.1 agxqobl83f.adobestats.io
        echo 127.0.0.1 zr60t8ia88.adobestats.io
        echo 127.0.0.1 a1y2b7wsna.adobestats.io
        echo 127.0.0.1 0n8wirm0nv.adobestats.io
        echo 127.0.0.1 17vpu0xkm6.adobestats.io
        echo 127.0.0.1 1ngcws40i2.adobestats.io
        echo 127.0.0.1 1qwiekvkux.adobestats.io
        echo 127.0.0.1 1tw2l9x7xb.adobestats.io
        echo 127.0.0.1 1unk1rv07w.adobestats.io
        echo 127.0.0.1 1xuyy0mk2p.adobestats.io
        echo 127.0.0.1 220zxtbjjl.adobestats.io
        echo 127.0.0.1 2eiuxr4ky7.adobestats.io
        echo 127.0.0.1 34modi5s5d.adobestats.io
        echo 127.0.0.1 34u96h6rvn.adobestats.io
        echo 127.0.0.1 3aqshzqv3w.adobestats.io
        echo 127.0.0.1 3jq65qgxeh.adobestats.io
        echo 127.0.0.1 3uyby7kphu.adobestats.io
        echo 127.0.0.1 3xuuprv9lg.adobestats.io
        echo 127.0.0.1 41yq116gxd.adobestats.io
        echo 127.0.0.1 44qnmxgtif.adobestats.io
        echo 127.0.0.1 4fmzz4au8r.adobestats.io
        echo 127.0.0.1 4l6gggpz15.adobestats.io
        echo 127.0.0.1 4yw5exucf6.adobestats.io
        echo 127.0.0.1 5pawwgngcc.adobestats.io
        echo 127.0.0.1 5zcrcdpvlp.adobestats.io
        echo 127.0.0.1 6dnh2pnz6e.adobestats.io
        echo 127.0.0.1 6mmsqon7y7.adobestats.io
        echo 127.0.0.1 6purj8tuwe.adobestats.io
        echo 127.0.0.1 6qkk0k4e9n.adobestats.io
        echo 127.0.0.1 6t38sdao5e.adobestats.io
        echo 127.0.0.1 6y6ozj4sot.adobestats.io
        echo 127.0.0.1 6zknqfiyev.adobestats.io
        echo 127.0.0.1 79j7psfqg5.adobestats.io
        echo 127.0.0.1 7k1t5im229.adobestats.io
        echo 127.0.0.1 7tu619a87v.adobestats.io
        echo 127.0.0.1 83x20gw5jk.adobestats.io
        echo 127.0.0.1 8tegcsplp5.adobestats.io
        echo 127.0.0.1 98c6c096dd.adobestats.io
        echo 127.0.0.1 98yu7gk4m3.adobestats.io
        echo 127.0.0.1 9g12qgnfe4.adobestats.io
        echo 127.0.0.1 9orhsmzhzs.adobestats.io
        echo 127.0.0.1 9wm8di7ifk.adobestats.io
        echo 127.0.0.1 a3cgga0v52.adobestats.io
        echo 127.0.0.1 a9ctb1jmbv.adobestats.io
        echo 127.0.0.1 ag0ak456at.adobestats.io
        echo 127.0.0.1 ah5otkl8ie.adobestats.io
        echo 127.0.0.1 altz51db7t.adobestats.io
        echo 127.0.0.1 anl33sxvkb.adobestats.io
        echo 127.0.0.1 bbraowhh29.adobestats.io
        echo 127.0.0.1 bjooauydoa.adobestats.io
        echo 127.0.0.1 bk8pzmo8g4.adobestats.io
        echo 127.0.0.1 bpvcty7ry7.adobestats.io
        echo 127.0.0.1 c474kdh1ky.adobestats.io
        echo 127.0.0.1 c4dpyxapo7.adobestats.io
        echo 127.0.0.1 cde0alxs25.adobestats.io
        echo 127.0.0.1 d101mw99xq.adobestats.io
        echo 127.0.0.1 d2ke1291mx.adobestats.io
        echo 127.0.0.1 d6zco8is6l.adobestats.io
        echo 127.0.0.1 dru0w44scl.adobestats.io
        echo 127.0.0.1 dsj4bsmk6i.adobestats.io
        echo 127.0.0.1 dymfhyu5t7.adobestats.io
        echo 127.0.0.1 ebvf40engd.adobestats.io
        echo 127.0.0.1 eqo0sr8daw.adobestats.io
        echo 127.0.0.1 eu927m40hm.adobestats.io
        echo 127.0.0.1 ffirm4ruur.adobestats.io
        echo 127.0.0.1 fm8m3wxufy.adobestats.io
        echo 127.0.0.1 fw6x2fs3fr.adobestats.io
        echo 127.0.0.1 g0rhyhkd7l.adobestats.io
        echo 127.0.0.1 gwbpood8w4.adobestats.io
        echo 127.0.0.1 hf6s5jdv95.adobestats.io
        echo 127.0.0.1 hijfpxclgz.adobestats.io
        echo 127.0.0.1 hmonvr006v.adobestats.io
        echo 127.0.0.1 hnk7phkxtg.adobestats.io
        echo 127.0.0.1 hq0mnwz735.adobestats.io
        echo 127.0.0.1 i4x0voa7ns.adobestats.io
        echo 127.0.0.1 i6gl29bvy6.adobestats.io
        echo 127.0.0.1 ijl01wuoed.adobestats.io
        echo 127.0.0.1 iw4sp0v9h3.adobestats.io
        echo 127.0.0.1 izke0wrq9n.adobestats.io
        echo 127.0.0.1 j0qztjp9ep.adobestats.io
        echo 127.0.0.1 j134yk6hv5.adobestats.io
        echo 127.0.0.1 j14y4uzge7.adobestats.io
        echo 127.0.0.1 j5vsm79i8a.adobestats.io
        echo 127.0.0.1 jatil41mhk.adobestats.io
        echo 127.0.0.1 jfb7fqf90c.adobestats.io
        echo 127.0.0.1 jir97hss11.adobestats.io
        echo 127.0.0.1 jsspeczo2f.adobestats.io
        echo 127.0.0.1 jwonv590qs.adobestats.io
        echo 127.0.0.1 jye4987hyr.adobestats.io
        echo 127.0.0.1 k9cyzt2wha.adobestats.io
        echo 127.0.0.1 kbdgy1yszf.adobestats.io
        echo 127.0.0.1 kjhzwuhcel.adobestats.io
        echo 127.0.0.1 kvi8uopy6f.adobestats.io
        echo 127.0.0.1 kvn19sesfx.adobestats.io
        echo 127.0.0.1 ll8xjr580v.adobestats.io
        echo 127.0.0.1 llnh72p5m3.adobestats.io
        echo 127.0.0.1 ltjlscpozx.adobestats.io
        echo 127.0.0.1 lv5yrjxh6i.adobestats.io
        echo 127.0.0.1 m95pt874uw.adobestats.io
        echo 127.0.0.1 mge8tcrsbr.adobestats.io
        echo 127.0.0.1 mid2473ggd.adobestats.io
        echo 127.0.0.1 mme5z7vvqy.adobestats.io
        echo 127.0.0.1 n0yaid7q47.adobestats.io
        echo 127.0.0.1 n17cast4au.adobestats.io
        echo 127.0.0.1 n78vmdxqwc.adobestats.io
        echo 127.0.0.1 nhs5jfxg10.adobestats.io
        echo 127.0.0.1 no95ceu36c.adobestats.io
        echo 127.0.0.1 o1qtkpin3e.adobestats.io
        echo 127.0.0.1 oee5i55vyo.adobestats.io
        echo 127.0.0.1 oh41yzugiz.adobestats.io
        echo 127.0.0.1 ok9sn4bf8f.adobestats.io
        echo 127.0.0.1 om2h3oklke.adobestats.io
        echo 127.0.0.1 p3lj3o9h1s.adobestats.io
        echo 127.0.0.1 p3m760solq.adobestats.io
        echo 127.0.0.1 pdb7v5ul5q.adobestats.io
        echo 127.0.0.1 pf80yxt5md.adobestats.io
        echo 127.0.0.1 psc20x5pmv.adobestats.io
        echo 127.0.0.1 px8vklwioh.adobestats.io
        echo 127.0.0.1 qmyqpp3xs3.adobestats.io
        echo 127.0.0.1 qn2ex1zblg.adobestats.io
        echo 127.0.0.1 qp5bivnlrp.adobestats.io
        echo 127.0.0.1 qqyyhr3eqr.adobestats.io
        echo 127.0.0.1 qttaz1hur3.adobestats.io
        echo 127.0.0.1 qxc5z5sqkv.adobestats.io
        echo 127.0.0.1 r1lqxul5sr.adobestats.io
        echo 127.0.0.1 riiohpqnpf.adobestats.io
        echo 127.0.0.1 rlo1n6mv52.adobestats.io
        echo 127.0.0.1 s7odt342lo.adobestats.io
        echo 127.0.0.1 sa4visje3j.adobestats.io
        echo 127.0.0.1 sbzo5r4687.adobestats.io
        echo 127.0.0.1 sfmzkcuf2f.adobestats.io
        echo 127.0.0.1 tcxqcguhww.adobestats.io
        echo 127.0.0.1 tf3an24xls.adobestats.io
        echo 127.0.0.1 tprqy2lgua.adobestats.io
        echo 127.0.0.1 trc2fpy0j4.adobestats.io
        echo 127.0.0.1 tyradj47rp.adobestats.io
        echo 127.0.0.1 ua0pnr1x8v.adobestats.io
        echo 127.0.0.1 uo6uihbs9y.adobestats.io
        echo 127.0.0.1 uqshzexj7y.adobestats.io
        echo 127.0.0.1 uroc9kxpcb.adobestats.io
        echo 127.0.0.1 uytor2bsee.adobestats.io
        echo 127.0.0.1 v5nweiv7nf.adobestats.io
        echo 127.0.0.1 vp7ih9xoxg.adobestats.io
        echo 127.0.0.1 vqiktmz3k1.adobestats.io
        echo 127.0.0.1 vqrc5mq1tm.adobestats.io
        echo 127.0.0.1 vr1i32txj7.adobestats.io
        echo 127.0.0.1 vr25z2lfqx.adobestats.io
        echo 127.0.0.1 vvzbv1ba9r.adobestats.io
        echo 127.0.0.1 w8x0780324.adobestats.io
        echo 127.0.0.1 wjoxlf5x2z.adobestats.io
        echo 127.0.0.1 wtooadkup9.adobestats.io
        echo 127.0.0.1 wz8kjkd9gc.adobestats.io
        echo 127.0.0.1 x5cupsunjc.adobestats.io
        echo 127.0.0.1 x8kb03c0jr.adobestats.io
        echo 127.0.0.1 x8thl73e7u.adobestats.io
        echo 127.0.0.1 xm8abqacqz.adobestats.io
        echo 127.0.0.1 xqh2khegrf.adobestats.io
        echo 127.0.0.1 y53h2xkr61.adobestats.io
        echo 127.0.0.1 y8f3hhzhsk.adobestats.io
        echo 127.0.0.1 yaxne83fvv.adobestats.io
        echo 127.0.0.1 z2cez9qgcl.adobestats.io
        echo 127.0.0.1 z2yohmd1jm.adobestats.io
        echo 127.0.0.1 z3shmocdp4.adobestats.io
        echo 127.0.0.1 zfzx6hae4g.adobestats.io
        echo 127.0.0.1 zooyvml70k.adobestats.io
        echo 127.0.0.1 zqr7f445uc.adobestats.io
        echo 127.0.0.1 zz8r2o83on.adobestats.io
        echo 127.0.0.1 6ll72mpyxv.adobestats.io
        echo 127.0.0.1 g6elufzgx7.adobestats.io
        echo 127.0.0.1 gdtbhgs27n.adobestats.io
        echo 127.0.0.1 hciylk3wpv.adobestats.io
        echo 127.0.0.1 m8c5gtovwb.adobestats.io
        echo 127.0.0.1 411r4c18df.adobestats.io
        echo 127.0.0.1 475ao55klh.adobestats.io
        echo 127.0.0.1 c0cczlv877.adobestats.io
        echo 127.0.0.1 fsx0pbg4rz.adobestats.io
        echo 127.0.0.1 powfb7xi5v.adobestats.io
        echo 127.0.0.1 h3hqd6gjkd.adobestats.io
        echo 127.0.0.1 bvcj3prq1u.adobestats.io
        echo 127.0.0.1 0k6cw37ajl.adobestats.io
        echo 127.0.0.1 15phzfr05l.adobestats.io
        echo 127.0.0.1 2os6jhr955.adobestats.io
        echo 127.0.0.1 3rm6l6bqwd.adobestats.io
        echo 127.0.0.1 42fkk06z8c.adobestats.io
        echo 127.0.0.1 45gnbb50sn.adobestats.io
        echo 127.0.0.1 6482jlr7qo.adobestats.io
        echo 127.0.0.1 7lj6w2xxew.adobestats.io
        echo 127.0.0.1 8eptecerpq.adobestats.io
        echo 127.0.0.1 9k4qeathc0.adobestats.io
        echo 127.0.0.1 9yod0aafmi.adobestats.io
        echo 127.0.0.1 dr1wq4uepg.adobestats.io
        echo 127.0.0.1 i48z07b7gr.adobestats.io
        echo 127.0.0.1 me7z7bchov.adobestats.io
        echo 127.0.0.1 mvnfbgfx93.adobestats.io
        echo 127.0.0.1 nj9rqrql3b.adobestats.io
        echo 127.0.0.1 ns6ckzkjzg.adobestats.io
        echo 127.0.0.1 ouovuyeiee.adobestats.io
        echo 127.0.0.1 tld9di3jxu.adobestats.io
        echo 127.0.0.1 xa8g202i4u.adobestats.io
        echo 127.0.0.1 z83qksw5cq.adobestats.io
        echo 127.0.0.1 9mblf9n5zf.adobestats.io
        echo 127.0.0.1 be5d7iw6y1.adobestats.io
        echo 127.0.0.1 cxqenfk6in.adobestats.io
        echo 127.0.0.1 cim9wvs3is.adobestats.io
        echo 127.0.0.1 ar1hqm61sk.adobestats.io
        echo 127.0.0.1 iqhvrdhql4.adobestats.io
        echo 127.0.0.1 cducupwlaq.adobestats.io
        echo 127.0.0.1 sap3m7umfu.adobestats.io
        echo 127.0.0.1 ay8wypezvi.adobestats.io
        echo 127.0.0.1 1j3muid89l.adobestats.io
        echo 127.0.0.1 8167gz60t1.adobestats.io
        echo 127.0.0.1 2bns2f5eza.adobestats.io
        echo 127.0.0.1 2c3bqjchr6.adobestats.io
        echo 127.0.0.1 49vfady5kf.adobestats.io
        echo 127.0.0.1 7v0i13wiuf.adobestats.io
        echo 127.0.0.1 ak1ow4e0u3.adobestats.io
        echo 127.0.0.1 f8m1p3tltt.adobestats.io
        echo 127.0.0.1 l6uu15bwug.adobestats.io
        echo 127.0.0.1 rtfuwp21b3.adobestats.io
        echo 127.0.0.1 s8liwh6vbn.adobestats.io
        echo 127.0.0.1 ok02isdwcx.adobestats.io
        echo 127.0.0.1 c72tusw5wi.adobestats.io
        echo 127.0.0.1 dqaytc21nb.adobestats.io
        echo 127.0.0.1 gm2ai4nsfq.adobestats.io
        echo 127.0.0.1 hs6dwhuiwh.adobestats.io
        echo 127.0.0.1 kst1t43sji.adobestats.io
        echo 127.0.0.1 x12wor9jo6.adobestats.io
        echo 127.0.0.1 xgj8lmrcy6.adobestats.io
        echo 127.0.0.1 6unmig6t9w.adobestats.io
        echo 127.0.0.1 8nft9ke95j.adobestats.io
        echo 127.0.0.1 9sg9gr4zf4.adobestats.io
        echo 127.0.0.1 tagtjqcvqg.adobestats.io
        echo 127.0.0.1 ztxgqqizv7.adobestats.io
        echo 127.0.0.1 7mw85h5tv4.adobestats.io
        echo 127.0.0.1 cfh5v77fsy.adobestats.io
        echo 127.0.0.1 dobw5hakm0.adobestats.io
        echo 127.0.0.1 08n59yhbxn.adobestats.io
        echo 127.0.0.1 0p73385wa6.adobestats.io
        echo 127.0.0.1 0vrs1f5fso.adobestats.io
        echo 127.0.0.1 5et944c3kg.adobestats.io
        echo 127.0.0.1 610o7ktxw7.adobestats.io
        echo 127.0.0.1 b8qwvscik0.adobestats.io
        echo 127.0.0.1 cvl65mxwmh.adobestats.io
        echo 127.0.0.1 dtt06hnkyj.adobestats.io
        echo 127.0.0.1 fg7bb8gi6d.adobestats.io
        echo 127.0.0.1 iy304996hm.adobestats.io
        echo 127.0.0.1 lp4og15wl5.adobestats.io
        echo 127.0.0.1 nxq02alk63.adobestats.io
        echo 127.0.0.1 ofgajs60g1.adobestats.io
        echo 127.0.0.1 om52ny8l9s.adobestats.io
        echo 127.0.0.1 s14z1kt85g.adobestats.io
        echo 127.0.0.1 tyqs8bsps8.adobestats.io
        echo 127.0.0.1 vvpexgmc5t.adobestats.io
        echo 127.0.0.1 w3ffpxhbn6.adobestats.io
        echo 127.0.0.1 w58drkayqf.adobestats.io
        echo 127.0.0.1 w8mvrujj91.adobestats.io
        echo 127.0.0.1 wjpmg2uott.adobestats.io
        echo 127.0.0.1 xljz63k33x.adobestats.io
        echo 127.0.0.1 7micpuqiwp.adobestats.io
        echo 127.0.0.1 2lb39igrph.adobestats.io
        echo 127.0.0.1 3zgi4mscuk.adobestats.io
        echo 127.0.0.1 elf5yl77ju.adobestats.io
        echo 127.0.0.1 ktb8rx6uhe.adobestats.io
        echo 127.0.0.1 heufuideue.adobestats.io
        echo 127.0.0.1 xq68npgl4w.adobestats.io
        echo 127.0.0.1 vnm70hlbn4.adobestats.io
        echo 127.0.0.1 p4hiwy76wl.adobestats.io
        echo 127.0.0.1 q7i4awui0j.adobestats.io
        echo 127.0.0.1 soirhk7bm2.adobestats.io
        echo 127.0.0.1 0789i4f3cq.adobestats.io
        echo 127.0.0.1 827x3zvk4q.adobestats.io
        echo 127.0.0.1 8ljcntz31v.adobestats.io
        echo 127.0.0.1 95yojg6epq.adobestats.io
        echo 127.0.0.1 9wcrtdzcti.adobestats.io
        echo 127.0.0.1 a3dxeq2iq9.adobestats.io
        echo 127.0.0.1 hrfn4gru1j.adobestats.io
        echo 127.0.0.1 kx8yghodgl.adobestats.io
        echo 127.0.0.1 olh5t1ccns.adobestats.io
        echo 127.0.0.1 svcgy434g6.adobestats.io
        echo 127.0.0.1 uwr2upexhs.adobestats.io
        echo 127.0.0.1 wk0sculz2x.adobestats.io
        echo 127.0.0.1 xbhspynj8t.adobestats.io
        echo 127.0.0.1 xod1t4qsyk.adobestats.io
        echo 127.0.0.1 iu7mq0jcce.adobestats.io
        echo 127.0.0.1 tdatxzi3t4.adobestats.io
        echo 127.0.0.1 rptowanjjh.adobestats.io
        echo 127.0.0.1 3cnu7l5q8s.adobestats.io
        echo 127.0.0.1 ow1o9yr32j.adobestats.io
        echo 127.0.0.1 bc27a8e3zw.adobestats.io
        echo 127.0.0.1 ok6tbgxfta.adobestats.io
        echo 127.0.0.1 9nqvoa544j.adobestats.io
        echo 127.0.0.1 arzggvbs37.adobestats.io
        echo 127.0.0.1 d8hof9a6gg.adobestats.io
        echo 127.0.0.1 qh0htdwe2n.adobestats.io
        echo 127.0.0.1 fu9wr8tk0u.adobestats.io
        echo 127.0.0.1 0ss1vovh4a.adobestats.io
        echo 127.0.0.1 15ousmguga.adobestats.io
        echo 127.0.0.1 3oidzvonpa.adobestats.io
        echo 127.0.0.1 5pjcqccrcu.adobestats.io
        echo 127.0.0.1 75ffpy5iio.adobestats.io
        echo 127.0.0.1 7fj42ny0sd.adobestats.io
        echo 127.0.0.1 drwizwikc0.adobestats.io
        echo 127.0.0.1 fl34tml8is.adobestats.io
        echo 127.0.0.1 kd4c3z4xbz.adobestats.io
        echo 127.0.0.1 ksw6oyvdk6.adobestats.io
        echo 127.0.0.1 l91nnnkmbi.adobestats.io
        echo 127.0.0.1 ln3pv36xx8.adobestats.io
        echo 127.0.0.1 m5cgk2pkdn.adobestats.io
        echo 127.0.0.1 nj66fd4dzr.adobestats.io
        echo 127.0.0.1 nl00xmmmn5.adobestats.io
        echo 127.0.0.1 wn9kta1iw4.adobestats.io
        echo 127.0.0.1 x3sszs7ihy.adobestats.io
        echo 127.0.0.1 nrenlhdc1t.adobestats.io
        echo 127.0.0.1 6nbt0kofc7.adobestats.io
        echo 127.0.0.1 kmqhqhs02w.adobestats.io
        echo 127.0.0.1 wdyav7y3rf.adobestats.io
        echo 127.0.0.1 3ysvacl1hb.adobestats.io
        echo 127.0.0.1 bqbvmlmtmo.adobestats.io
        echo 127.0.0.1 zn0o46rt48.adobestats.io
        echo 127.0.0.1 8mtavkaq40.adobestats.io
        echo 127.0.0.1 52h0nva0wa.adobestats.io
        echo 127.0.0.1 4t5jyh9fkk.adobestats.io
        echo 127.0.0.1 hen2jsru7c.adobestats.io
        echo 127.0.0.1 6tpqsy07cp.adobestats.io
        echo 127.0.0.1 0andkf1e8e.adobestats.io
        echo 127.0.0.1 2kc4lqhpto.adobestats.io
        echo 127.0.0.1 43q1uykg1z.adobestats.io
        echo 127.0.0.1 7zak80l8ic.adobestats.io
        echo 127.0.0.1 9dal0pbsx3.adobestats.io
        echo 127.0.0.1 9rcgbke6qx.adobestats.io
        echo 127.0.0.1 cwejcdduvp.adobestats.io
        echo 127.0.0.1 dq1gubixz7.adobestats.io
        echo 127.0.0.1 fc2k38te2m.adobestats.io
        echo 127.0.0.1 i1j2plx3mv.adobestats.io
        echo 127.0.0.1 lnosso28q5.adobestats.io
        echo 127.0.0.1 npt74s16x9.adobestats.io
        echo 127.0.0.1 o6pk3ypjcf.adobestats.io
        echo 127.0.0.1 pcmdl6zcfd.adobestats.io
        echo 127.0.0.1 q0z6ycmvhl.adobestats.io
        echo 127.0.0.1 quptxdg94y.adobestats.io
        echo 127.0.0.1 s4y2s7r9ah.adobestats.io
        echo 127.0.0.1 yajkeabyrj.adobestats.io
        echo 127.0.0.1 r9qg11e83v.adobestats.io
        echo 127.0.0.1 13hceguz11.adobestats.io
        echo 127.0.0.1 4xosvsrdto.adobestats.io
        echo 127.0.0.1 72p3yx09zx.adobestats.io
        echo 127.0.0.1 7gu7j31tn3.adobestats.io
        echo 127.0.0.1 hob0cz1xnx.adobestats.io
        echo 127.0.0.1 6woibl6fiu.adobestats.io
        echo 127.0.0.1 jh34ro8dm2.adobestats.io
        echo 127.0.0.1 sz2edaz2s9.adobestats.io
        echo 127.0.0.1 4s6bg7xces.adobestats.io
        echo 127.0.0.1 3d5rp7oyng.adobestats.io
        echo 127.0.0.1 5dec9025sr.adobestats.io
        echo 127.0.0.1 5muggmgxyb.adobestats.io
        echo 127.0.0.1 94enlu8vov.adobestats.io
        echo 127.0.0.1 9pa13v8uko.adobestats.io
        echo 127.0.0.1 csb8usj9o4.adobestats.io
        echo 127.0.0.1 dxegvh5wpp.adobestats.io
        echo 127.0.0.1 itiabkzm7h.adobestats.io
        echo 127.0.0.1 jsusbknzle.adobestats.io
        echo 127.0.0.1 tzbl46vv9o.adobestats.io
        echo 127.0.0.1 v5zm23ixg2.adobestats.io
        echo 127.0.0.1 w9m8uwm145.adobestats.io
        echo 127.0.0.1 zf37mp80xx.adobestats.io
        echo 127.0.0.1 gyt27lbjb3.adobestats.io
        echo 127.0.0.1 3m3e8ccqyo.adobestats.io
        echo 127.0.0.1 2sug8qxjag.adobestats.io
        echo 127.0.0.1 36ivntopuj.adobestats.io
        echo 127.0.0.1 1eqkbrjz78.adobestats.io
        echo 127.0.0.1 szvbv5h62r.adobestats.io
        echo 127.0.0.1 zf1aegmmle.adobestats.io
        echo 127.0.0.1 50lifxkein.adobestats.io
        echo 127.0.0.1 dfwv44wffr.adobestats.io
        echo 127.0.0.1 qwzzhqpliv.adobestats.io
        echo 127.0.0.1 0wcraxg290.adobestats.io
        echo 127.0.0.1 gpd3r2mkgs.adobestats.io
        echo 127.0.0.1 116n6tkxyr.adobestats.io
        echo 127.0.0.1 3nkkaf8h85.adobestats.io
        echo 127.0.0.1 55oguiniw8.adobestats.io
        echo 127.0.0.1 e1tyeiimw3.adobestats.io
        echo 127.0.0.1 g7zh7zqzqx.adobestats.io
        echo 127.0.0.1 gglnjgxaia.adobestats.io
        echo 127.0.0.1 h33a7kps0t.adobestats.io
        echo 127.0.0.1 jewn0nrrp8.adobestats.io
        echo 127.0.0.1 r7sawld5l6.adobestats.io
        echo 127.0.0.1 vodh16neme.adobestats.io
        echo 127.0.0.1 wntfgdo4ki.adobestats.io
        echo 127.0.0.1 x9u2jsesk0.adobestats.io
        echo 127.0.0.1 xsn76p7ntx.adobestats.io
        echo 127.0.0.1 xz9xjlyw58.adobestats.io
        echo 127.0.0.1 as73qhl83n.adobestats.io
        echo 127.0.0.1 b0giyj3mc1.adobestats.io
        echo 127.0.0.1 f9554salkg.adobestats.io
        echo 127.0.0.1 i487nlno13.adobestats.io
        echo 127.0.0.1 qx2t3lrpmg.adobestats.io
        echo 127.0.0.1 r0exxqftud.adobestats.io
        echo 127.0.0.1 spbuswk2di.adobestats.io
        echo 127.0.0.1 swxs9c0fpt.adobestats.io
        echo 127.0.0.1 v7esmx1n0s.adobestats.io
        echo 127.0.0.1 zglaizubbj.adobestats.io
        echo 127.0.0.1 22wqqv6b23.adobestats.io
        echo 127.0.0.1 5jdb1nfklf.adobestats.io
        echo 127.0.0.1 6glym36rbb.adobestats.io
        echo 127.0.0.1 6h8391pvf8.adobestats.io
        echo 127.0.0.1 c675s4pigj.adobestats.io
        echo 127.0.0.1 c8pyxo4r20.adobestats.io
        echo 127.0.0.1 co9sg87h3h.adobestats.io
        echo 127.0.0.1 f8wflegco1.adobestats.io
        echo 127.0.0.1 g6ld7orx5r.adobestats.io
        echo 127.0.0.1 r00r33ldza.adobestats.io
        echo 127.0.0.1 scmnpedxm0.adobestats.io
        echo 127.0.0.1 slx5l73jwh.adobestats.io
        echo 127.0.0.1 w8yfgti2yd.adobestats.io
        echo 127.0.0.1 yljkdk5tky.adobestats.io
        echo 127.0.0.1 0oydr1f856.adobestats.io
        echo 127.0.0.1 3ea8nnv3fo.adobestats.io
        echo 127.0.0.1 4j225l63ny.adobestats.io
        echo 127.0.0.1 4pbmn87uov.adobestats.io
        echo 127.0.0.1 8z20kcq3af.adobestats.io
        echo 127.0.0.1 bp5qqybokw.adobestats.io
        echo 127.0.0.1 dri0xipdj1.adobestats.io
        echo 127.0.0.1 e8yny99m61.adobestats.io
        echo 127.0.0.1 etqjl6s9m9.adobestats.io
        echo 127.0.0.1 iyuzq3njtk.adobestats.io
        echo 127.0.0.1 k2zeiskfro.adobestats.io
        echo 127.0.0.1 kk6mqz4ho1.adobestats.io
        echo 127.0.0.1 ltby3lmge7.adobestats.io
        echo 127.0.0.1 m07jtnnega.adobestats.io
        echo 127.0.0.1 o9617jdaiw.adobestats.io
        echo 127.0.0.1 ry9atn2zzw.adobestats.io
        echo 127.0.0.1 t8nxhdgbcb.adobestats.io
        echo 127.0.0.1 yhxcdjy2st.adobestats.io
        echo 127.0.0.1 1yzch4f7fj.adobestats.io
        echo 127.0.0.1 2dym9ld8t4.adobestats.io
        echo 127.0.0.1 7857z7jy1n.adobestats.io
        echo 127.0.0.1 917wzppd6w.adobestats.io
        echo 127.0.0.1 acakpm3wmd.adobestats.io
        echo 127.0.0.1 ah0uf3uzwe.adobestats.io
        echo 127.0.0.1 anllgxlrgl.adobestats.io
        echo 127.0.0.1 ar3zpq1idw.adobestats.io
        echo 127.0.0.1 as15ffplma.adobestats.io
        echo 127.0.0.1 b343x3kjgp.adobestats.io
        echo 127.0.0.1 b4ur7jk78w.adobestats.io
        echo 127.0.0.1 c7udtzsk2j.adobestats.io
        echo 127.0.0.1 dt549nqpx7.adobestats.io
        echo 127.0.0.1 f7ul6vs4ha.adobestats.io
        echo 127.0.0.1 hbejpf1qou.adobestats.io
        echo 127.0.0.1 s6195z8x2q.adobestats.io
        echo 127.0.0.1 smtcbgh2n7.adobestats.io
        echo 127.0.0.1 v5f89yjtcw.adobestats.io
        echo 127.0.0.1 x66v4qn2t7.adobestats.io
        echo 127.0.0.1 yvbzqwn2gz.adobestats.io
        echo 127.0.0.1 1ompyaokc3.adobestats.io
        echo 127.0.0.1 2ent6j0ret.adobestats.io
        echo 127.0.0.1 7860w7avqe.adobestats.io
        echo 127.0.0.1 kqs7x93q8r.adobestats.io
        echo 127.0.0.1 now8wpo1bv.adobestats.io
        echo 127.0.0.1 oeab9s6dtf.adobestats.io
        echo 127.0.0.1 p4apxcgh7b.adobestats.io
        echo 127.0.0.1 rs2deio0ks.adobestats.io
        echo 127.0.0.1 wfyeckyxxx.adobestats.io
        echo 127.0.0.1 xngv0345gb.adobestats.io
        echo 127.0.0.1 5nae7ued1i.adobestats.io
        echo 127.0.0.1 74jqw6xdam.adobestats.io
        echo 127.0.0.1 9xxyu4ncc9.adobestats.io
        echo 127.0.0.1 ckh0swnp4c.adobestats.io
        echo 127.0.0.1 dr02lso5fh.adobestats.io
        echo 127.0.0.1 et3x020m0i.adobestats.io
        echo 127.0.0.1 g58jqxdh3y.adobestats.io
        echo 127.0.0.1 j7wq25n7dy.adobestats.io
        echo 127.0.0.1 a69wv3f4j3.adobestats.io
        echo 127.0.0.1 jwi6q78hu2.adobestats.io
        echo 127.0.0.1 nw3ft2wlrn.adobestats.io
        echo 127.0.0.1 yykww43js1.adobestats.io
        echo 127.0.0.1 12ihfrf869.adobestats.io
        echo 127.0.0.1 a5dtr1c4er.adobestats.io
        echo 127.0.0.1 ajs31fsy2t.adobestats.io
        echo 127.0.0.1 mi9rav314a.adobestats.io
        echo 127.0.0.1 z66m01zo11.adobestats.io
        echo 127.0.0.1 vd8bjo50bv.adobestats.io
        echo 127.0.0.1 4f1b1vqcfi.adobestats.io
        echo 127.0.0.1 ci5yrifbog.adobestats.io
        echo 127.0.0.1 vn4waib0dk.adobestats.io
        echo 127.0.0.1 1i09xck9hj.adobestats.io
        echo 127.0.0.1 3reg39xtkp.adobestats.io
        echo 127.0.0.1 quij2u03a1.adobestats.io
        echo 127.0.0.1 49xq1olxsn.adobestats.io
        echo 127.0.0.1 flutt9urxr.adobestats.io
        echo 127.0.0.1 36ai1uk1z7.adobestats.io
        echo 127.0.0.1 5amul9liob.adobestats.io
        echo 127.0.0.1 ecsdxf3wl3.adobestats.io
        echo 127.0.0.1 v62vpzg2av.adobestats.io
        echo 127.0.0.1 a1815.dscr.akamai.net
        echo 127.0.0.1 ims-na1.adobelogin.com.cdn.cloudflare.net
        echo 127.0.0.1 o1383653.ingest.sentry.io
        echo 127.0.0.1 wtl71c0ylo.adobestats.io
        echo 127.0.0.1 3d5vic7so2.adobestats.io
        echo 127.0.0.1 o987771.ingest.us.sentry.io
        echo 127.0.0.1 rekkvg49.mw1i8.adobestats.io
        echo 127.0.0.1 y1sg2131f84.mw1i8.adobestats.io
        echo 127.0.0.1 o987771.ingest.us.sentry.io
        echo 127.0.0.1 a1815.dscr.akamai.net
        echo 127.0.0.1 3d5vic7so2.adobestats.io
        echo 127.0.0.1 ims-na1.adobelogin.com.cdn.cloudflare.net
        echo 127.0.0.1 o1383653.ingest.sentry.io
        echo 127.0.0.1 wtl71c0ylo.adobestats.io
        echo 127.0.0.1 jgletrkp.mw1i8.adobestats.io
        
    ) > "%tempHosts%"
) else (
    echo:     [OK] Da tai danh sach tu GitHub thanh cong.
)

:: Tiến hành trộn vào file Hosts hệ thống
echo:     ==^> Dang ghi du lieu vao file Hosts...
powershell -NoProfile -Command ^
    "$h='C:\Windows\System32\drivers\etc\hosts'; $w=Get-Content '%tempHosts%'; $c=Get-Content $h; ^
    $s='#region Adobe Block'; $e='#endregion'; ^
    if($c -contains $s){$start=$c.IndexOf($s); $end=$c.IndexOf($e); $c=$c[0..($start-1)] + $c[($end+1)..$c.Length]}; ^
    Set-Content $h ($c + $s + $w + $e) -Force"

:: Dọn dẹp file tạm
if exist "%tempHosts%" del /f "%tempHosts%"
echo.
echo:     ==^> Da hoan tat cap nhat Hosts.
timeout /t 2 >nul

:: --- KHOI PHUC ANTIVIRUS VA DON DEP ---
echo:     ==^> Dang bat lai bao ve va don dep he thong...
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $false" >nul 2>&1
powershell -Command "Remove-MpPreference -ExclusionPath '%source%'" >nul 2>&1
rmdir /s /q "%source%"
:: --------------------------------------

echo:     ________________________________________________________________________
echo:                             HOAN THANH KICH HOAT!
echo:     ________________________________________________________________________
echo.
pause
goto acrobat

:ExtraSubmenu
cls
echo [1] Sao luu file | [2] Tat Updater | [3] Tat CollabSync | [0] Quay lai
choice /C:1230 /N
if %errorlevel%==1 (
    for %%P in ("%path64%" "%path32%") do if exist "%%~P\Acrobat.exe" (for %%F in (acrotray.exe Acrobat.dll acrodistdll.dll) do copy "%%~P\%%F" "%%~P\%%F.bak" >nul)
    echo Da sao luu. & pause & goto ExtraSubmenu
)
if %errorlevel%==2 goto DisableUpdater
if %errorlevel%==3 (
    for %%P in ("%path64%" "%path32%") do if exist "%%~P\AdobeCollabSync.exe" move /y "%%~P\AdobeCollabSync.exe" "%%~P\AdobeCollabSync.exe.bak" >nul
    echo Da chan CollabSync. & pause & goto ExtraSubmenu
)
if %errorlevel%==4 goto acrobat

:RestoreDefaultsSubmenu
cls
echo [1] Khoi phuc file goc | [2] Bat Updater | [3] Bat Crash/Collab | [0] Quay lai
choice /C:1230 /N
if %errorlevel%==1 (
    for %%P in ("%path64%" "%path32%") do if exist "%%~P\Acrobat.exe" (for %%F in (acrotray.exe Acrobat.dll acrodistdll.dll) do if exist "%%~P\%%F.bak" copy /y "%%~P\%%F.bak" "%%~P\%%F" & del "%%~P\%%F.bak")
    echo Da khoi phuc. & pause & goto RestoreDefaultsSubmenu
)
if %errorlevel%==2 (
    sc config "AdobeARMservice" start= auto & sc start "AdobeARMservice"
    echo Da bat Updater. & pause & goto RestoreDefaultsSubmenu
)
if %errorlevel%==3 (
    for %%P in ("%path64%" "%path32%") do (
        if exist "%%~P\Adobe Crash Processor.exe.bak" move /y "%%~P\Adobe Crash Processor.exe.bak" "%%~P\Adobe Crash Processor.exe" >nul
        if exist "%%~P\AdobeCollabSync.exe.bak" move /y "%%~P\AdobeCollabSync.exe.bak" "%%~P\AdobeCollabSync.exe" >nul
    )
    echo Da khoi phuc dich vu ngam. & pause & goto RestoreDefaultsSubmenu
)
if %errorlevel%==4 goto acrobat
pause
goto menu


:MENU_OFFICE
cls
set "setupDir=C:\OfficeInstall"
if not exist "%setupDir%" mkdir "%setupDir%"
cd /d "%setupDir%"
set "setupUrl=https://raw.githubusercontent.com/itsup-ftel/tools/refs/heads/main/file/setup.exe"
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('%setupUrl%', 'setup.exe')" >nul 2>&1

if not exist "setup.exe" (
    cls
    echo [!] LOI: Khong the tai file setup.exe. Kiem tra mang!
    pause & exit /b
)
set "prodID="
set "channel=Current"
echo ====================================================
echo        %Y%[ BUOC 1: CHON PHIEN BAN OFFICE]%Res%
echo ====================================================
echo 1. Office 365 (Retail)
echo 2. Office 2024 (Retail)
echo 3. Office 2024 (LTSC - Volume)
echo 4. Office 2021 (Retail)
echo 5. Office 2021 (LTSC - Volume)
echo 6. Office 2019 (Retail)
echo 7. Office 2019 (Volume)
echo 8. Office 2016 (Retail)
echo 9. THOAT CAI DAT
echo ====================================================
set /p choice_ver="Nhap lua chon (1-9): "

:: Cập nhật chuẩn ProductID và Channel
if "%choice_ver%"=="1" (set "prodID=O365ProPlusRetail" & set "verName=Office 365" & set "channel=Current")
if "%choice_ver%"=="2" (set "prodID=ProPlus2024Retail" & set "verName=Office 2024" & set "channel=Current")
if "%choice_ver%"=="3" (set "prodID=ProPlus2024Volume" & set "verName=Office 2024 VL" & set "channel=PerpetualVL2024")
if "%choice_ver%"=="4" (set "prodID=ProPlus2021Retail" & set "verName=Office 2021" & set "channel=Current")
if "%choice_ver%"=="5" (set "prodID=ProPlus2021Volume" & set "verName=Office 2021 VL" & set "channel=PerpetualVL2021")
if "%choice_ver%"=="6" (set "prodID=ProPlus2019Retail" & set "verName=Office 2019" & set "channel=Current")
if "%choice_ver%"=="7" (set "prodID=ProPlus2019Volume" & set "verName=Office 2019 VL" & set "channel=PerpetualVL2019")
if "%choice_ver%"=="8" (set "prodID=ProPlusRetail" & set "verName=Office 2016" & set "channel=Current")
if "%choice_ver%"=="9" goto menu else goto menu
if not defined prodID (goto MENU_OFFICE)

:: --- BƯỚC 2: CHỌN CHẾ ĐỘ CÀI ---
:MENU_MODE
cls
echo ====================================================
echo             BUOC 2: CHON CHE DO CAI DAT
echo       (Dang chon: %verName%)
echo ====================================================
echo 1. Cai day du (Full Suite)
echo 2. Cai rut gon (Chi Word, Excel, PP, Teams, Outlook)
echo 0. QUAY LAI BUOC 1
echo ====================================================
set /p choice_mode="Nhap lua chon (0-2): "
if "%choice_mode%"=="0" goto MENU_OFFICE
if "%choice_mode%"=="1" (set "modeName=Full")
if "%choice_mode%"=="2" (set "modeName=Lite")
if not defined modeName (goto MENU_MODE)

:: --- BƯỚC 3: CHỌN KIẾN TRÚC ---
:MENU_BIT
cls
echo ====================================================
echo             BUOC 3: CHON KIEN TRUC (BIT)
echo ====================================================
echo 1. Phien ban 64-bit (Khuyen dung)
echo 2. Phien ban 32-bit (Cho may cu)
echo 0. QUAY LAI BUOC 2
echo ====================================================
set /p choice_bit="Nhap lua chon (0-2): "
if "%choice_bit%"=="0" goto MENU_MODE
if "%choice_bit%"=="1" (set "bitVer=64") else (set "bitVer=32")

:: --- PHẦN 4: TẠO FILE CONFIG XML ---
cls
echo [+] Dang khoi tao file cau hinh XML...
(
echo ^<Configuration^>
echo   ^<Add OfficeClientEdition="%bitVer%" Channel="%channel%"^>
echo     ^<Product ID="%prodID%"^>
echo       ^<Language ID="en-us" /^>
echo       ^<Language ID="vi-vn" /^>
if "%choice_mode%"=="2" (
    echo       ^<ExcludeApp ID="Access" /^>
    echo       ^<ExcludeApp ID="Groove" /^>
    echo       ^<ExcludeApp ID="Lync" /^>
    echo       ^<ExcludeApp ID="OneDrive" /^>
    echo       ^<ExcludeApp ID="OneNote" /^>
    echo       ^<ExcludeApp ID="Publisher" /^>
)
echo     ^</Product^>
echo   ^</Add^>
echo   ^<RemoveMSI /^>
echo   ^<Display Level="Full" AcceptEULA="TRUE" /^>
echo   ^<Property Name="AUTOACTIVATE" Value="1" /^>
echo ^</Configuration^>
) > configuration.xml

:: --- PHẦN 5: CHẠY CÀI ĐẶT ---
cls
echo ====================================================
echo   DANG TIEN HANH CAI DAT %verName%...
echo ====================================================
setup.exe /configure configuration.xml

:: Xóa file tạm
if exist "configuration.xml" del /f /q "configuration.xml"

echo.
echo ====================================================
echo   CAI DAT %verName% THANH CONG! 
echo   BAN MUON ACTIVE NGAY KHONG?
echo ====================================================
echo 1. Co (Yeu cau Internet)
echo 2. Khong, thoat ve menu chinh
echo ====================================================
set /p choice_act="Lua chon cua ban (1-2): "
if "%choice_act%"=="1" goto :activeMAS else goto MENU_OFFICE
pause > nul
goto menu

:systemInfo
cls
echo %C%[ DANG LAY THONG TIN HE THONG... ]%Res%
powershell -NoProfile -Command ^
    "$os = Get-CimInstance Win32_OperatingSystem;" ^
    "$cpu = Get-CimInstance Win32_Processor;" ^
    "$cs = Get-CimInstance Win32_ComputerSystem;" ^
    "$vga = Get-CimInstance Win32_VideoController;" ^
    "echo '---------------------------------------------------';" ^
    "echo ('Ten may:          ' + $cs.Name);" ^
    "echo ('Nha san xuat:     ' + $cs.Manufacturer);" ^
    "echo ('Dong may:         ' + $cs.Model);" ^
    "echo ('He dieu hanh:     ' + $os.Caption + ' ' + $os.OSArchitecture);" ^
    "echo ('Version:          ' + $os.Version);" ^
    "echo ('CPU:              ' + $cpu.Name);" ^
    "echo ('RAM:              ' + [math]::Round($cs.TotalPhysicalMemory/1GB, 2) + ' GB');" ^
    "echo ('VGA:              ' + $vga.Name);" ^
    "echo ('Ngay cai Win:     ' + $os.InstallDate);" ^
    "echo ('Boot gan nhat:    ' + $os.LastBootUpTime);" ^
    "echo '---------------------------------------------------';"
pause
goto menu

:ramInfo
cls
echo %C%[ THONG TIN BO NHO RAM]%Res%
powershell -Command "$m = Get-CimInstance Win32_PhysicalMemory; $a = Get-CimInstance Win32_PhysicalMemoryArray; $used = ($m | Measure-Object).Count; $total = $a.MemoryDevices; Write-Host '[ KIEM TRA KHE CAM RAM ]' -Fore Cyan; Write-Host ('Tong: ' + $total + ' | Da cam: ' + $used + ' | Trong: ' + ($total - $used)) -Fore Yellow; Write-Host '[ CHI TIET TUNG THANH ]' -Fore Cyan; $m | Select-Object @{N='Khe (Slot)';E={$_.DeviceLocator}}, @{N='Dung luong (GB)';E={$_.Capacity/1GB}}, @{N='Toc do (MHz)';E={$_.ConfiguredClockSpeed}}, @{N='Hang';E={$_.Manufacturer}}, @{N='Seri';E={$_.PartNumber.Trim()}} | Format-Table -AutoSize"
pause
goto menu

:hddInfo
cls
echo %C%==================================================%Res%
echo          %Y%[ THONG TIN CHI TIET O CUNG]%Res%
echo %C%==================================================%Res%
powershell -command "Get-PhysicalDisk | Select-Object FriendlyName, SerialNumber, MediaType, @{Name='Size(GB)';Expression={[Math]::Round($_.Size/1GB,2)}}, HealthStatus | Out-String"
echo %C%--------------------------------------------------%Res%
echo %G%Lay thong tin hoan tat!%Res%
pause
goto menu

:doublePing
cls
echo %Y%Dang phan tich Gateway...%Res%
for /f "tokens=*" %%g in ('powershell -NoProfile -Command "(Get-NetRoute -DestinationPrefix '0.0.0.0/0' | Select-Object -First 1).NextHop"') do set "GW=%%g"
if "%GW%"=="" (
    echo %R%[Loi] Khong tim thay Default Gateway.%Res%
    pause
    goto menu
)
start "PING-GATEWAY" cmd /c "color 0E & title PING GATEWAY: %GW% & ping %GW% -t"
start "PING-GOOGLE" cmd /c "color 0B & title PING GOOGLE: 8.8.8.8 & ping 8.8.8.8 -t"
goto menu

:getMacSN
cls
echo %C%[ THONG TIN CARD MANG, MAC ADDRESS ]%Res%
powershell -command "Get-NetAdapter | Select-Object Name, Status, MacAddress | ft -AutoSize"

echo %C%[ SERIAL NUMBER ]%Res%
powershell -command "Get-CimInstance Win32_Bios | Select-Object -ExpandProperty SerialNumber"

echo.
echo %G%[ BAN CO MUON ]%Res%
echo 1. Thay doi MAC Address (Nhap tay)
echo 2. Reset MAC ve mac dinh (Goc)
echo 3. Thoat ve menu chinh
set /p subOpt="Nhap lua chon (1-3): "

if "%subOpt%"=="1" goto changeMac
if "%subOpt%"=="2" goto resetMac
if "%subOpt%"=="3" goto menu
goto getMacSN

:changeMac
cls
echo %C%[ THAY DOI MAC ADDRESS ]%Res%
powershell -command "$adapters = Get-NetAdapter; for ($i=0; $i -lt $adapters.Count; $i++) { Write-Host ('{0}. {1} (MAC: {2})' -f ($i+1), $adapters[$i].Name, $adapters[$i].MacAddress) }"
echo.
set /p choice="Chon so thu tu card mang: "

:: Dung PowerShell de ep nguoi dung nhap dung 12 ky tu hex
for /f "usebackq tokens=*" %%a in (`powershell -command ^
    "do {" ^
    "  $m = Read-Host 'Nhap MAC moi (12 ky tu, vd: 021122334455)'; " ^
    "  if ($m -match '^[0-9A-Fa-f]{12}$') { $m; $ok=$true } " ^
    "  else { Write-Host 'Loi: MAC phai du 12 ky tu (0-9, A-F). Hay nhap lai!' -ForegroundColor Red; $ok=$false }" ^
    "} while (-not $ok)"`) do set "newMac=%%a"

set "task=change"
goto executeMac

:resetMac
cls
echo %C%[ RESET MAC ADDRESS VE MAC DINH ]%Res%
powershell -command "$adapters = Get-NetAdapter; for ($i=0; $i -lt $adapters.Count; $i++) { Write-Host ('{0}. {1} (MAC: {2})' -f ($i+1), $adapters[$i].Name, $adapters[$i].MacAddress) }"
echo.
set /p choice="Chon so thu tu card mang muon Reset: "
set "newMac="
set "task=reset"
goto executeMac

:executeMac
echo Dang thuc thi, vui long cho...
powershell -command ^
    "$choice = %choice% - 1;" ^
    "$adapters = Get-NetAdapter;" ^
    "if ($choice -ge 0 -and $choice -lt $adapters.Count) {" ^
    "   $adapter = $adapters[$choice];" ^
    "   $regPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\' + $adapter.DeviceID.PadLeft(4,'0');" ^
    "   if ('%task%' -eq 'change') {" ^
    "       Set-ItemProperty -Path $regPath -Name 'NetworkAddress' -Value '%newMac%' -ErrorAction SilentlyContinue;" ^
    "       Write-Host '--- Da thiet lap MAC moi ---' -ForegroundColor Cyan;" ^
    "   } else {" ^
    "       Remove-ItemProperty -Path $regPath -Name 'NetworkAddress' -ErrorAction SilentlyContinue;" ^
    "       Write-Host '--- Da xoa MAC tuy chinh (ve Mac dinh) ---' -ForegroundColor Cyan;" ^
    "   }" ^
    "   Write-Host 'Dang khoi dong lai card mang...';" ^
    "   Disable-NetAdapter -Name $adapter.Name -Confirm:$false;" ^
    "   Enable-NetAdapter -Name $adapter.Name -Confirm:$false;" ^
    "   Write-Host '--- HOAN TAT ---' -ForegroundColor Green;" ^
    "} else { Write-Host '--- LOI: Lua chon sai ---' -ForegroundColor Red; }"
pause
goto getMacSN

:cleanJunk
cls
echo %Yellow%Dang don dep file rac he thong...%Reset%
:: Chuyen sang dung PowerShell de xoa file 
powershell -command "& {Remove-Item -Path 'C:\Windows\Temp\*' -Recurse -Force -EA SilentlyContinue; Remove-Item -Path 'C:\Users\$env:UserName\AppData\Local\Temp\*' -Recurse -Force -EA SilentlyContinue; Remove-Item -Path 'C:\Windows\Prefetch\*' -Recurse -Force -EA SilentlyContinue}"
echo.
cleanmgr /sagerun:1
echo %Green%Da don dep xong!%Reset%
pause
goto menu

:repairSys
cls
echo %Y%Dang chay SFC ^& DISM...%Res%
sfc /scannow
dism /online /cleanup-image /restorehealth
pause
goto menu

:exportSys
cls
systeminfo > "%userprofile%\Desktop\SysInfo.txt"
echo %G%Da xuat file SysInfo.txt ra Desktop!%Reset%
pause
goto menu

:wuchange
cls
echo =========================================
echo   %Y%[ QUAN LY WINDOWS UPDATE (REG)]%Res%
echo =========================================
echo [1] TAT HAN Windows Update (Registry)
echo [2] MO LAI Windows Update
echo [3] RESET Windows Update
echo [0] Thoat ve Menu chinh
echo =========================================

set /p choice="Nhap lua chon cua ban (0-2): "

if "%choice%"=="1" goto DisWU
if "%choice%"=="2" goto EnaWU
if "%choice%"=="3" goto resetWU
if "%choice%"=="0" goto menu
goto menu

:DisWU
echo Dang thuc hien tat Windows Update...
powershell -command "Set-Service wuauserv -StartupType Disabled; Stop-Service wuauserv -Force; Reg add 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' /v NoAutoUpdate /t REG_DWORD /d 1 /f"
echo.
echo DA TAT HAN TRONG REGISTRY.
pause
goto menu

:EnaWU
echo Dang thuc hien mo Windows Update...
powershell -command "Reg delete 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' /v NoAutoUpdate /f; Set-Service wuauserv -StartupType Manual; Start-Service wuauserv"
echo.
echo DA MO LAI VA XOA KHOA REGISTRY.
pause
goto menu

:resetWU
cls
net stop wuauserv & net stop cryptSvc & net stop bits & net stop msiserver
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old >nul 2>&1
net start wuauserv & net start cryptSvc & net start bits & net start msiserver
echo %G%Reset Windows Update thanh cong!%Res%
pause
goto menu

:resExp
taskkill /f /im explorer.exe & start explorer.exe
goto menu

:Navigation
cls
echo =======================================================
echo         %Y%[ HE THONG QUAN LY MANG TU DONG]%Res%
echo =======================================================
echo 1. Xem thong tin IP chi tiet
echo 2. Lam moi mang (FlushDNS + Renew)
echo 3. Cau hinh IP/DNS (Chon card mang)
echo 4. Thoat ve menu chinh
echo =======================================================
set /p choice="Chon (1-4): "

if %choice%==1 goto getIP
if %choice%==2 goto refreshNet
if %choice%==3 goto selectCard
if %choice%==4 goto menu
goto Navigation

:getIP
cls
echo =======================================================
echo           %Y%[THONG TIN MANG CHI TIET]%Res%
echo =======================================================
powershell -Command "Get-NetIPConfiguration | ForEach-Object { [PSCustomObject]@{ 'Interface'=$_.InterfaceAlias; 'IP Address'=$_.IPv4Address.IPAddress; 'Gateway'=$_.IPv4DefaultGateway.NextHop; 'DNS Servers'=$_.DNSServer.ServerAddresses -join ', ' } } | Format-Table -AutoSize"
echo -------------------------------------------------------
pause
goto Navigation

:refreshNet
cls
echo [*] Dang lam moi DNS va IP...
ipconfig /flushdns
ipconfig /release
ipconfig /renew
echo [OK] Hoan tat!
pause
goto Navigation

:selectCard
cls
echo  %Y%[ DANH SACH CARD MANG DANG KET NOI ]%Res%
echo -------------------------------------------------------
set i=0
:: Sử dụng "delims=" để lấy trọn vẹn tên card kể cả khi có khoảng trắng
for /f "delims=" %%a in ('powershell -Command "Get-NetAdapter | Where-Object Status -eq 'Up' | Select-Object -ExpandProperty Name"') do (
    set /a i+=1
    set "card!i!=%%a"
    echo !i!. %%a
)

if %i%==0 (
    echo [!] Khong tim thay card mang nao dang ket noi.
    pause & goto Navigation
)

echo -------------------------------------------------------
set /p csel="Chon so thu tu card mang: "

:: Lấy giá trị từ mảng ảo card!i! dựa trên số người dùng nhập
set "interface="
for /l %%j in (1,1,%i%) do (
    if "%csel%"=="%%j" set "interface=!card%%j!"
)

if "!interface!"=="" (
    echo [!] Lua chon khong hop le.
    pause & goto selectCard
)
goto submenu

:submenu
cls
echo Card dang chon: [ %interface% ]
echo -------------------------------------------------------
echo 1. Dat IP Tinh (Static)
echo 2. Chuyen sang IP Dong (DHCP)
echo 3. Chi thay doi DNS (Google: 8.8.8.8)
echo 4. Thoat ve Menu chinh
echo -------------------------------------------------------
set /p subch="Chon (1-4): "

if %subch%==1 (
    set /p ip="Nhap IP: "
    set /p mask="Nhap Subnet Mask (Mac dinh: 255.255.255.0): "
    set /p gate="Nhap Gateway: "
    netsh interface ipv4 set address name="%interface%" static !ip! !mask! !gate%
    goto checkResult
)

if %subch%==2 (
    netsh interface ipv4 set address name="%interface%" source=dhcp
    netsh interface ipv4 set dns name="%interface%" source=dhcp
    goto checkResult
)

if %subch%==3 (
    netsh interface ipv4 set dns name="%interface%" static 8.8.8.8 primary
    netsh interface ipv4 add dns name="%interface%" 8.8.4.4 index=2
    goto checkResult
)

if %subch%==4 goto Navigation
goto submenu

:checkResult
echo [*] Dang kiem tra lai thiet lap...
timeout /t 2 >nul
powershell -Command "Get-NetIPConfiguration -InterfaceAlias '%interface%' | Select-Object InterfaceAlias, IPv4Address, IPv4DefaultGateway, DNSServer | Format-List"
echo [OK] Thao tac hoan tat!
pause
goto submenu

:checkport
cls
:: 1. Tai tcping.exe vao System32
if not exist "C:\Windows\System32\tcping.exe" (
    echo [+] Dang tai tcping.exe vao System32...
    powershell -Command "Start-BitsTransfer -Source 'https://raw.githubusercontent.com/itsup-ftel/tools/refs/heads/main/file/tcping.exe' -Destination 'C:\Windows\System32\tcping.exe'"
)

:: 2. Tai tracetcp.exe vao System32
if not exist "C:\Windows\System32\tracetcp.exe" (
    echo [+] Dang tai tracetcp.exe vao System32...
    powershell -Command "Start-BitsTransfer -Source 'https://raw.githubusercontent.com/itsup-ftel/tools/refs/heads/main/file/tracetcp.exe' -Destination 'C:\Windows\System32\tracetcp.exe'"
)
cls
echo ==========================================
echo     %Y%[CONG CU KIEM TRA KET NOI TCP]%Res%
echo ==========================================
echo 1. Chay TCPING (Ping lien tuc)
echo 2. Chay TRACERTCP (Do duong tung chang)
echo 3. CHAY DONG THOI CA 2 (2 Cua so moi)
echo 4. Thoat ve Menu chinh
echo ==========================================
set "choice="
set /p choice="Chon chuc nang (1-4): "

if "%choice%"=="1" goto TCPING
if "%choice%"=="2" goto TRACERTCP
if "%choice%"=="3" goto RUNBOTH
if "%choice%"=="4" goto menu
goto checkport

:TCPING
set "target="
set /p target="Nhap IP/Domain: "
if not defined target goto checkport
set /p port="Nhap Port (mac dinh 80): "
if "%port%"=="" set port=80
start "TCPING - %target%:%port%" cmd /k "tcping.exe -t %target% %port%"
pause
goto checkport

:TRACERTCP
set "target="
set /p target="Nhap IP/Domain: "
if not defined target goto checkport
set /p port="Nhap Port (mac dinh 80): "
if "%port%"=="" set port=80
start "TRACETCP - %target%:%port%" cmd /k "tracetcp.exe %target%:%port% -m 30"
pause
goto checkport

:RUNBOTH
set "target="
set /p target="Nhap IP/Domain: "
if not defined target goto checkport
set /p port="Nhap Port (mac dinh 80): "
if "%port%"=="" set port=80

echo [!] Dang mo 2 cua so moi...
:: Mo cua so 1 cho TCPING
start "TCPING - %target%:%port%" cmd /k "tcping.exe -t %target% %port%"
:: Mo cua so 2 cho TRACERTCP
start "TRACETCP - %target%:%port%" cmd /k "tracetcp.exe %target%:%port% -m 30"

echo [+] Da kich hoat xong.
pause
goto menu

:wifiPass
cls
netsh wlan show profiles
set /p ssid="Nhap ten Wi-Fi (SSID): "
netsh wlan show profile name="%ssid%" key=clear | findstr /C:"Key Content"
pause
goto menu

:netReset
cls
netsh winsock reset & netsh int ip reset
pause
goto menu

:runTasks
cls
echo ===============================
echo     %Y%[QUAN LY TAC VU]%Res%
echo ===============================
echo 1. Xem danh sach cac tac vu dang chay
echo 2. Ket thuc mot tac vu (Kill Task)
echo 3. Thoat ve Menu chinh
echo ===============================
set /p choice=Nhap lua chon cua ban (1-3): 

if "%choice%"=="1" goto showList
if "%choice%"=="2" goto killTask
if "%choice%"=="3" goto menu
goto runTasks

:showList
cls
tasklist
pause
goto runTasks

:killTask
cls
echo --- CAC TAC VU DANG CHAY ---
tasklist /nh /fo table
echo --------------------------------------------------
set /p target=Nhap Ten (vidu: notepad.exe) hoac PID de xoa (hoac 'b' de quay lai): 

if /i "%target%"=="b" goto runTasks

:: Thu kill theo ten, neu loi thi thu kill theo PID
taskkill /F /IM "%target%" 2>nul || taskkill /F /PID "%target%" 2>nul

if %errorlevel%==0 (
    echo [OK] Da xoa tac vu thành cong.
) else (
    echo [LOI] Khong tim thay hoac khong co quyen xoa.
)
pause
goto runTasks

:killTaskres
taskkill /f /fi "status eq not responding"
pause
goto menu

:listUsers
cls
echo ======================================================
echo          %Y%[ DANH SACH USER CHI TIET]%Res%
echo ======================================================
powershell -Command "Get-LocalUser | Select-Object Name, Enabled, Description | Format-Table -AutoSize"
echo ======================================================
echo.
echo 1. Ban co muon doi mat khau nguoi dung
echo 2. Thoat
echo -----------------------------------------
set /p chon="Moi ban chon (1-2): "
if "%chon%"=="1" goto changePass
if "%chon%"=="2" goto menu
goto menu

:changePass
cls
echo --- DOI MAT KHAU NGUOI DUNG ---
set /p username="Nhap ten User muon doi pass: "
set /p password="Nhap mat khau moi: "
echo Dang xu ly...
:: Lenh doi mat khau
net user "%username%" "%password"
if %errorLevel% == 0 (
    echo Doi mat khau cho user %username% thanh cong!
) else (
    echo Co loi xay ra (Sai ten user hoac khong du quyen).
) & goto menu
pause
goto menu

:listapp
cls
echo %C%[ CHUONG TRINH - UNG DUNG ]%Res%
powershell -command "Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -ne $null } | Select-Object @{Name='Ten ung dung';Expression={$_.DisplayName}}, @{Name='Phien ban';Expression={$_.DisplayVersion}}"
pause
goto menu

:restartSpooler
cls
net stop spooler & net start spooler
pause
goto menu

:clearQueue
cls
net stop spooler
del /Q /F /S "%systemroot%\System32\Spool\Printers\*.*"
net start spooler
echo %G%DA XOA SACH HANG CHO IN!%Res%
pause
goto menu

:printTest
cls
echo =========================================
echo     %Y%[ DANH SACH MAY IN HIEN CO]%Res%
echo =========================================

:: Lấy danh sách máy in và đánh số thứ tự
powershell -command "$printers = Get-Printer | Select-Object Name; for ($i=0; $i -lt $printers.Count; $i++) { write-host ('[' + ($i+1) + '] ' + $printers[$i].Name) }"

echo.
set /p choice="Nhap SO THU TU may in ban muon chon: "

:: Sử dụng PowerShell để lấy tên máy in dựa trên số thứ tự đã chọn
for /f "delims=" %%i in ('powershell -command "$printers = Get-Printer | Select-Object -ExpandProperty Name; $printers[%choice%-1]"') do set pname=%%i

if "%pname%"=="" (
    echo Lua chon khong hop le!
    pause
    goto printTest
)

echo.
echo Dang gui lenh in thu toi: %pname%
:: Thuc hien lenh in
powershell -command "Start-Process notepad.exe -ArgumentList '/pt', 'C:\Windows\win.ini', '%pname%'"

echo Hoan tat!
pause
goto menu

:listPrinters
cls
echo %C%[ CHI TIET MAY IN ]%Res%
powershell -command "Get-Printer | Select-Object Name, DriverName, PortName, Shared"
pause
goto menu



:restart
shutdown /r /t 0

:shutdown
shutdown /s /t 0

'@

$tempPath = "$env:TEMP\it_tool.bat"
$batchCode | Out-File -FilePath $tempPath -Encoding ascii
# Chay file va PowerShell se cho den khi file dong moi xoa
Start-Process $tempPath -Wait
if (Test-Path $tempPath) { Remove-Item $tempPath -Force }
