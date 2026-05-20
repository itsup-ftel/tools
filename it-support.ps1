# it-support.ps1
$batchCode = @'
@echo off
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process -FilePath '%0' -Verb RunAs"
    exit /b
)
title IT SUPPORT PROFESSIONAL TOOLKIT v26.5
mode con: cols=120 lines=30

for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "ESC=%%b"

set "G=%ESC%[92m"
set "Y=%ESC%[93m"
set "C=%ESC%[96m"
set "W=%ESC%[97m"
set "R=%ESC%[91m"
set "B=%ESC%[94m"
set "Res=%ESC%[0m"

set "PASSWORD=2026"
set "FAIL_COUNT=0"

:login
cls
set "input_pass="
echo %C%==========================================%Res%
echo %Y%       XAC THUC QUYEN TRUY CAP TOOL%Res%
echo %C%==========================================%Res%
echo.
set /p "input_pass=Nhap mat khau de vao su dung Tool: "

if "%input_pass%"=="" (
    echo.
    echo %R%[X] Ban chua nhap mat khau. Vui long khong de trong!%Res%
    timeout /t 2 >nul
    goto login
)

if "%input_pass%"=="%PASSWORD%" (
    echo.
    echo %G%[OK] Mat khau chinh xac!%Res%
    timeout /t 1 >nul
    goto menu
) else (
    goto login_error
)

:login_error
set /a "FAIL_COUNT+=1"
echo.
if %FAIL_COUNT% geq 3 (
    echo %R%[X] SAI MAT KHAU LAN 3! BAN DA BI TU CHOI TRUY CAP!%Res%
    timeout /t 3 >nul
    exit
)
set /a "REMAIN=3-FAIL_COUNT"
echo %R%[X] Sai mat khau lan %FAIL_COUNT%. Ban con %REMAIN% lan thu!%Res%
timeout /t 3 >nul
goto login

:menu
cls
echo.
echo  %G%====================================================================================================================%Res%
echo                                     %W%IT SUPPORT PROFESSIONAL TOOLKIT - VERSION 26.5%Res%
echo  %G%====================================================================================================================%Res%
echo.
echo     %Y%[ 1. KIEM TRA]%Res%          %Y%[ 2. HE THONG ]%Res%         %Y%[ 3. MANG ^& INTERNET ]%Res%    %Y%[ 4. MAY IN ]%Res%
echo.
echo      %G%1.%Res% Thong so may PC       %G%7.%Res% Don dep rac         %G%13.%Res% Lay MAC ^& Serial     %G%19.%Res% Restart Spooler
echo      %G%2.%Res% Thong tin o cung      %G%8.%Res% Sua loi SFC/DISM    %G%14.%Res% Cau hinh IP/DNS      %G%20.%Res% Xoa ket lenh in
echo      %G%3.%Res% Thong tin RAM         %G%9.%Res% Dong ung dung treo  %G%15.%Res% Ping check GW/DNS    %G%21.%Res% In trang Test
echo      %G%4.%Res% Thong tin User       %G%10.%Res% On/Off Win Update   %G%16.%Res% TCPing/Tracetcp      %G%22.%Res% Liet ke d/s in
echo      %G%5.%Res% Thong tin Bitlocker  %G%11.%Res% Restart Explorer    %G%17.%Res% Xem Pass Wi-Fi       %G%23.%Res% ----44-------
echo      %G%6.%Res% Chi tiet ban quyen   %G%12.%Res% Xu ly Task          %G%18.%Res% Reset Mang           %G%24.%Res% ---------------
echo.
echo     %C%[ 5. CONG CU 1 ]%Res%        %C%[ 6. CONG CU 2 ]%Res%         %C%[ 7. CAI DAT ]%Res%           %C%[ 8. FIX LOI ]%Res%
echo.
echo     %G%25.%Res% Control Panel        %G%30.%Res% Print Management    %G%35.%Res% Bo cai Office       %G%40.%Res% Sao luu/ Phuc hoi
echo     %G%26.%Res% Task Manager         %G%31.%Res% Network Connection  %G%36.%Res% %G%Active Win/Office%Res%   %G%41.%Res% Dich vu cong
echo     %G%27.%Res% Services (msc)       %G%32.%Res% Registry Editor     %G%37.%Res% Cleanup Win/Office  %G%42.%Res% Foxit PDF Editor
echo     %G%28.%Res% Device Manager       %G%33.%Res% Advanced Firewall   %G%38.%Res% Ung dung Mien Phi   %G%43.%Res% Adobe
echo     %G%29.%Res% Windows Settings     %G%34.%Res% Uninstall Programs  %G%39.%Res% Ung dung Ban Quyen  %G%44.%Res% Autodesk
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
if /i "%opt%"=="6" goto checklicense
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
if /i "%opt%"=="25" start control & goto menu
if /i "%opt%"=="26" start taskmgr & goto menu
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
if /i "%opt%"=="37" goto cleanup
if /i "%opt%"=="38" goto appfree
if /i "%opt%"=="39" goto appvip
if /i "%opt%"=="40" goto saoluuphuchoi
if /i "%opt%"=="41" goto dichvucong
if /i "%opt%"=="42" goto foxiteditor
if /i "%opt%"=="43" goto adobe
if /i "%opt%"=="44" goto autodesk
if /i "%opt%"=="r" goto restart
if /i "%opt%"=="s" goto shutdown
if /i "%opt%"=="0" exit
goto menu

:: --- CAC HAM XU LY ---

:checklicense
cls
echo %C%====================================================================%Res%
echo %Y%                  CONG CU QUET KIEM TRA BAN QUYEN %Res%
echo %C%====================================================================%Res%
echo:
echo %C% KIEM TRA BAN QUYEN WINDOWS:%Res%
powershell -Command "$w = cscript //nologo $env:windir\system32\slmgr.vbs /dli | Out-String; $x = Get-CimInstance -ClassName SoftwareLicensingProduct -Filter \"PartialProductKey is not null and LicenseStatus=1\" -ErrorAction SilentlyContinue; if (-not $x -and -not ($w.ToUpper().Contains('LICENSED'))) { Write-Host '  [-] Ket qua: WINDOWS CHUA KICH HOAT HOAC HET HAN DUNG THU' -ForegroundColor Yellow } else { $fullX = $x | Out-String; $isKMS = ($w.ToUpper().Contains('KMS') -or $fullX.ToUpper().Contains('VOLUME_KMS') -or $w.ToUpper().Contains('180 DAYS') -or $w.ToUpper().Contains('127.0.0.1')); $isVolume = ($fullX.ToUpper().Contains('VOLUME_KMS') -or ($fullX.ToUpper().Contains('VOLUME') -and -not ($fullX.ToUpper().Contains('MAK')))); $isOEM = ($w.ToUpper().Contains('OEM') -or $fullX.ToUpper().Contains('OEM')); $OEMObj = Get-CimInstance -ClassName Win32_ComputerSystemProduct -ErrorAction SilentlyContinue; $isFakeOEM = ($isOEM -and (-not $OEMObj.DigitalProductId)); $partialKey = ($x | Select-Object -First 1).PartialProductKey; $isGenericKey = @('3V66T', '2YT43', '4863V', '6TPF9', '6F4BT', '8439J', 'H8Q99', 'GHM43', 'X4DBX', 'D6R8H', 'WYT23', 'XQQ8S', 'YG64T', '92443', 'B7836') -contains $partialKey; if ($isKMS) { Write-Host '  [-] Ket qua: WINDOWS CRACK (Su dung may chu KMS gia lap hoac tool KMSPico/AIO Tools)' -ForegroundColor Red } elseif ($isGenericKey -and -not $isOEM) { Write-Host '  [-] Ket qua: WINDOWS CRACK (Phat hien su dung tool MAS gia lap ve nang cap ky thuat so HWID bang Generic Product Key)' -ForegroundColor Red } elseif ($isVolume) { Write-Host '  [-] Ket qua: WINDOWS CRACK (Su dung tool MAS luan chuyen khoa vao kenh Doanh Nghiep Volume)' -ForegroundColor Red } elseif ($isFakeOEM) { Write-Host '  [-] Ket qua: WINDOWS CRACK (Gia lap chung chi OEM, bo mach chu khong co chip ban quyen goc)' -ForegroundColor Red } else { Write-Host '  [+] Ket qua: BAN QUYEN XIN THUONG MAI (Giay phep Retail hoac OEM tu chip phan cung chuan hang)' -ForegroundColor Green } }"

echo:
echo %C% KIEM TRA BAN QUYEN MICROSOFT OFFICE:%Res%
powershell -Command "$wDir = $null; $regWord = Get-ItemProperty -Path 'HKLM:\\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Winword.exe' -Name '(default)' -ErrorAction SilentlyContinue; if ($regWord) { $wDir = Split-Path $regWord.'(default)' }; if (-not $wDir) { $pathsDefault = @('${env:ProgramFiles}\Microsoft Office\root\Office16', '${env:ProgramFiles(x86)}\Microsoft Office\root\Office16', '${env:ProgramFiles}\Microsoft Office\Office16', '${env:ProgramFiles(x86)}\Microsoft Office\Office16', '${env:ProgramFiles}\Microsoft Office\Office15', '${env:ProgramFiles(x86)}\Microsoft Office\Office15'); foreach ($p in $pathsDefault) { if (Test-Path \"$p\WINWORD.EXE\") { $wDir = $p; break } } }; if (-not $wDir) { $cmdFind = where /R C:\ WINWORD.EXE 2>$null | Select-Object -First 1; if ($cmdFind) { $wDir = Split-Path $cmdFind } }; if (-not $wDir) { Write-Host '  [-] Ket qua: KHONG TIM THAY PHEN BAN OFFICE NAO DANG CAI DAT TREN MAY' -ForegroundColor Yellow } else { $appName = 'Microsoft Office (' + (Split-Path (Split-Path $wDir) -Leaf) + ' ' + (Split-Path $wDir -Leaf) + ')'; Write-Host \"  [+] Phat hien ung dung: $appName\" -ForegroundColor Cyan; $paths = @(); if (Test-Path \"$wDir\ospp.vbs\") { $paths += $wDir } else { $pParent = Split-Path $wDir; $findVbs = Get-ChildItem -Path $pParent -Filter 'ospp.vbs' -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1; if ($findVbs) { $paths += $findVbs.DirectoryName } }; $spccSys = Test-Path '$env:SystemRoot\system32\spcc.dll', '$env:SystemRoot\syswow64\spcc.dll'; $spccApp = Test-Path (Join-Path $wDir 'spcc.dll'); $ohookLegacy = Test-Path '$env:SystemRoot\system32\spp\tokens\skus\Office*'; $tsforgeMondo = ($ohookLegacy -and (Get-ChildItem -Path '$env:SystemRoot\system32\spp\tokens\skus\Office*' -Filter '*Mondo*' -ErrorAction SilentlyContinue)); if ($spccSys -or $spccApp) { Write-Host '  [-] Ket qua: OFFICE CRACK (Su dung ma doc / File DLL gia mao spcc.dll cua engine Ohook the he moi)' -ForegroundColor Red } elseif ($tsforgeMondo) { Write-Host '  [-] Ket qua: OFFICE CRACK (Su dung cong cu TsForge / Nap de chung chi gia lap phan he Enterprise Mondo)' -ForegroundColor Red } elseif ($ohookLegacy -and -not $tsforgeMondo) { Write-Host '  [-] Ket qua: OFFICE CRACK (Su dung engine OHOOK can thiep gia lap chung chi)' -ForegroundColor Red } else { $crackFile = $false; foreach ($p in $paths) { $exeFiles = Get-ChildItem -Path $p -Filter '*.exe' -ErrorAction SilentlyContinue | Select-Object -First 3; foreach ($f in $exeFiles) { $sig = Get-AuthenticodeSignature $f.FullName -ErrorAction SilentlyContinue; if ($sig.Status -and $sig.Status -ne 'Valid') { $crackFile = $true } else { if ($sig.SignerCertificate) { $isValidRoot = $sig.SignerCertificate.Verify(); if (-not $isValidRoot) { $crackFile = $true } } } } }; if ($crackFile) { Write-Host '  [-] Ket qua: OFFICE CRACK (Phat hien tap tin he thong bi va ma nguon hoac dung chung chi gia)' -ForegroundColor Red } else { if ($paths.Count -gt 0) { $activePath = Join-Path $paths 'ospp.vbs'; $o = cscript //nologo \"$activePath\" /dstatus | Out-String; if ($o.ToUpper().Contains('LICENSED')) { if ($o.ToUpper().Contains('VOLUME_KMS') -or $o.ToUpper().Contains('KMS HOST') -or $o.ToUpper().Contains('127.0.0.1')) { Write-Host '  [-] Ket qua: OFFICE CRACK (Su dung may chu KMS gia lap hoac tool AIO Tools de gia han 180 ngay)' -ForegroundColor Red } elif ($o.ToUpper().Contains('RETAIL')) { Write-Host '  [+] Ket qua: BAN QUYEN XIN THUONG MAI (Giay phep Retail nhap Product Key co dinh hop le)' -ForegroundColor Green } else { Write-Host '  [+] Ket qua: BAN QUYEN DOANH NGHIEP (Su dung khoa Commercial Volume khoi doanh nghiep chinh thuc)' -ForegroundColor Green } } else { $vScript = Join-Path $paths 'vnextdiag.ps1'; if (-not (Test-Path $vScript)) { $vScript = Join-Path (Split-Path $paths) 'root\Office16\vnextdiag.ps1' }; if (Test-Path $vScript) { $vOut = powershell -ExecutionPolicy Bypass -File \"$vScript\" -List 2>&1 | Out-String; if ($vOut.ToUpper().Contains('OLSLICENSESTATE_LICENSED')) { Write-Host '  [+] Ket qua: BAN QUYEN XIN (Xac thuc thue bao so qua Tai khoan Microsoft 365 Cloud hop le)' -ForegroundColor Green } else { Write-Host '  [-] Ket qua: OFFICE CHUA KICH HOAT HOAC HET HAN BAN QUYEN' -ForegroundColor Yellow } } else { Write-Host '  [-] Ket qua: OFFICE CHUA KICH HOAT HOAC HET HAN BAN QUYEN' -ForegroundColor Yellow } } } else { Write-Host '  [+] Ket qua: BAN QUYEN XIN THUONG MAI (Phien ban Windows Store dac thu kem theo may)' -ForegroundColor Green } } } }"

echo:
echo %C% KIEM TRA GOI PHAN MEM ADOBE:%Res%
powershell -Command "$reg = Get-ChildItem -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*', 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' -ErrorAction SilentlyContinue | Get-ItemProperty -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -match 'Adobe' -and $_.DisplayName -notmatch 'Reader' -and $_.DisplayName -notmatch 'Acrobat' }; if (-not $reg) { Write-Host '  [-] Ket qua: KHONG CO PHAN MEM ADOBE NAO DANG CAI DAT TREN MAY' -ForegroundColor Gray } else { $aDir = 'C:\Program Files\Adobe'; $exe = Get-ChildItem -Path $aDir -Filter '*.exe' -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.DirectoryName -notmatch 'Acrobat' -and $_.Name -notmatch 'unins' -and $_.Name -notmatch 'Setup' } | Select-Object -First 5; if (-not $exe) { Write-Host '  [-] Ket qua: KHONG CO PHAN MEM ADOBE NAO DANG CAI DAT TREN MAY (Chi co thu muc rac sau khi go)' -ForegroundColor Gray } else { $hosts = Get-Content $env:windir\system32\drivers\etc\hosts -ErrorAction SilentlyContinue; $h = $hosts -match 'adobe.com' -or $hosts -match 'adobe.io' -or $hosts -match 'cc-api-data'; $crack = $false; foreach ($e in $exe) { $sig = Get-AuthenticodeSignature $e.FullName -ErrorAction SilentlyContinue; if ($sig.Status -and $sig.Status -ne 'Valid') { $crack = $true } }; if ($crack) { Write-Host '  [-] Ket qua: ADOBE CRACK (Phat hien ma nhi phan loi / Vo hieu hoa chu ky so goc boi tool GenP hoac Monkrus Repack)' -ForegroundColor Red } elif ($h) { Write-Host '  [-] Ket qua: ADOBE CRACK (File Hosts bi sua doi co tinh de chan may chu Genuine Adobe kiem tra)' -ForegroundColor Red } else { Write-Host '  [+] Ket qua: BAN QUYEN XIN THUONG MAI (Moi file he thong con nguyen ven chu ky so hop phap cua Adobe Inc / Co Creative Cloud)' -ForegroundColor Green } } }"

echo:
echo %C% KIEM TRA GOI PHAN MEM AUTODESK:%Res%
powershell -Command "$aDir='C:\\Program Files\\Autodesk'; if(-not (Test-Path $aDir)){Write-Host '  [-] Ket qua: KHONG CO PHAN MEM AUTODESK NAO TREN MAY' -ForegroundColor Gray}else{$lmgrd=Get-Process -Name 'lmgrd','adskflex' -ErrorAction SilentlyContinue; $clic=Test-Path 'C:\\Program Files (x86)\\Common Files\\Autodesk Shared\\AdskLicensing\\adskflex_*.lic'; $hosts=Get-Content $env:windir\system32\drivers\etc\hosts -ErrorAction SilentlyContinue; $isHostsBlock=$hosts -match 'autodesk.com' -or $hosts -match 'genuine-software'; $svc=Get-Service -Name 'AdskLicensingService' -ErrorAction SilentlyContinue; $isSvcStop=($svc -and ($svc.Status -ne 'Running')); $isCrackNLM=($lmgrd -or $clic); $isInvalidSig=$false; $exe=Get-ChildItem -Path $aDir -Filter 'acad.exe' -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1; if($exe){$sig=Get-AuthenticodeSignature $exe.FullName -ErrorAction SilentlyContinue; if($sig.Status -and ($sig.Status -ne 'Valid')){$isInvalidSig=$true}}; if($isCrackNLM){Write-Host '  [-] Ket qua: AUTODESK CRACK (Su dung Network License Manager gia lap May chu offline boi tool X-Force / Magnitude)' -ForegroundColor Red}elif($isHostsBlock){Write-Host '  [-] Ket qua: AUTODESK CRACK (Phat hien chan IP dich vu quet xac thuc Genuine cua Autodesk tren file Hosts)' -ForegroundColor Red}elif($isSvcStop){Write-Host '  [-] Ket qua: AUTODESK CRACK (Dich vu cap phep AdskLicensingService bi tat cuong buc de bypass thong tin)' -ForegroundColor Red}elif($isInvalidSig){Write-Host '  [-] Ket qua: AUTODESK CRACK (File thuc thi acad.exe bi ghi de pha vo chu ky so goc tu hang)' -ForegroundColor Red}else{Write-Host '  [+] Ket qua: BAN QUYEN XIN THUONG MAI (Dich vu goc chay on dinh, su dung dang nhap User License thue bao hop phap)' -ForegroundColor Green}}"

echo:
echo %C% KIEM TRA CAC UNG DUNG PDF CHUYEN DUNG:%Res%

:: --- Foxit PDF Editor & PhantomPDF ---
powershell -Command "$fDirs = Get-ChildItem -Path 'C:\Program Files (x86)\Foxit Software\*', 'C:\Program Files\Foxit Software\*' -ErrorAction SilentlyContinue | Where-Object { $_.PSIsContainer -and ($_.Name -match 'Editor' -or $_.Name -match 'PhantomPDF') }; foreach ($d in $fDirs) { $exe = Get-ChildItem -Path $d.FullName -Filter 'Foxit*.exe' -ErrorAction SilentlyContinue | Select-Object -First 1; if ($exe) { $crack = $false; $files = Get-ChildItem -Path $d.FullName -Filter *.dll -ErrorAction SilentlyContinue | ForEach-Object { $_.FullName }; $files += $exe.FullName; foreach ($f in $files) { $sig = Get-AuthenticodeSignature $f -ErrorAction SilentlyContinue; if ($sig.Status -and $sig.Status -ne 'Valid') { $crack = $true } else { if ($sig.SignerCertificate) { $isValidRoot = $sig.SignerCertificate.Verify(); if (-not $isValidRoot) { $crack = $true } } } }; if ($crack) { Write-Host \"  [-] Ket qua: $($d.Name) BI CRACK (Phat hien file can thiep hoac chung chi gia mao khong hop le)\" -ForegroundColor Red } else { Write-Host \"  [+] Ket qua: $($d.Name) BAN QUYEN SACH (File goc nguyen ban duoc Windows xac thuc)\" -ForegroundColor Green } } }"

:: --- Nitro PDF Pro ---
powershell -Command "$nDirs = Get-ChildItem -Path 'C:\Program Files\Nitro\*', 'C:\Program Files (x86)\Nitro\*' -ErrorAction SilentlyContinue | Where-Object { $_.PSIsContainer -and ($_.Name -match 'Pro') }; foreach ($d in $nDirs) { $exe = Get-ChildItem -Path $d.FullName -Filter 'NitroPDF.exe' -ErrorAction SilentlyContinue | Select-Object -First 1; if ($exe) { $crack = $false; $files = Get-ChildItem -Path $d.FullName -Filter *.dll -ErrorAction SilentlyContinue | ForEach-Object { $_.FullName }; $files += $exe.FullName; foreach ($f in $files) { $sig = Get-AuthenticodeSignature $f -ErrorAction SilentlyContinue; if ($sig.Status -and $sig.Status -ne 'Valid') { $crack = $true } else { if ($sig.SignerCertificate) { $isValidRoot = $sig.SignerCertificate.Verify(); if (-not $isValidRoot) { $crack = $true } } } }; if ($crack) { Write-Host \"  [-] Ket qua: Nitro PDF ($($d.Name)) BI CRACK (Phat hien ma nguon bi thay doi hoac chu ky gia)\" -ForegroundColor Red } else { Write-Host \"  [+] Ket qua: Nitro PDF ($($d.Name)) BAN QUYEN SACH (Ung dung dung file goc xac thuc he thong)\" -ForegroundColor Green } } }"

:: --- ABBYY FineReader ---
powershell -Command "$aDirs = Get-ChildItem -Path 'C:\Program Files\ABBYY FineReader *', 'C:\Program Files (x86)\ABBYY FineReader *' -ErrorAction SilentlyContinue | Where-Object { $_.PSIsContainer }; foreach ($d in $aDirs) { $exe = Get-ChildItem -Path $d.FullName -Filter 'FineReader.exe' -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1; if ($exe) { $crack = $false; $aSvc = Get-Service -Name 'ABBYY FineReader * Licensing Service' -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -match $d.Name.Split(' ')[-1] } | Select-Object -First 1; if ($aSvc -and $aSvc.Status -ne 'Running') { $crack = $true } else { $checkList = @($exe.FullName); $commonLic = 'C:\Program Files\Common Files\ABBYY\FineReader'; if (Test-Path $commonLic) { $checkList += (Get-ChildItem -Path $commonLic -Include *.dll,*.exe -Recurse -ErrorAction SilentlyContinue | ForEach-Object { $_.FullName }) }; foreach ($f in $checkList) { $sig = Get-AuthenticodeSignature $f -ErrorAction SilentlyContinue; if ($sig.Status -and $sig.Status -ne 'Valid') { $crack = $true } else { if ($sig.SignerCertificate) { $isValidRoot = $sig.SignerCertificate.Verify(); if (-not $isValidRoot) { $crack = $true } } } } }; if ($crack) { Write-Host \"  [-] Ket qua: $($d.Name) BI CRACK (Dich vu ngat hoac mo phung module xac thuc trai phep)\" -ForegroundColor Red } else { Write-Host \"  [+] Ket qua: $($d.Name) BAN QUYEN SACH (Module ma hoa dat chung chi bao mat chuan)\" -ForegroundColor Green } } }"

echo:
echo %C%====================================================================%Res%
echo %G%                 TIEN TRINH KIEM TRA HOAN TAT !%Res%
echo %C%====================================================================%Res%
pause
goto menu

:dichvucong
cls
echo %C%==========================================%Res%
echo %Y%        [ CAI DAT DICH VU CONG ]%Res%
echo %C%==========================================%Res%
echo.
echo  %G%1.%Res% HTKK - Ho tro ke khai
echo  %G%2.%Res% iTaxViewer - Doc ho so thue
echo  %G%3.%Res% CT SigningHub - Ky dien tu
echo  %G%4.%Res% eSigner - Plugin
echo  %G%5.%Res% Thoat ve menu chinh
echo %C%==========================================%Res%
set /p choice="Chon lua chon cua ban (1-5): "

if "%choice%"=="1" goto :proc_htkk
if "%choice%"=="2" goto :proc_itax
if "%choice%"=="3" goto :proc_cthub
if "%choice%"=="4" goto :proc_esigner
if "%choice%"=="5" goto menu
goto :dichvucong

:proc_htkk
cls
set "CURRENT_APP=HTKK"
echo %C%[1/6]%Res% Kiem tra va Kich hoat .NET Framework 3.5...
reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5" /v Install 2>nul | findstr "0x1" >nul
if %errorlevel% neq 0 (
    dism /online /enable-feature /featurename:NetFx3 /all /quiet /norestart
    if %errorlevel% neq 0 (echo %R%[X] Loi: Thieu .NET 3.5!%Res% & pause & goto dichvucong)
)

set "HTKK_DIR=C:\Program Files (x86)\HTKK"
if not exist "%HTKK_DIR%" if exist "C:\Program Files\HTKK" set "HTKK_DIR=C:\Program Files\HTKK"
set "BAK=%TEMP%\HTKK_Bak"

echo %C%[2/6]%Res% Sao luu du lieu HTKK co san...
if exist "%HTKK_DIR%\Datafiles" (
    if exist "%BAK%" rmdir /s /q "%BAK%"
    xcopy "%HTKK_DIR%\Datafiles" "%BAK%\" /E /I /H /Y /C >nul
)

call :InstallApp "%CURRENT_APP%" "https://vnshort.com/58Bq" "HTKK.zip" "setup.exe" "%HTKK_DIR%"

echo %C%[6/6]%Res% Dang tien hanh khoi phuc datafiles...
set "HTKK_DIR=C:\Program Files (x86)\HTKK"
if not exist "%HTKK_DIR%" set "HTKK_DIR=C:\Program Files\HTKK"
if exist "%BAK%" (
    xcopy "%BAK%" "%HTKK_DIR%\Datafiles\" /E /I /H /Y /C >nul
    rmdir /s /q "%BAK%"
)
goto end_process

:proc_itax
cls
set "CURRENT_APP=iTaxViewer"
set "DIR=C:\Program Files (x86)\iTaxViewer"
if not exist "%DIR%" if exist "C:\Program Files\iTaxViewer" set "DIR=C:\Program Files\iTaxViewer"
call :InstallApp "%CURRENT_APP%" "https://vnshort.com/9oEf" "iTaxViewer.zip" "iTaxViewer2.7.4.exe" "%DIR%"
goto end_process

:proc_cthub
cls
set "CURRENT_APP=CTSigningHub"
set "DIR=C:\Program Files (x86)\CT\CTSigningHub"
if not exist "%DIR%" if exist "C:\Program Files\CT\CTSigningHub" set "DIR=C:\Program Files\CT\CTSigningHub"
call :InstallApp "%CURRENT_APP%" "https://vnshort.com/gLzM" "CTSigningHub.zip" "CTSigningHub.exe" "%DIR%"
goto end_process

:proc_esigner
cls
set "CURRENT_APP=eSigner"
set "DIR=C:\Program Files (x86)\eSigner Java"
if not exist "%DIR%" if exist "C:\Program Files\eSigner Java" set "DIR=C:\Program Files\eSigner Java"
call :InstallApp "%CURRENT_APP%" "https://vnshort.com/MCxM" "eSigner_1.1.0_setup.zip" "eSigner_1.1.0_setup.exe" "%DIR%"
goto end_process

:end_process
echo %G%===================================================%Res%
echo %G%[OK] DA HOAN THANH CAP NHAT %CURRENT_APP%!%Res%
echo %G%===================================================%Res%
timeout /t 3 >nul
pause
goto dichvucong

:InstallApp
set "APP_NAME=%~1"
set "URL=%~2"
set "ZIP_NAME=%~3"
set "EXE_NAME=%~4"
set "TARGET_DIR=%~5"
set "SRC=%TEMP%\%APP_NAME%_Tmp_Src"

echo %Y%[+] Dang xu ly ung dung: %APP_NAME%%Res%

echo  %B%-%Res% Go cai dat phien ban cu...
powershell -Command "Get-Package -Name '*%APP_NAME%*' -ErrorAction SilentlyContinue | Uninstall-Package -Force" >nul 2>&1
if exist "%TARGET_DIR%" rmdir /s /q "%TARGET_DIR%" 2>nul

echo  %B%-%Res% Tai va Giai nen bo cai dat moi...
if exist "%SRC%" rmdir /s /q "%SRC%"
md "%SRC%"
curl --ssl-no-revoke -L -# -o "%SRC%\%ZIP_NAME%" "%URL%"
if not exist "%SRC%\%ZIP_NAME%" (echo %R%[X] Loi: Khong tai duoc file!%Res% & pause & exit)
powershell -Command "Expand-Archive -Path '%SRC%\%ZIP_NAME%' -DestinationPath '%SRC%' -Force"

echo  %B%-%Res% Tien hanh cai dat...
set "SETUP_EXE="
for /r "%SRC%" %%F in (%EXE_NAME%) do if exist "%%F" set "SETUP_EXE=%%F"
if not defined SETUP_EXE (echo %R%[X] Loi: Khong tim thay file %EXE_NAME%!%Res% & rmdir /s /q "%SRC%" & pause & exit)

start /wait "" "%SETUP_EXE%"
rmdir /s /q "%SRC%"
exit /b

:foxiteditor
cls
mode 85, 35
set "ver=2024.4.0.27683"
set "pathfoxit=%ProgramFiles(x86)%\Foxit Software\Foxit PDF Editor"
set "source=%TEMP%\Foxit_Source"
title Foxit PDF Editor - V%ver%

echo:     ______________________________________________________________
echo:
echo:                    %C%[Foxit PDF Editor x2024]%Res%
echo:     ______________________________________________________________
echo:         [1] %G%FULL%Res%: Tai, Cai dat ^& Kich hoat
echo:         [2] Chi kich hoat Editor %Y%(Neu da cai san app)%Res%
echo:         [3] Chan Firewall (Chan quet ban quyen)
echo: %R%        [0] Thoat ve menu chinh%Res%
echo:     ______________________________________________________________
echo.
choice /C:1230 /N
set "userChoice=%errorlevel%"

if %userChoice%==1 goto Downloadfoxit
if %userChoice%==2 goto Activefoxit
if %userChoice%==3 goto Blockfoxit
if %userChoice%==0 goto menu
goto menu

:Downloadfoxit
cls
echo:     %Y%[==^> Dang kiem tra trang thai he thong...]%Res%

set "foundPath="
if exist "%pathfoxit%\FoxitPDFEditor.exe" (set "foundPath=%pathfoxit%")

if defined foundPath (
    echo:
    echo:    %R%[[!] Phat hien Foxit PDF Editor da duoc cai dat tai:]%Res%
    echo:         "%foundPath%"
    echo:    %Y%[==^> Chuyen huong sang buoc kich hoat sau 3 giay...]%Res%
    timeout /t 3 >nul
    goto Activefoxit
)

echo:     %W%[==^> Dang tai Foxit PDF Editor x2024...]%Res%
if not exist "%source%" md "%source%"
curl --ssl-no-revoke --progress-bar -L -# -o "%source%\FoxitPDFEditor.msi" https://cdn01.foxitsoftware.com/product/phantomPDF/desktop/win/2024.4.1/FoxitPDFEditor202441_enu_Setup_Website.msi
echo:     %W%[==^> Dang cai dat Foxit PDF Editor x2024...]%Res%
start /wait "" "%source%\FoxitPDFEditor.msi" /quiet /norestart
goto Activefoxit

:Activefoxit
cls
echo:     %W%[==^> Dang chuan bi tien hanh kich hoat...]%Res%
if not exist "%source%" md "%source%"
curl --ssl-no-revoke --progress-bar -L -# -o "%source%\FoxitPDFEditor.zip" https://vnshort.com/n2rr

echo:     %W%[==^> Tam tat Antivirus de chay tien trinh...]%Res%
powershell -Command "Add-MpPreference -ExclusionPath '%source%'" >nul 2>&1
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true" >nul 2>&1

echo:     %W%[==^> Dang giai nen va copy source Editor...]%Res%
powershell -Command "Expand-Archive -Path '%source%\FoxitPDFEditor.zip' -DestinationPath '%source%\Unzipped' -Force"
xcopy "%source%\Unzipped\FoxitPDFEditor\*.*" "%pathfoxit%\" /E /I /H /Y /R /Q >nul
goto Blockfoxit

:Blockfoxit
cls
:: Chan Firewall
echo     ==^> Dang thiet lap Firewall Rules cho Foxit PDF Editor...
netsh advfirewall firewall add rule name="FoxitPDFEditor_Block_Out" dir=out program="%pathfoxit%\FoxitPDFEditor.exe" action=block >nul 2>&1
netsh advfirewall firewall add rule name="FoxitPDFEditorupdate_Block_Out" dir=out program="%pathfoxit%\FoxitUpdater.exe" action=block >nul 2>&1
netsh advfirewall firewall add rule name="FoxitPDFEditor_activation_Block_Out" dir=out program="%pathfoxit%\Activation.exe" action=block >nul 2>&1
netsh advfirewall firewall add rule name="FoxitPDFEditor_Folder_Block_Out" dir=out program="%pathfoxit%" action=block >nul 2>&1
netsh advfirewall firewall add rule name="FoxitPDFEditor_Block_In" dir=in program="%pathfoxit%\FoxitPDFEditor.exe" action=block >nul 2>&1
netsh advfirewall firewall add rule name="FoxitPDFEditor_activation_Block_In" dir=in program="%pathfoxit%\Activation.exe" action=block >nul 2>&1
netsh advfirewall firewall add rule name="FoxitPDFEditorupdate_Block_In" dir=in program="%pathfoxit%\FoxitUpdater.exe" action=block >nul 2>&1
netsh advfirewall firewall add rule name="FoxitPDFEditor_Folder_Block_In" dir=in program="%pathfoxit%" action=block >nul 2>&1
netsh advfirewall set allprofiles state on >nul 2>&1
echo:     %G%[[OK] Da thiet lap Firewall thanh cong.]%Res%

echo     - Dang them loai tru va don source cai...
powershell -Command "Add-MpPreference -ExclusionPath '%ProgramFiles(x86)%\Foxit Software'" >nul 2>&1
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $false" >nul 2>&1
rmdir /s /q "%source%"

echo:     ________________________________________________________________________
echo:                   %G%[HOAN THANH CAI DAT FOXIT PDF EDITOR!]%Res%
echo:     ________________________________________________________________________
pause
goto foxiteditor

:appfree
cls
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

winget source update >nul 2>&1
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
    "@{Name='VLC media player'; ID='VideoLAN.VLC'}," ^
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

:appvip
cls
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

winget source update >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$apps = @(" ^
    "@{Name='Adobe CreativeCloud'; ID='Adobe.CreativeCloud'}," ^
    "@{Name='Autodesk AutodeskAccess'; ID='Autodesk.AutodeskAccess'}," ^
    "@{Name='SketchUp 2023'; ID='Trimble.SketchUp.2023'}," ^
    "@{Name='SketchUp 2025'; ID='Trimble.SketchUp.2025'}," ^
    "@{Name='SketchUp 2026'; ID='Trimble.SketchUp.2026'}," ^
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
echo 2. %R%[Tat Bitlocker]%Res% cho 1 o dia cu the (Vi du: C:)
echo 3. %R%[Tat BitLocker]%Res% cho TAT CA o dia dang bao ve
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
echo %C%[--- TRANG THAI BITLOCKER ---]%Res%
powershell -command "Get-BitLockerVolume | Select-Object MountPoint, VolumeStatus, ProtectionStatus, EncryptionPercentage | Format-Table -AutoSize"
pause
goto :bitlocker

:disable_one
set "drive="
set /p drive="Nhap ky tu o dia (Vi du C hoac C:): "
if "%drive%"=="" goto :bitlocker

if "%drive:~-1%" NEQ ":" set "drive=%drive%:"

echo [!] Dang kiem tra o %drive%...
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
echo --- Dang theo doi tien trinh giai ma (Nhan Ctrl+C de dung) ---
powershell -command "while($true) { Clear-Host; Write-Host '--- Tien trinh giai ma (Nhan Ctrl+C de thoat) ---'; Get-BitLockerVolume | Select-Object MountPoint, ProtectionStatus, EncryptionPercentage | Format-Table -AutoSize; Start-Sleep -Seconds 5 }"
goto :bitlocker

:activeMAS
cls
echo %C%==========================================%Res%
echo %Y%   [ DANG KET NOI DEN MAY CHU MAS... ]%Res%
echo %C%==========================================%Res%
echo.
echo %C%Luu y: May tinh can co ket noi Internet.%Res%
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://get.activated.win | iex"
goto menu
:cleanup
cls
echo %C%==========================================%Res%
echo %Y%   CLEANUP ACTIVATION WINDOWS ^& OFFICE%Res%
echo %C%==========================================%Res%
echo:
echo %Y%--- CAC KEY HIEN CO TREN HE THONG ---%Res%

echo %W%[?] Dang kiem tra Key Windows...%Res%
powershell -Command "$win = cscript //nologo $env:windir\system32\slmgr.vbs /dli | Select-String 'Partial Product Key'; if($win){Write-Host \"  $win\" -ForegroundColor Green} else {Write-Host '  - Khong tim thay Key Windows.' -ForegroundColor Yellow}"

echo %W%[?] Dang quet tim vi tri Office va kiem tra Key...%Res%
powershell -Command "$found=$false; $spp = Get-CimInstance -Query 'SELECT * FROM SoftwareLicensingProduct WHERE (Name LIKE \"%%Office%%\" OR Description LIKE \"%%Office%%\") AND PartialProductKey IS NOT NULL' -ErrorAction SilentlyContinue; if($spp){ foreach($p in $spp){ Write-Host ('  San pham: ' + $p.Name + ' | Key: ' + $p.PartialProductKey) -ForegroundColor Green; $found=$true } }; $regPaths = @('HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration', 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun\Configuration'); foreach($rp in $regPaths){ if(Test-Path $rp){ $pKey = Get-ItemProperty -Path $rp -Name 'ProductReleaseIds' -ErrorAction SilentlyContinue; if($pKey){ Write-Host ('  Office CTR: ' + $pKey.ProductReleaseIds) -ForegroundColor Green; $found=$true } } }; if(-not $found){ Write-Host '  - Khong tim thay bat ky san pham hoac Key Office nao.' -ForegroundColor Yellow }"

echo:
echo %C%==========================================%Res%
echo %W% 1. Bat dau xoa sach key%Res%
echo %W% 0. Huy bo va quay lai Menu%Res%
echo %C%==========================================%Res%
echo:

:: --- XỬ LÝ LỰA CHỌN PHÍM BẤM ---
choice /c 10 /n /m "Nhap lua chon cua ban: "
if errorlevel 2 goto menu
if errorlevel 1 goto start_clean

:start_clean
echo:
echo %G%[+]%W% Dang quet va xoa ban quyen Windows...%Res%
powershell -Command "cscript //nologo %windir%\system32\slmgr.vbs /upk; cscript //nologo %windir%\system32\slmgr.vbs /cpky; cscript //nologo %windir%\system32\slmgr.vbs /rearm" >nul 2>&1

echo:
echo %G%[+]%W% Dang quet va xoa sach key Office...%Res%
powershell -Command "$paths = @('${env:SystemDrive}\Program Files', '${env:SystemDrive}\Program Files (x86)') | Where-Object { Test-Path $_ }; $vbsPaths = Get-ChildItem -Path $paths -Filter 'ospp.vbs' -Recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName; foreach ($p in $vbsPaths) { $out = cscript //nologo \"$p\" /dstatus; $keys = $out | Select-String 'Last 5 characters of installed product key: (\w+)'; foreach ($m in $keys) { $k = $m.Matches.Groups.Value; cscript //nologo \"$p\" /unpkey:$k >$null } }" >nul 2>&1

echo:
echo %C%--- KIEM TRA TRANG THAI KEY SAU KHI XOA ---%Res%

echo %Y%Windows Status:%Res%
powershell -Command "$win = cscript //nologo $env:windir\system32\slmgr.vbs /dli | Select-String 'Partial Product Key'; if($win){Write-Host \"  $win\"} else {Write-Host '  - Khong con Key Windows.' -ForegroundColor Red}"

echo %Y%Office Status:%Res%
powershell -Command "$paths = @('${env:SystemDrive}\Program Files', '${env:SystemDrive}\Program Files (x86)') | Where-Object { Test-Path $_ }; $vbsPaths = Get-ChildItem -Path $paths -Filter 'ospp.vbs' -Recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName; $found = $false; foreach ($p in $vbsPaths) { $res = cscript //nologo \"$p\" /dstatus | Select-String 'Last 5 characters'; if ($res) { Write-Host \"  $res\"; $found = $true } }; if (-not $found) { Write-Host '  - Khong con Key Office.' -ForegroundColor Red }"
echo:
echo %R%==========================================%Res%
echo %G% DA HOAN TAT! KHONG CON KEY TREN HE THONG.%Res%
echo %R%==========================================%Res%
pause
goto menu


:adobe
cls
mode 85, 35
title Adobe Install
set "source=%TEMP%\GenP_Source"
set "hostsURL=https://raw.githubusercontent.com/itsup-ftel/tools/refs/heads/main/file/hostsadobe.txt"
set "tempHosts=%TEMP%\adobe_hosts.txt"
set "hPath=%SystemRoot%\System32\drivers\etc\hosts"
echo:     %C%______________________________________________________________%Res%
echo:
echo:                    %Y%[ADOBE PREMIUM LIST]%Res%
echo:     %C%______________________________________________________________%Res%
echo:         %G%[1]%Res% Acrobat DC Pro
echo:         %G%[2]%Res% Adobe Photoshop
echo:         %G%[3]%Res% Adobe Illustrator
echo:         %R%[0]%Res% Thoat ve menu chinh
echo:     %C%______________________________________________________________%Res%
echo.
choice /C:1230 /N
set "choice=%errorlevel%"

if %choice%==1 call :app_menu "Acrobat DC" "Acrobat" "Acrobat DC Pro" "https://trials.adobe.com/AdobeProducts/APRO/Acrobat_HelpX/win32/Acrobat_DC_Web_x64_WWMUI.zip"
if %choice%==2 call :app_menu "Adobe Photoshop" "photoshop.exe" "ADOBE PHOTOSHOP" "https://repo.sxl.net/_h/design/adobe.cc/Adobe-Photoshop-2025-26.0.0.26-m0nkrus.MUI.zip"
if %choice%==3 call :app_menu "Adobe Illustrator" "Illustrator.exe" "ADOBE ILLUSTRATOR" "https://repo.sxl.net/_h/design/adobe.cc/Adobe-Illustrator-2025-29.0.1.192-m0nkrus.MUI.zip"
if %choice%==0 goto menu
goto menu

:app_menu
:: %1: Thư mục cha, %2: Tên file exe, %3: Tiêu đề hiển thị, %4: Link tải ứng dụng
set "appName=%~1"
set "appExe=%~2"
set "titleName=%~3"
set "downloadURL=%~4"

set "path64=%ProgramFiles%\Adobe\%appName%"
set "path32=%ProgramFiles(x86)%\Adobe\%appName%"

:sub_menu
cls
title %titleName%
echo:     %C%______________________________________________________________%Res%
echo:
echo:                    %Y%[%titleName% x64]%Res%
echo:     %C%______________________________________________________________%Res%
echo:         %B%[1]%Res% %G%FULL%Res%: Tai, Cai dat ^& Kich hoat
echo:         %B%[2]%Res% Chi kich hoat Adobe %W%(Neu da cai san)%Res%
echo:         %B%[3]%Res% Chan Firewall ^& Update Hosts %W%(Chan quet ban quyen)%Res%
echo:         %R%[0]%Res% Quay lai menu chinh
echo:     %C%______________________________________________________________%Res%
echo.
choice /C:1230 /N
set "subChoice=%errorlevel%"

if %subChoice%==1 goto task_full
if %subChoice%==2 goto task_patch
if %subChoice%==3 goto task_security
if %subChoice%==4 goto adobe
goto sub_menu

:task_full
cls
echo:     %Y%[==^> Dang kiem tra trang thai he thong...]%Res%
set "foundPath="
if exist "%path64%\%appExe%" set "foundPath=%path64%"
if exist "%path32%\%appExe%" set "foundPath=%path32%"

if defined foundPath (
    echo:    %R%[[!] Phat hien %appName% da duoc cai dat tai:]%Res% "%foundPath%"
    echo:    %Y%[==^> Chuyen huong sang buoc kich hoat sau 3 giay...]%Res%
    timeout /t 3 >nul
    goto task_patch
)

echo:     %W%[==^> Dang tai %appName%...]%Res%
if not exist "%source%" md "%source%"
curl --ssl-no-revoke --progress-bar -L -# -o "%source%\app.zip" "%downloadURL%"

echo:     %W%[==^> Tam tat Antivirus de chay cai dat...]%Res%
powershell -Command "Add-MpPreference -ExclusionPath '%source%'" >nul 2>&1
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true -DisableBehaviorMonitoring $true -DisableIOAVProtection $true -DisableIntrusionPreventionSystem $true -DisableScriptScanning $true -SubmitSamplesConsent 2" >nul 2>&1

echo:     %W%[==^> Dang giai nen va cai dat...]%Res%
powershell -Command "Expand-Archive -Path '%source%\app.zip' -DestinationPath '%source%' -Force"
echo:     %W%[==^> Dang tim file setup.exe trong cac thu muc con...]%Res%
set "setupPath="
for /r "%source%" %%F in (setup.exe set-up.exe) do (
    if exist "%%F" (
        set "setupPath=%%F"
        goto :found_setup
    )
)

:found_setup
if defined setupPath (
    echo:     %G%[==^> Da tim thay: "%setupPath%"]%Res%
    echo:     %W%[==^> Hien popup -> click%Res% %Y%Install%Res% %W%-> click%Res% %Y%Close%Res% %W%de hoan tat cai dat...]%Res%
    start /wait "" "%setupPath%"
) else (
    echo:     %R%[[!] LOI: Khong tim thay file setup.exe sau khi giai nen.]%Res%
    pause
)

:: Xóa file zip ứng dụng ngay để giải phóng bộ nhớ
del /f /q "%source%\app.zip" >nul 2>&1

:task_patch
cls
echo:     %W%[==^> Dang chuan bi tien hanh kich hoat...]%Res%
if not exist "%source%" md "%source%"
curl --ssl-no-revoke --progress-bar -L -# -o "%source%\GenP.zip" "https://raw.githubusercontent.com/itsup-ftel/tools/refs/heads/main/file/GenP-v4.0.4.zip"

echo:     %W%[==^> Tam tat Antivirus de chay GenP...]%Res%
powershell -Command "Add-MpPreference -ExclusionPath '%source%'" >nul 2>&1
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true -DisableBehaviorMonitoring $true -DisableIOAVProtection $true -DisableIntrusionPreventionSystem $true -DisableScriptScanning $true -SubmitSamplesConsent 2" >nul 2>&1

echo:     %W%[==^> Dang giai nen GenP...]%Res%
powershell -Command "Expand-Archive -Path '%source%\GenP.zip' -DestinationPath '%source%\GenP' -Force"

echo:     %C%______________________________________________________________%Res%
echo: %Y%[HUONG DAN THAO TAC:]%Res%
echo:     1. Cua so GenP se mo len ngay sau day.
echo:     2. Nhan nut %B%["Search"]%Res% de GenP tim kiem trong may.
echo:     3. Nhan nut %G%["Patch"]%Res% va cho den khi chay xong.
echo:     4. Dong GenP va quay lai day de chay buoc bao mat (Muc 3).
echo:     %C%______________________________________________________________%Res%
timeout /t 5
start /wait "" "%source%\GenP\GenP-v4.0.4.exe"

:task_security
cls
set "common64=%ProgramFiles%\Common Files\Adobe"
set "common32=%ProgramFiles(x86)%\Common Files\Adobe"

echo     %W%==^> Dang thiet lap Firewall Rules cho %appName% va Common Files...%Res%

:: Vòng lặp tối ưu quét qua tất cả thư mục ứng dụng và thư mục Common Files
for %%P in ("%path64%" "%%path32%%" "%common64%" "%common32%") do (
    :: Kiểm tra nếu thư mục tồn tại thì mới tiến hành chặn để tránh rác Firewall
    if exist "%%~P" (
        for %%D in (in out) do (
            :: Chặn file thực thi chính của ứng dụng (chỉ áp dụng nếu là thư mục ứng dụng gốc)
            if exist "%%~P\%appExe%" (
                netsh advfirewall firewall add rule name="Adobe_!appExe!_%%D" dir=%%D program="%%~P\%appExe%" action=block >nul 2>&1
            )
            :: Chặn toàn bộ kết nối từ thư mục (bao gồm cả thư mục cài đặt và thư mục Common Files)
            netsh advfirewall firewall add rule name="Adobe_Folder_Block_%%D" dir=%%D program="%%~P" action=block >nul 2>&1
        )
    )
)
netsh advfirewall set allprofiles state on >nul 2>&1
echo:     %G%[OK] Da thiet lap Firewall (bao gom Common Files) thanh cong.%Res%

:: Tải danh sách Hosts
echo:     %C%[==^> Dang tai danh sach host adobe..]%Res%
curl --ssl-no-revoke -L -s -f -o "%tempHosts%" "%hostsURL%"

if %errorlevel% neq 0 (
    echo:     %R%[[!] Khong the ket noi GitHub. Dang chuyen sang danh sach thu manual...]%Res%
    (echo 127.0.0.1 192.150.14.69 & echo 127.0.0.1 192.150.18.101) > "%tempHosts%"
) else (
    echo:     %G%[OK] Da tai danh sach chan adobe thanh cong.%Res%
)

:: Trộn vào file Hosts hệ thống bằng PowerShell
echo:     %W%[==^> Dang ghi du lieu vao file Hosts...]%Res%
attrib -r "%hPath%" >nul 2>&1
powershell -NoProfile -Command ^
    "$path='%hPath%'; $txt='%tempHosts%'; $s='#region Adobe'; $e='#endregion'; " ^
    "if (!(Test-Path $txt)) { exit }; " ^
    "$newLines = Get-Content $txt | Where-Object { $_.Trim() -ne '' }; " ^
    "$oldContent = Get-Content $path -ErrorAction SilentlyContinue; " ^
    "if (!$oldContent) { $oldContent = @() }; " ^
    "$finalList = New-Object System.Collections.Generic.List[string]; $skip = $false; " ^
    "foreach ($line in $oldContent) { " ^
    "    if ($line.Trim() -eq $s) { $skip = $true; continue }; " ^
    "    if ($line.Trim() -eq $e) { $skip = $false; continue }; " ^
    "    if (!$skip) { $finalList.Add($line) }; " ^
    "}; " ^
    "$finalList.Add($s); foreach ($nl in $newLines) { $finalList.Add($nl) }; $finalList.Add($e); " ^
    "[System.IO.File]::WriteAllLines($path, $finalList);"
echo:     %G%[OK] Da update file hosts thanh cong.%Res%

:: Thêm thư mục cài đặt vào Defender Exclusion
echo:     %W%[==^> Dang them thu muc cai dat vao danh sach loai tru...]%Res%
powershell -Command "Add-MpPreference -ExclusionPath '%ProgramFiles%\Adobe', '%ProgramFiles(x86)%\Adobe'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionPath '%ProgramFiles%\Common Files\Adobe', '%ProgramFiles(x86)%\Common Files\Adobe'" >nul 2>&1
echo:     %G%[OK] Da them loai tru thanh cong.%Res%

:: Dọn dẹp hệ thống an toàn
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $false -DisableBehaviorMonitoring $false -DisableIOAVProtection $false -DisableIntrusionPreventionSystem $false -DisableScriptScanning $false" >nul 2>&1
if exist "%source%" rmdir /s /q "%source%"
if exist "%tempHosts%" del /f "%tempHosts%" >nul 2>&1

echo:     %G%______________________________________________________________%Res%
echo:              %G%[HOAN TAT QUY TRINH KICH HOAT %titleName%]%Res%
echo:     %G%______________________________________________________________%Res%
pause
goto adobe

:autodesk
cls
mode 85, 35
title AUTODESK Install
set "source=%TEMP%\Autodesk_Source"
set "hostsURL=https://raw.githubusercontent.com/itsup-ftel/tools/refs/heads/main/file/hostautodesk.txt"
set "tempHosts=%TEMP%\autodesk_hosts.txt"
set "hPath=%SystemRoot%\System32\drivers\etc\hosts"
echo:     %C%______________________________________________________________%Res%
echo:
echo:                    %Y%[AUTODESK PREMIUM LIST]%Res%
echo:     %C%______________________________________________________________%Res%
echo:         %G%[1]%Res% AutoCAD 2021
echo:         %G%[2]%Res% AutoCAD 2023
echo:         %G%[3]%Res% Inventor
echo:         %G%[4]%Res% Revit	
echo:         %G%[5]%Res% SketchUp
echo:         %R%[0]%Res% Thoat ve menu chinh
echo:     %C%______________________________________________________________%Res%
echo.
choice /C:12340 /N
set "choice=%errorlevel%"

if %choice%==1 call :autodesk_menu "AutoCAD 2021" "Acad.exe" "AUTOCAD 2021" "https://vnshort.com/nMaV"
if %choice%==2 call :autodesk_menu "AutoCAD 2023" "Acad.exe" "AUTOCAD 2023" "https://vnshort.com/Z4KR"
if %choice%==3 call :autodesk_menu "Inventor" "Inventor.exe" "INVENTOR 20xx" "https://"
if %choice%==4 call :autodesk_menu "Revit" "Revit.exe" "REVIT 20xx" "https://"
if %choice%==5 call :autodesk_menu "Revit" "Revit.exe" "REVIT 20xx" "https://"
if %choice%==0 goto menu
goto menu

:autodesk_menu
:: %1: Thư mục cha, %2: Tên file exe, %3: Tiêu đề hiển thị, %4: Link tải ứng dụng
set "appName=%~1"
set "appExe=%~2"
set "titleName=%~3"
set "downloadURL=%~4"

set "path64=%ProgramFiles%\Autodesk\%appName%"
set "path32=%ProgramFiles(x86)%\Autodesk\%appName%"

:subdesk_menu
cls
title %titleName%
echo:     %C%______________________________________________________________%Res%
echo:
echo:                    %Y%[%titleName% x64]%Res%
echo:     %C%______________________________________________________________%Res%
echo:         %B%[1]%Res% %G%FULL%Res%: Tai, Cai dat ^& Kich hoat
echo:         %B%[2]%Res% Chi kich hoat Autodesk %W%(Neu da cai san)%Res%
echo:         %B%[3]%Res% Chan Firewall ^& Update Hosts %W%(Chan quet ban quyen)%Res%
echo:         %R%[0]%Res% Quay lai menu chinh
echo:     %C%______________________________________________________________%Res%
echo.
choice /C:1230 /N
set "subChoice=%errorlevel%"

if %subChoice%==1 goto job_full
if %subChoice%==2 goto job_patch
if %subChoice%==3 goto job_security
if %subChoice%==4 goto autodesk
goto subdesk_menu

:job_full
cls
echo:     %Y%[==^> Dang kiem tra trang thai he thong...]%Res%
set "foundPath="
if exist "%path64%\%appExe%" set "foundPath=%path64%"
if exist "%path32%\%appExe%" set "foundPath=%path32%"

if defined foundPath (
    echo:    %R%[[!] Phat hien %appName% da duoc cai dat tai:]%Res% "%foundPath%"
    echo:    %Y%[==^> Chuyen huong sang buoc kich hoat sau 3 giay...]%Res%
    timeout /t 3 >nul
    goto job_patch
)

echo:     %W%[==^> Dang tai %appName%...]%Res%
if not exist "%source%" md "%source%"
curl --ssl-no-revoke --progress-bar -L -# -o "%source%\autodesk.zip" "%downloadURL%"

echo:     %W%[==^> Tam tat Antivirus de chay cai dat...]%Res%
powershell -Command "Add-MpPreference -ExclusionPath '%source%'" >nul 2>&1
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true -DisableBehaviorMonitoring $true -DisableIOAVProtection $true -DisableIntrusionPreventionSystem $true -DisableScriptScanning $true -SubmitSamplesConsent 2" >nul 2>&1

echo:     %W%[==^> Dang giai nen va cai dat...]%Res%
powershell -Command "Expand-Archive -Path '%source%\autodesk.zip' -DestinationPath '%source%' -Force"
echo:     %W%[==^> Dang tim file setup.exe trong cac thu muc con...]%Res%
set "setupPath="
for /r "%source%" %%F in (setup.exe set-up.exe) do (
    if exist "%%F" (
        set "setupPath=%%F"
        goto :found_setup
    )
)

:found_setup
if defined setupPath (
    echo:     %G%[==^> Da tim thay: "%setupPath%"]%Res%
    echo:     %W%[==^> Hien popup -> click%Res% %Y%Install%Res% %W%-> click%Res% %Y%Close%Res% %W%de hoan tat cai dat...]%Res%
    start /wait "" "%setupPath%"
) else (
    echo:     %R%[[!] LOI: Khong tim thay file setup.exe sau khi giai nen.]%Res%
    pause
)

:: Xóa file zip ứng dụng ngay để giải phóng bộ nhớ
del /f /q "%source%\autodesk.zip" >nul 2>&1

:job_patch
cls
echo:     %W%[==^> Dang tien hanh kich hoat...]%Res%
xcopy "%source%\Fix\*.*" "%foundPath%\%appExe%\" /E /I /H /Y /R /Q >nul


:job_security
cls
set "autodesk64=%ProgramFiles%\Autodesk"
set "autodesk32=%ProgramFiles(x86)%\Autodesk"
set "common64=%ProgramFiles%\Common Files\Autodesk Shared"
set "common32=%ProgramFiles(x86)%\Common Files\Autodesk Shared"
set "roamingdesk=%AppData%\Autodesk"
set "localdesk=%localappdata%\Autodesk"

echo     %W%==^> Dang thiet lap Firewall Rules cho %appName% va Common Files...%Res%

:: Vòng lặp tối ưu quét qua tất cả thư mục ứng dụng và thư mục Common Files
for %%P in ("%path64%" "%%path32%%" "%autodesk64%" "%autodesk32%" "%common64%" "%common32%" "%roamingdesk%" "%localdesk%") do (
    :: Kiểm tra nếu thư mục tồn tại thì mới tiến hành chặn để tránh rác Firewall
    if exist "%%~P" (
        for %%D in (in out) do (
            :: Chặn file thực thi chính của ứng dụng (chỉ áp dụng nếu là thư mục ứng dụng gốc)
            if exist "%%~P\%appExe%" (
                netsh advfirewall firewall add rule name="Autodesk_!appExe!_%%D" dir=%%D program="%%~P\%appExe%" action=block >nul 2>&1
            )
            :: Chặn toàn bộ kết nối từ thư mục (bao gồm cả thư mục cài đặt và thư mục Common Files)
            netsh advfirewall firewall add rule name="Autodesk_Folder_Block_%%D" dir=%%D program="%%~P" action=block >nul 2>&1
        )
    )
)
netsh advfirewall set allprofiles state on >nul 2>&1
echo:     %G%[OK] Da thiet lap Firewall (bao gom Common Files) thanh cong.%Res%

:: Tải danh sách Hosts
echo:     %C%[==^> Dang tai danh sach host Autodesk..]%Res%
curl --ssl-no-revoke -L -s -f -o "%tempHosts%" "%hostsURL%"

if %errorlevel% neq 0 (
    echo:     %R%[[!] Khong the ket noi GitHub. Dang chuyen sang danh sach thu manual...]%Res%
    (echo 127.0.0.1 192.150.14.69 & echo 127.0.0.1 192.150.18.101) > "%tempHosts%"
) else (
    echo:     %G%[OK] Da tai danh sach chan Autodesk thanh cong.%Res%
)

:: Trộn vào file Hosts hệ thống bằng PowerShell
echo:     %W%[==^> Dang ghi du lieu vao file Hosts...]%Res%
attrib -r "%hPath%" >nul 2>&1
powershell -NoProfile -Command ^
    "$path='%hPath%'; $txt='%tempHosts%'; $s='#region Autodesk'; $e='#endregion'; " ^
    "if (!(Test-Path $txt)) { exit }; " ^
    "$newLines = Get-Content $txt | Where-Object { $_.Trim() -ne '' }; " ^
    "$oldContent = Get-Content $path -ErrorAction SilentlyContinue; " ^
    "if (!$oldContent) { $oldContent = @() }; " ^
    "$finalList = New-Object System.Collections.Generic.List[string]; $skip = $false; " ^
    "foreach ($line in $oldContent) { " ^
    "    if ($line.Trim() -eq $s) { $skip = $true; continue }; " ^
    "    if ($line.Trim() -eq $e) { $skip = $false; continue }; " ^
    "    if (!$skip) { $finalList.Add($line) }; " ^
    "}; " ^
    "$finalList.Add($s); foreach ($nl in $newLines) { $finalList.Add($nl) }; $finalList.Add($e); " ^
    "[System.IO.File]::WriteAllLines($path, $finalList);"
echo:     %G%[OK] Da update file hosts thanh cong.%Res%

:: Thêm thư mục cài đặt vào Defender Exclusion
echo:     %W%[==^> Dang them thu muc cai dat vao danh sach loai tru...]%Res%
powershell -Command "Add-MpPreference -ExclusionPath '%ProgramFiles%\Autodesk', '%ProgramFiles(x86)%\Autodesk'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionPath '%ProgramFiles%\Common Files\Autodesk', '%ProgramFiles(x86)%\Common Files\Autodesk'" >nul 2>&1
echo:     %G%[OK] Da them loai tru thanh cong.%Res%

:: Dọn dẹp hệ thống an toàn
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $false -DisableBehaviorMonitoring $false -DisableIOAVProtection $false -DisableIntrusionPreventionSystem $false -DisableScriptScanning $false" >nul 2>&1
if exist "%source%" rmdir /s /q "%source%"
if exist "%tempHosts%" del /f "%tempHosts%" >nul 2>&1

echo:     %G%______________________________________________________________%Res%
echo:              %G%[HOAN TAT QUY TRINH KICH HOAT %titleName%]%Res%
echo:     %G%______________________________________________________________%Res%
pause
goto autodesk

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
