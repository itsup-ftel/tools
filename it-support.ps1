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
echo       %Y%[ 1. HE THONG ]%Res%               %Y%[ 2. PHAN CUNG ]%Res%             %Y%[ 3. MANG ^& INTERNET ]%Res%         %Y%[ 4. MAY IN (PRINTER) ]%Res%
echo.
echo       %G%01.%Res% Don dep file rac        %G%04.%Res% Cau hinh (CPU/RAM)       %G%12.%Res% Get MAC ^& Serial SN      %G%22.%Res% Restart Print Spooler
echo       %G%02.%Res% Thong tin Win           %G%07.%Res% Bao cao suc khoe Pin    %G%13.%Res% Xem chi tiet IP Config   %G%23.%Res% Xoa lenh in bi kiet
echo       %G%03.%Res% Sua loi SFC ^& DISM      %G%11.%Res% Kiem tra o cung SMART   %G%14.%Res% Flush DNS / Renew IP     %G%24.%Res% In thu trang Test Page
echo       %G%09.%Res% Reset Windows Update    %G%08.%Res% Xuat Info ra Desktop    %G%15.%Res% Double Ping (GW ^& 8.8)  %G%25.%Res% Liet ke cac may in
echo       %G%10.%Res% Restart Explorer        %G%--%Res% ----------------------   %G%16.%Res% Xem Pass Wi-Fi cu        %G%--%Res% ----------------------
echo       %G%18.%Res% Liet ke cac Task        %G%--%Res% ----------------------   %G%17.%Res% Reset thiet lap mang     %G%--%Res% ----------------------
echo       %G%19.%Res% Dong ung dung treo      %G%--%Res% ----------------------   %G%--%Res% ----------------------   %G%--%Res% ----------------------
echo       %G%20.%Res% Tat nhanh Chrome        %G%--%Res% ----------------------   %G%--%Res% ----------------------   %G%--%Res% ----------------------
echo       %G%21.%Res% Danh sach User          %G%--%Res% ----------------------   %G%--%Res% ----------------------   %G%--%Res% ----------------------
echo.
echo       %C%[ 5. TRUY CAP NHANH 1 ]%Res%       %C%[ 6. TRUY CAP NHANH 2 ]%Res%       %C%[ 7. CAI DAT - KICH HOAT ]%Res%              %C%[ 8. LENH NHANH ]%Res%
echo.
echo       %G%31.%Res% Control Panel           %G%35.%Res% Print Management        %G%40.%Res% %R%ACTIVE WIN/OFFICE%Res%       %G%--%Res% ----------------------
echo       %G%32.%Res% Task Manager            %G%36.%Res% Network Connections     %G%--%Res% ----------------------   %G%--%Res% ----------------------
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
echo %Yellow%Dang don dep file rac he thong...%Reset%
:: Chuyen sang dung PowerShell de xoa file 
powershell -command "& {Remove-Item -Path 'C:\Windows\Temp\*' -Recurse -Force -EA SilentlyContinue; Remove-Item -Path 'C:\Users\$env:UserName\AppData\Local\Temp\*' -Recurse -Force -EA SilentlyContinue; Remove-Item -Path 'C:\Windows\Prefetch\*' -Recurse -Force -EA SilentlyContinue}"
echo.
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

:hardwareInfo
cls
:: 1. Hiển thị tiêu đề bằng mã màu CMD
echo %C%==================================================%Res%
echo %Y%[ THONG TIN PHAN CUNG CHI TIET ]%Res%
echo %C%==================================================%Res%

:: 2. Gọi PowerShell để lấy dữ liệu (Sử dụng màu của bạn cho từng dòng)
echo %G%[+] CPU:%Res%
powershell -command "(Get-CimInstance Win32_Processor).Name"

echo %G%[+] RAM:%Res%
powershell -command "[Math]::Round(((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1GB), 2).ToString() + ' GB'"

echo %G%[+] O CUNG:%Res%
powershell -command "Get-PhysicalDisk | ForEach-Object { $pd = $_; $logic = Get-Partition -DiskNumber $pd.DeviceNumber | Get-Volume; $letters = ($logic.DriveLetter -join ','); $total = [Math]::Round($pd.Size / 1GB, 2); $free = [Math]::Round(($logic.SizeRemaining | Measure-Object -Sum).Sum / 1GB, 2); [PSCustomObject]@{ 'Ten o dia'=$pd.FriendlyName; 'Loai'=$pd.MediaType; 'O'=$letters; 'Trong/Tong'=\"$free/$total GB\"; 'Status'=$pd.HealthStatus } } | Format-Table -AutoSize"

echo %G%[+] GPU:%Res%
powershell -command "(Get-CimInstance Win32_VideoController).Name"

echo %G%[+] Nhiet do CPU (Uoc tinh):%Res%
powershell -command "$t = Get-CimInstance -Namespace root/wmi -ClassName MSAcpi_ThermalZoneTemperature -ErrorAction SilentlyContinue; if($t) { $celsius = [Math]::Round(($t.CurrentTemperature / 10) - 273.15, 1); if($celsius -gt 80) { Write-Host \"$celsius °C\" -ForegroundColor Red } else { Write-Host \"$celsius °C\" -ForegroundColor Green } } else { Write-Host 'Mainboard hong ho tro' -ForegroundColor Yellow }"
echo %C%--------------------------------------------------%Res%
echo %W%Kiem tra hoan tat!%Res%
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

$tempPath = "$env:TEMP\it_tool.bat"
$batchCode | Out-File -FilePath $tempPath -Encoding ascii
# Chay file va PowerShell se cho den khi file dong moi xoa
Start-Process $tempPath -Wait
if (Test-Path $tempPath) { Remove-Item $tempPath -Force }
