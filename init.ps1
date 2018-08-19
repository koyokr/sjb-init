Set-ExecutionPolicy Bypass -Scope Process -Force

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
function download-string($url) {
  (New-Object System.Net.WebClient).DownloadString($url)
}

Write-Host '[!] Disable policies'
download-string 'https://sjb.koyo.io/disable-policies.ps1' | iex | Out-Null
Write-Host '[!] Configure hosts'
download-string 'https://sjb.koyo.io/configure-hosts.ps1' | iex | Out-Null
Write-Host '[!] Install packages'
download-string 'https://sjb.koyo.io/install-packages.ps1' | iex | Out-Null

Write-Host '[!] Complete' -ForegroundColor green
Read-Host
