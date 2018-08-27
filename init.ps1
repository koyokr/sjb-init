# require .NET 4 runtime

Set-ExecutionPolicy Bypass -Scope Process -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function download-string($url) {
  (New-Object System.Net.WebClient).DownloadString($url)
}

function refresh-env($name) {
  Set-Item -Path env:$name -Value ([Environment]::GetEnvironmentVariable($name, [EnvironmentVariableTarget]::Machine))
}

Write-Host '[!] disable-policies'; download-string 'https://sjb.koyo.io/src/disable-policies.ps1' | iex | Out-Null
Write-Host '[!] configure-hosts'; download-string 'https://sjb.koyo.io/src/configure-hosts.ps1' | iex | Out-Null
Write-Host '[!] install-choco'; download-string 'https://sjb.koyo.io/src/install-choco.ps1' | iex | Out-Null
Write-Host '[!] install-firefox'; download-string 'https://sjb.koyo.io/src/install-firefox.ps1' | iex | Out-Null
Write-Host '[!] Complete' -ForegroundColor green; Read-Host
