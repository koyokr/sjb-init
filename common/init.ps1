# require .NET 4 runtime

Set-ExecutionPolicy Bypass -Scope Process -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function download-string($url) {
  (New-Object System.Net.WebClient).DownloadString($url)
}

function refresh-env($name) {
  Set-Item -Path env:$name -Value ([Environment]::GetEnvironmentVariable($name, [EnvironmentVariableTarget]::Machine))
}

Write-Host '[!] ps/disable-policies.ps1'; download-string 'https://sjb.koyo.io/ps/disable-policies.ps1' | iex | Out-Null
Write-Host '[!] ps/configure-hosts.ps1'; download-string 'https://sjb.koyo.io/ps/configure-hosts.ps1' | iex | Out-Null
Write-Host '[!] ps/install-choco.ps1'; download-string 'https://sjb.koyo.io/ps/install-choco.ps1' | iex | Out-Null
Write-Host '[!] ps/install-firefox.ps1'; download-string 'https://sjb.koyo.io/ps/install-firefox.ps1' | iex | Out-Null
