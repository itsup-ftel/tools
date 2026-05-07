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
mode con: cols=150 lines=45

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
echo   %G%============================================================================================================================================%Res%
echo                                                 %W%IT SUPPORT PROFESSIONAL TOOLKIT - VERSION 26.5%Res%
echo   %G%============================================================================================================================================%Res%
echo.
echo       %Y%[ 1. HE THONG ]%Res%               %Y%[ 2. PHAN CUNG ]%Res%            %Y%[ 3. MANG ^& INTERNET ]%Res%      %Y%[ 4. MAY IN (PRINTER) ]%Res%
echo.
echo       %G%02.%Res% Xem thong so PC         %G%01.%Res% Don dep file rac        %G%12.%Res% Get MAC ^& SN card       %G%22.%Res% Restart Print Spooler
echo       %G%04.%Res% Kiem tra o cung         %G%03.%Res% Sua loi SFC ^& DISM     %G%13.%Res% Xem chi tiet IP Config   %G%23.%Res% Xoa lenh in bi ket
echo       %G%21.%Res% Danh sach User          %G%05.%Res% Kiem tra khe RAM        %G%14.%Res% Flush DNS / Renew IP     %G%24.%Res% In thu trang Test Page
echo       %G%26.%Res% Ung dung da cai dat     %G%09.%Res% On/Off Windows Update   %G%15.%Res% Double Ping (GW ^& 8.8)  %G%25.%Res% Liet ke d/s may in
echo       %G%--%Res% ----------------------   %G%10.%Res% Restart Explorer        %G%16.%Res% Xem Pass Wi-Fi cu        %G%--%Res% ----------------------
echo       %G%--%Res% ----------------------   %G%18.%Res% Liet ke cac Task        %G%17.%Res% Reset thiet lap mang     %G%--%Res% ----------------------
echo       %G%--%Res% ----------------------   %G%19.%Res% Dong ung dung treo      %G%--%Res% ----------------------    %G%--%Res% ----------------------
echo       %G%--%Res% ----------------------   %G%20.%Res% Tat nhanh Chrome        %G%--%Res% ----------------------    %G%--%Res% ----------------------
echo       %G%--%Res% ----------------------   %G%--%Res% ----------------------   %G%--%Res% ----------------------    %G%--%Res% ----------------------
echo.
echo       %C%[ 5. TRUY CAP NHANH 1 ]%Res%       %C%[ 6. TRUY CAP NHANH 2 ]%Res%     %C%[ 7. CAI DAT - KICH HOAT ]%Res%    %C%[ 8. LENH NHANH ]%Res%
echo.
echo       %G%31.%Res% Control Panel           %G%35.%Res% Print Management        %G%39.%Res% Cai dat OFFICE           %G%--%Res% ----------------------
echo       %G%32.%Res% Task Manager            %G%36.%Res% Network Connections     %G%40.%Res% %G%Active WIN/OFFICE%Res%  %G%--%Res% ----------------------
echo       %G%33.%Res% Services (msc)          %G%37.%Res% Registry Editor         %G%--%Res% ----------------------   %G%--%Res% ----------------------
echo       %G%34.%Res% Device Manager          %G%38.%Res% Advanced Firewall       %G%--%Res% ----------------------   %G%--%Res% ----------------------
echo       %G%39.%Res% Windows Settings        %G%41.%Res% Appwiz.cpl (Go App)     %G%--%Res% ----------------------   %G%--%Res% ----------------------
echo       %G%35.%Res% Print Management        %G%--%Res% ----------------------   %G%--%Res% ----------------------   %G%--%Res% ----------------------
echo       %G%36.%Res% Network Connections     %G%--%Res% ----------------------   %G%--%Res% ----------------------   %G%--%Res% ----------------------
echo       %G%37.%Res% Registry Editor         %G%--%Res% ----------------------   %G%--%Res% ----------------------   %G%--%Res% ----------------------
echo       %G%38.%Res% Advanced Firewall       %G%--%Res% ----------------------   %G%--%Res% ----------------------   %G%--%Res% ----------------------
echo.
echo      %R%[ R ]%Res% Khoi dong lai PC   %R%[ S ]%Res% Tat may PC                                 
echo      %W%[ 0 ] Thoat tool%Res%
echo   %G%============================================================================================================================================%Res%
set /p opt="  %W%>>> Lua chon cua ban: %Res%"

:: --- DIEU HUONG LOGIC ---
if /i "%opt%"=="1" goto cleanJunk
if /i "%opt%"=="01" goto cleanJunk
if /i "%opt%"=="2" goto systemInfo
if /i "%opt%"=="02" goto systemInfo
if /i "%opt%"=="3" goto repairSys
if /i "%opt%"=="03" goto repairSys
if /i "%opt%"=="4" goto hardwareInfo
if /i "%opt%"=="04" goto hardwareInfo
if /i "%opt%"=="5" goto ramInfo
if /i "%opt%"=="05" goto ramInfo
if /i "%opt%"=="6" goto cpuInfo
if /i "%opt%"=="06" goto cpuInfo
if /i "%opt%"=="7" goto battery
if /i "%opt%"=="07" goto battery
if /i "%opt%"=="8" goto exportSys
if /i "%opt%"=="08" goto exportSys
if /i "%opt%"=="9" goto wuchange
if /i "%opt%"=="09" goto wuchange
if /i "%opt%"=="10" goto resExp
if /i "%opt%"=="11" goto 
if /i "%opt%"=="12" goto getMacSN
if /i "%opt%"=="13" goto getIP
if /i "%opt%"=="14" goto flushDNS
if /i "%opt%"=="15" goto doublePing
if /i "%opt%"=="16" goto wifiPass
if /i "%opt%"=="17" goto netReset
if /i "%opt%"=="18" goto runTasks
if /i "%opt%"=="19" goto killTasks
if /i "%opt%"=="20" goto killChrome
if /i "%opt%"=="21" goto listUsers
if /i "%opt%"=="22" goto restartSpooler
if /i "%opt%"=="23" goto clearQueue
if /i "%opt%"=="24" goto printTest
if /i "%opt%"=="25" goto listPrinters
if /i "%opt%"=="26" goto listapp
if /i "%opt%"=="31" start control & goto menu
if /i "%opt%"=="32" start taskmgr & goto menu
if /i "%opt%"=="33" start services.msc & goto menu
if /i "%opt%"=="34" start devmgmt.msc & goto menu
if /i "%opt%"=="35" start printmanagement.msc & goto menu
if /i "%opt%"=="36" start ncpa.cpl & goto menu
if /i "%opt%"=="37" start regedit & goto menu
if /i "%opt%"=="38" start wf.msc & goto menu
if /i "%opt%"=="39" goto MENU_OFFICE
if /i "%opt%"=="40" goto activeMAS
if /i "%opt%"=="r" goto restart
if /i "%opt%"=="s" goto shutdown
if /i "%opt%"=="0" exit
goto menu

:: --- CAC HAM XU LY ---

:activeMAS
cls
echo %Y%=====================================================%Res%
echo        DANG KET NOI DEN MAY CHU MAS...
echo =====================================================%Res%
echo.
echo %C%Luu y: May tinh can co ket noi Internet.%Res%
echo.
:: Sua loi: Them goi powershell de CMD co the thuc thi lenh irm
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://get.activated.win | iex"
goto menu

:MENU_OFFICE
cls
set "setupDir=C:\OfficeInstall"
if not exist "%setupDir%" mkdir "%setupDir%"
cd /d "%setupDir%"
set "setupUrl=https://raw.githubusercontent.com/itsup-ftel/tools/refs/heads/main/setup.exe"
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('%setupUrl%', 'setup.exe')" >nul 2>&1

if not exist "setup.exe" (
    cls
    echo [!] LOI: Khong the tai file setup.exe. Kiem tra mang!
    pause & exit /b
)
set "prodID="
set "channel=Current"
echo ====================================================
echo             BUOC 1: CHON PHIEN BAN OFFICE
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
echo 2. Khong, quay lai Menu chinh
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
echo %C%[ THONG TIN PHAN CUNG CHI TIET RAM]%Res%
powershell -command "Get-CimInstance -ClassName Win32_PhysicalMemory | Format-Table Manufacturer, SerialNumber, ConfiguredClockSpeed, Capacity, DeviceLocator -AutoSize"
pause
goto menu

:hardwareInfo
cls
echo %C%==================================================%Res%
echo %Y%[ THONG TIN PHAN CUNG CHI TIET O CUNG]%Res%
echo %C%==================================================%Res%
powershell -command "Get-PhysicalDisk | Select-Object FriendlyName, SerialNumber, MediaType, @{Name='Size(GB)';Expression={[Math]::Round($_.Size/1GB,2)}}, HealthStatus | Out-String"
echo %C%--------------------------------------------------%Res%
echo %W%Lay thong tin hoan tat!%Res%
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
echo %C%[ MAC ADDRESS INFO ]%Res%
getmac /v /fo list
echo.
echo %C%[ HARDWARE SERIAL NUMBER ]%Res%
powershell -command "Get-CimInstance Win32_Bios | Select-Object -ExpandProperty SerialNumber"
echo %C%[ SYSTEM MODEL ]%Res%
powershell -command "Get-CimInstance Win32_ComputerSystem | Select-Object -ExpandProperty Model"
pause
goto menu

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
echo       QUAN LY WINDOWS UPDATE (REG)
echo =========================================
echo [1] TAT HAN Windows Update (Registry)
echo [2] MO LAI Windows Update
echo [3] RESET Windows Update
echo [0] TRO LAI MENU CHINH
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

:getIP
cls
ipconfig /all
pause
goto menu

:flushDNS
ipconfig /flushdns & ipconfig /renew
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
tasklist
pause
goto menu

:killTasks
taskkill /f /fi "status eq not responding"
pause
goto menu

:killChrome
taskkill /f /im chrome.exe /t
goto menu

:listUsers
net user
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
echo %C%Danh sach may in:%Res%
powershell -command "Get-Printer | Select-Object Name"
echo.
set /p pname="Nhap ten may in: "
powershell -command "Start-Process notepad.exe -ArgumentList '/p C:\Windows\win.ini' -Verb PrintTo $pname"
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
