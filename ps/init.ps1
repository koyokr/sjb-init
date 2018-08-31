# require .NET 4 runtime

Set-ExecutionPolicy Bypass -Scope Process -Force

function Download-String($url) {
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  (New-Object System.Net.WebClient).DownloadString($url)
}

function Refresh-Environment($name) {
  Set-Item -Path env:$name -Value ([Environment]::GetEnvironmentVariable($name, [EnvironmentVariableTarget]::Machine))
}

Write-Host '[!] common/init.ps1'; Download-String 'https://sjb.koyo.io/common/init.ps1' | iex | Out-Null
Write-Host '[!] script/install-powershell.ps1'; Download-String 'https://sjb.koyo.io/script/install-powershell.ps1' | iex | Out-Null
