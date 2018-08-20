# require .NET 4 runtime

Set-ExecutionPolicy Bypass -Scope Process -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function download-string($url) {
  (New-Object System.Net.WebClient).DownloadString($url)
}

function refresh-env($name) {
  Set-Item -Path env:$name -Value ([Environment]::GetEnvironmentVariable($name, [EnvironmentVariableTarget]::Machine))
}

Write-Host '[!] Disable policies'
download-string 'https://sjb.koyo.io/src/disable-policies.ps1' | iex | Out-Null
Write-Host '[!] Configure hosts'
download-string 'https://sjb.koyo.io/src/configure-hosts.ps1' | iex | Out-Null
Write-Host '[!] Install packages'
download-string 'https://sjb.koyo.io/src/install-packages.ps1' | iex | Out-Null

Write-Host '[!] Complete' -ForegroundColor green
Read-Host
