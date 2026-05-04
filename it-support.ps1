# it-support.ps1
$batchCode = @'
@echo off
title IT SUPPORT PROFESSIONAL TOOLKIT v2.6
mode con: cols=125 lines=42

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
echo   %G%=====================================================================================================================%Res%
echo                                         %W%IT SUPPORT PROFESSIONAL TOOLKIT - VERSION 8.9%Res%
echo   %G%=====================================================================================================================%Res%
echo.
echo      %Y%[ QUAN LY HE THONG ]%Res%               %C%[ MANG ^& INTERNET ]%Res%                %C%[ MAY IN (PRINTER) ]%Res%
echo.
echo      %G%01.%Res% Don dep file rac             %G%12.%Res% Get MAC ^& Serial SN          %G%22.%Res% Restart Print Spooler
echo      %G%02.%Res% Thong tin he thong           %G%13.%Res% Xem chi tiet IP Config       %G%23.%Res% Xoa lenh in bi ket
echo      %G%03.%Res% Sua loi SFC ^& DISM           %G%14.%Res% Flush DNS / Renew IP         %G%24.%Res% In thu trang Test Page
echo      %G%04.%Res% Xem Model may                %G%15.%Res% Double Ping (GW ^& 8.8)       %G%25.%Res% Liet ke cac may in
echo      %G%05.%Res% Thong tin RAM chi tiet       %G%16.%Res% Xem Pass Wi-Fi cu            
echo      %G%06.%Res% Thong tin CPU chi tiet       %G%17.%Res% Reset thiet lap mang         
echo      %G%07.%Res% Bao cao suc khoe Pin         %G%18.%Res% Liet ke cac Task             %Y%[ TRUY CAP NHANH (OPEN) ]%Res%
echo      %G%08.%Res% Xuat Info ra Desktop         %G%19.%Res% Dong ung dung treo           
echo      %G%09.%Res% Reset Windows Update         %G%20.%Res% Tat nhanh Chrome             %G%31.%Res% Control Panel
echo      %G%10.%Res% Restart Explorer             %G%21.%Res% Danh sach User may           %G%32.%Res% Task Manager
echo      %G%11.%Res% Kiem tra o cung (SMART)                                       %G%33.%Res% Services (msc)
echo.                                                                       %G%34.%Res% Device Manager
echo      %Y%[ BAN QUYEN - ACTIVE ]%Res%                                            %G%35.%Res% Print Management
echo      %G%40.%Res% %R%MO CONG CU ACTIVE (MAS)%Res%                                       %G%36.%Res% Network Connections
echo                                                                        %G%37.%Res% Registry Editor
echo      %Y%[ HE THONG ]%Res%                                                      %G%38.%Res% Advanced Firewall
echo      %R%[ R ]%Res% Restart PC   %R%[ S ]%Res% Shutdown PC                                 
echo      %W%[ 0 ] Thoat%Res%
echo   %G%=====================================================================================================================%Res%
set /p opt="  %W%>>> Lua chon cua ban: %Res%"

:: --- DIEU HUONG LOGIC ---
if /i "%opt%"=="1" goto cleanJunk
if /i "%opt%"=="01" goto cleanJunk
if /i "%opt%"=="2" goto systemInfo
if /i "%opt%"=="02" goto systemInfo
if /i "%opt%"=="3" goto repairSys
if /i "%opt%"=="03" goto repairSys
if /i "%opt%"=="4" goto getModel
if /i "%opt%"=="04" goto getModel
if /i "%opt%"=="5" goto ramInfo
if /i "%opt%"=="05" goto ramInfo
if /i "%opt%"=="6" goto cpuInfo
if /i "%opt%"=="06" goto cpuInfo
if /i "%opt%"=="7" goto battery
if /i "%opt%"=="07" goto battery
if /i "%opt%"=="8" goto exportSys
if /i "%opt%"=="08" goto exportSys
if /i "%opt%"=="9" goto resetWU
if /i "%opt%"=="09" goto resetWU
if /i "%opt%"=="10" goto resExp
if /i "%opt%"=="11" goto diskHealth
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
if /i "%opt%"=="31" start control & goto menu
if /i "%opt%"=="32" start taskmgr & goto menu
if /i "%opt%"=="33" start services.msc & goto menu
if /i "%opt%"=="34" start devmgmt.msc & goto menu
if /i "%opt%"=="35" start printmanagement.msc & goto menu
if /i "%opt%"=="36" start ncpa.cpl & goto menu
if /i "%opt%"=="37" start regedit & goto menu
if /i "%opt%"=="38" start wf.msc & goto menu
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

:systemInfo
cls
echo %C%[ DANG LAY THONG TIN HE THONG... ]%Res%
powershell -NoProfile -Command ^
    "$os = Get-CimInstance Win32_OperatingSystem;" ^
    "$cpu = Get-CimInstance Win32_Processor;" ^
    "$cs = Get-CimInstance Win32_ComputerSystem;" ^
    "echo '---------------------------------------------------';" ^
    "echo ('Ten may:          ' + $cs.Name);" ^
    "echo ('Nha san xuat:     ' + $cs.Manufacturer);" ^
    "echo ('Dong may:         ' + $cs.Model);" ^
    "echo ('He dieu hanh:     ' + $os.Caption + ' ' + $os.OSArchitecture);" ^
    "echo ('Version:          ' + $os.Version);" ^
    "echo ('CPU:              ' + $cpu.Name);" ^
    "echo ('RAM:              ' + [math]::Round($cs.TotalPhysicalMemory/1GB, 2) + ' GB');" ^
    "echo ('Ngay cai Win:     ' + $os.InstallDate);" ^
    "echo ('Boot gan nhat:    ' + $os.LastBootUpTime);" ^
    "echo '---------------------------------------------------';"
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
echo %Y%Dang don dep file rac he thong...%Res%
del /s /q /f "%temp%\*.*" >nul 2>&1
rd /s /q "%temp%" >nul 2>&1
mkdir "%temp%"
del /s /q /f "C:\Windows\Temp\*.*" >nul 2>&1
del /s /q /f "C:\Windows\Prefetch\*.*" >nul 2>&1
echo %G%Da don dep xong!%Res%
pause
goto menu

:repairSys
cls
echo %Y%Dang chay SFC ^& DISM...%Res%
sfc /scannow
dism /online /cleanup-image /restorehealth
pause
goto menu

:getModel
cls
powershell -command "Get-CimInstance Win32_ComputerSystem | Select-Object Manufacturer, Model"
pause
goto menu

:ramInfo
cls
echo %C%[ CHI TIET RAM ]%Res%
powershell -command "Get-CimInstance Win32_PhysicalMemory | Select-Object DeviceLocator, @{Name='Capacity(GB)';Expression={$_.Capacity / 1GB}}, Speed, Manufacturer"
pause
goto menu

:cpuInfo
cls
echo %C%[ CHI TIET CPU ]%Res%
powershell -command "Get-CimInstance Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors"
pause
goto menu

:exportSys
cls
systeminfo > "%userprofile%\Desktop\SysInfo.txt"
echo %G%Da xuat file SysInfo.txt ra Desktop!%Reset%
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

:diskHealth
cls
echo %C%[ TRANG THAI O CUNG - S.M.A.R.T ]%Res%
powershell -command "Get-CimInstance -Namespace root\wmi -ClassName MSStorageDriver_FailurePredictStatus | Select-Object InstanceName, PredictFailure"
pause
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

# Tạo file tạm và thực thi với quyền Admin
$tempPath = "$env:TEMP\it_tool.bat"
$batchCode | Out-File -FilePath $tempPath -Encoding ascii
Start-Process $tempPath -Verb RunAs -Wait
Remove-Item $tempPath
