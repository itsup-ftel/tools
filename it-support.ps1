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
echo      %G%5.%Res% Kiem tra Bitlocker   %G%11.%Res% Restart Explorer    %G%17.%Res% Xem Pass Wi-Fi       %G%23.%Res% ----14h44-------
echo      %G%6.%Res% Kiem tra             %G%12.%Res% Xu ly Task          %G%18.%Res% Reset Mang           %G%24.%Res% ---------------
echo.
echo     %C%[ 5. TRUY CAP ]%Res%        %C%[ 6. MO NHANH 2 ]%Res%       %C%[ 7. CAI DAT ]%Res%         %C%[ 8. FIX LOI AUTODESK ]%Res%
echo.
echo     %G%25.%Res% Control Panel        %G%30.%Res% Print Management    %G%35.%Res% Bo cai OFFICE        %G%40.%Res% Sao luu/ Phuc hoi
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
if /i "%opt%"=="40" goto saoluuphuchoi
if /i "%opt%"=="41" goto
if /i "%opt%"=="42" goto
if /i "%opt%"=="43" goto
if /i "%opt%"=="44" goto
if /i "%opt%"=="r" goto restart
if /i "%opt%"=="s" goto shutdown
if /i "%opt%"=="0" exit
goto menu

:: --- CAC HAM XU LY ---


:saoluuphuchoi
cls
set "backupPath=D:\Backup_System"
set "userProfile=%USERPROFILE%"
set "localApp=%LOCALAPPDATA%"
echo %C%================================================================================%Res%
echo %Y%                  CONG CU SAO LUU ^& PHUC HOI HE THONG%Res%
echo %C%================================================================================%Res%
echo.
echo    %Y%[1]%Res% %W%SAO LUU (Backup) - Dong ung dung, copy du lieu, kiem tra loi%Res%
echo    %Y%[2]%Res% %W%PHUC HOI (Restore) - Giai nen du lieu ve vi tri mac dinh%Res%
echo    %Y%[3]%Res% %W%CAU HINH - Thay doi noi luu (Hien tai: %G%%backupPath%%W%)%Res%
echo    %Y%[4]%Res% %R%THOAT VE MENU CHINH%Res%
echo.
echo %C%--------------------------------------------------------------------------------%Res%
set /p choice="%C%Moi ban chon (1-4): %Res%"

if "%choice%"=="1" goto BACKUP
if "%choice%"=="2" goto RESTORE
if "%choice%"=="3" goto SET_PATH
if "%choice%"=="4" goto menu
goto saoluuphuchoi

:BACKUP
cls
echo %Y%[>>>] DANG TIEN HANH SAO LUU...%Res%
echo.

:: 1. Buoc tat cac tien trinh dang khoa file
echo %C%[1/4]%Res% Dang dong cac ung dung dang chay...
taskkill /F /IM chrome.exe /IM msedge.exe /IM outlook.exe /IM coccoc.exe /IM browser.exe >nul 2>&1
timeout /t 2 >nul
echo %G%      [OK] Da giai phong cac file du lieu.%Res%

:: 2. Tao thu muc
if not exist "%backupPath%" mkdir "%backupPath%"

:: 3. Thuc hien copy (Co kiem tra loi tung buoc)
echo %C%[2/4]%Res% Dang sao luu thu muc ca nhan...
set "err="
xcopy "%userProfile%\Desktop" "%backupPath%\Desktop\" /E /I /H /Y /C /Q || set "err=1"
xcopy "%userProfile%\Documents" "%backupPath%\Documents\" /E /I /H /Y /C /Q || set "err=1"
xcopy "%userProfile%\Downloads" "%backupPath%\Downloads\" /E /I /H /Y /C /Q || set "err=1"

echo %C%[3/4]%Res% Dang sao luu du lieu Trinh duyet ^& Mail...
xcopy "%localApp%\Google\Chrome\User Data\Default" "%backupPath%\Browsers\Chrome\Default\" /E /I /H /Y /C /Q || set "err=1"
xcopy "%localApp%\Microsoft\Edge\User Data\Default" "%backupPath%\Browsers\Edge\Default\" /E /I /H /Y /C /Q || set "err=1"
xcopy "%userProfile%\Documents\Outlook Files" "%backupPath%\Mail\Outlook_Files\" /E /I /H /Y /C /Q || set "err=1"

echo %C%[4/4]%Res% Dang trich xuat Driver he thong...
dism /online /export-driver /destination:"%backupPath%\Drivers" >nul || set "err=1"

:: 4. Ket luan
echo.
if defined err (
    echo %R%================================================================================%Res%
    echo %R%[CANH BAO] Co mot vai tep tin khong the sao luu. Hay kiem tra lai!%Res%
    echo %R%================================================================================%Res%
) else (
    echo %G%================================================================================%Res%
    echo %G%[THANH CONG] Tat ca du lieu da an toan tai: %backupPath%%Res%
    echo %G%================================================================================%Res%
)
echo %W%He thong dang mo thu muc de ban kiem tra...%Res%
start "" "%backupPath%"
pause
goto saoluuphuchoi

:RESTORE
cls
echo %Y%[<<<] DANG TIEN HANH PHUC HOI DU LIEU...%Res%
echo.
if not exist "%backupPath%" (echo %R%[!] Khong tim thay nguon sao luu.%Res% & pause & goto saoluuphuchoi)

echo %C%[*]%Res% Dang dong cac ung dung truoc khi ghi de...
taskkill /F /IM chrome.exe /IM msedge.exe /IM outlook.exe >nul 2>&1

echo %C%[*]%Res% Dang tra du lieu ve vi tri goc...
xcopy "%backupPath%\Desktop" "%userProfile%\Desktop\" /E /I /H /Y /C /Q
xcopy "%backupPath%\Browsers\Chrome\Default" "%localApp%\Google\Chrome\User Data\Default\" /E /I /H /Y /C /Q
xcopy "%backupPath%\Browsers\Edge\Default" "%localApp%\Microsoft\Edge\User Data\Default\" /E /I /H /Y /C /Q

echo.
echo %G%[OK] Phuc hoi hoan tat!%Res%
pause
goto saoluuphuchoi

:SET_PATH
cls
echo %C%--- CAU HINH DUONG DAN LUU TRU ---%Res%
echo Nhap duong dan moi (Vi du: E:\MyBackup):
set /p backupPath="%Y%Duong dan: %Res%"
if not exist "%backupPath%" (
    echo %W%Thu muc chua ton tai, se duoc tao khi sao luu.%Res%
)
goto saoluuphuchoi


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
echo:                  %Y%[CAI DAT - KICH HOAT ACROBAT DC PRO]%Res%
echo:                              developed by -CongNV
echo:     ________________________________________________________________________ 
echo:         [1] FULL: Tai, Cai dat ^& Kich hoat tu dong
echo:         [2] Chi Kich hoat (Neu da cai san)
echo:         [3] Tuy chon mo rong
echo:         [4] Khoi phuc ve mac dinh
echo:     ________________________________________________________________________ 
echo:
echo:         [0] Thoat ve menu chinh
echo:     ________________________________________________________________________ 
echo.
choice /C:12340 /N
set "userChoice=%errorlevel%"

if %userChoice%==1 goto CheckBeforeDownload
if %userChoice%==2 goto DownloadPatch
if %userChoice%==3 goto ExtraSubmenu
if %userChoice%==4 goto RestoreDefaultsSubmenu
if %userChoice%==0 goto menu

:CheckBeforeDownload
cls
echo:     ==^> Dang kiem tra trang thai he thong...
if exist "%path64%\Acrobat.exe" (set "finalPath=%path64%" & goto FoundExisting)
if exist "%path32%\Acrobat.exe" (set "finalPath=%path32%" & goto FoundExisting)
goto DownloadInstall

:FoundExisting
echo:     Adobe Acrobat da duoc cai dat san tai: %finalPath%
echo:     Script se tu dong chuyen sang buoc KICH HOAT sau 3 giay...
timeout /t 3 >nul
goto DownloadPatch

:DownloadInstall
if exist "%source%" rmdir /s /q "%source%"
md "%source%"
cls
echo:     [==^> Dang tai Adobe Acrobat DC (x64)...]
curl --ssl-no-revoke --progress-bar -L -o "%source%\Acrobat.zip" https://trials.adobe.com/AdobeProducts/APRO/Acrobat_HelpX/win32/Acrobat_DC_Web_x64_WWMUI.zip

if not exist "%source%\Acrobat.zip" (
    echo [LOI] Khong the tai file. Kiem tra mang hoac Antivirus.
    pause & goto acrobat
)

echo:     [==^> Dang tam tat Windows Defender va loai tru thu muc tam...]
powershell -Command "Add-MpPreference -ExclusionPath '%source%'" >nul 2>&1
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true" >nul 2>&1

echo:     [==^> Dang giai nen Adobe Acrobat...]
powershell -Command "Expand-Archive -Path '%source%\Acrobat.zip' -DestinationPath '%source%' -Force"
del /f "%source%\Acrobat.zip"

echo:     [==^> Dang cai dat (Silent Mode)...]
start /wait "" "%source%\Adobe Acrobat\setup.exe" /quiet
goto DownloadPatch

:DownloadPatch
cls
if not exist "%source%" md "%source%"
echo:     [==^> Dang tai file Patch tu GitHub...]
curl --ssl-no-revoke --progress-bar -L -o "%source%\Patch.zip" https://github.com/GenP-V/Acropolis/releases/latest/download/AcrobatV.zip

powershell -Command "Add-MpPreference -ExclusionPath '%source%'" >nul 2>&1
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true" >nul 2>&1
timeout /t 2 /nobreak >nul

echo:     ==^> Dang giai nen Patch...
powershell -Command "Expand-Archive -Path '%source%\Patch.zip' -DestinationPath '%source%' -Force"

:ProcessPatch
echo:     [==^> Dang dung triet de cac tien trinh Adobe...]
powershell -Command "Stop-Process -Name 'Acrobat*', 'Adobe*', 'AcroTray*' -Force -ErrorAction SilentlyContinue"
timeout /t 2 >nul

for %%P in ("%path64%" "%path32%") do (
    if exist "%%~P\Acrobat.exe" (
        echo    - Dang xu ly tai: %%~P
        
        :: 1. Them thu muc cai dat vao Exclusion
        powershell -Command "Add-MpPreference -ExclusionPath '%%~P'" >nul 2>&1
        
        :: 2. Chiếm quyền file để tránh lỗi copy
        takeown /f "%%~P\Acrobat.dll" /a >nul 2>&1
        icacls "%%~P\Acrobat.dll" /grant administrators:F >nul 2>&1

        :: 3. Copy Patch de file
        for %%F in (acrotray.exe Acrobat.dll acrodistdll.dll) do (
            if exist "%%~P\%%F" if not exist "%%~P\%%F.bak" copy "%%~P\%%F" "%%~P\%%F.bak" >nul
            if exist "%source%\%%F" xcopy /y /h /r "%source%\%%F" "%%~P\" >nul
        )
        
        :: 4. Chan Firewall (Inbound & Outbound)
        echo    - Dang thiet lap Firewall Rules...
        netsh advfirewall firewall delete rule name="Block_Acrobat_Out" >nul 2>&1
        netsh advfirewall firewall delete rule name="Block_Acrobat_In" >nul 2>&1
        netsh advfirewall firewall add rule name="Block_Acrobat_Out" dir=out program="%%~P\Acrobat.exe" action=block >nul 2>&1
        netsh advfirewall firewall add rule name="Block_Acrobat_In" dir=in program="%%~P\Acrobat.exe" action=block >nul 2>&1
    )
)

:DisableUpdater
echo:     [==^> Dang vo hieu hoa dich vu cap nhat...]
sc config "AdobeARMservice" start= disabled >nul 2>&1
sc stop "AdobeARMservice" >nul 2>&1
schtasks /change /tn "AdobeGCInvoker-1.0" /disable >nul 2>&1 2>nul

:AddHosts
echo:     [==^> Dang cap nhat file Hosts...]
set "hostsURL=https://githubusercontent.com"
set "tempHosts=%TEMP%\adobe_hosts.txt"
curl --ssl-no-revoke -L -s -f -o "%tempHosts%" "%hostsURL%"
if not exist "%tempHosts%" (
    (echo 127.0.0.1 192.150.14.69 & echo 127.0.0.1 192.150.18.101) > "%tempHosts%"
)
powershell -NoProfile -Command "$h='C:\Windows\System32\drivers\etc\hosts'; $w=Get-Content '%tempHosts%'; $c=Get-Content $h; $s='#region Adobe Block'; $e='#endregion'; if($c -contains $s){$start=$c.IndexOf($s); $end=$c.IndexOf($e); $c=$c[0..($start-1)] + $c[($end+1)..$c.Length]}; Set-Content $h ($c + $s + $w + $e) -Force"

:Cleanup
echo:     [==^> Dang bat lai bao ve va don dep...]
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $false" >nul 2>&1
powershell -Command "Remove-MpPreference -ExclusionPath '%source%'" >nul 2>&1
if exist "%tempHosts%" del /f "%tempHosts%"
rmdir /s /q "%source%"

echo:     ________________________________________________________________________
echo:                          HOAN THANH KICH HOAT!
echo:     (Luu y: Thu muc cai dat da duoc loai tru khoi Windows Defender)
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
