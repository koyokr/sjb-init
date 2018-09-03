# require .NET 4 runtime

Set-ExecutionPolicy Bypass -Scope Process -Force

function Download-String($url) {
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  (New-Object System.Net.WebClient).DownloadString($url)
}

function Refresh-Environment($name) {
  Set-Item -Path env:$name -Value ([Environment]::GetEnvironmentVariable($name, [EnvironmentVariableTarget]::Machine))
}

Write-Host '[!] script/disable-policies.ps1'; Download-String 'https://sjb.koyo.io/script/disable-policies.ps1' | iex | Out-Null
Write-Host '[!] script/configure-dns.ps1'; Download-String 'https://sjb.koyo.io/script/configure-dns.ps1' | iex | Out-Null
Write-Host '[!] script/configure-hosts.ps1'; Download-String 'https://sjb.koyo.io/script/configure-hosts.ps1' | iex | Out-Null
Write-Host '[!] script/install-choco.ps1'; Download-String 'https://sjb.koyo.io/script/install-choco.ps1' | iex | Out-Null
Write-Host '[!] script/install-firefox.ps1'; Download-String 'https://sjb.koyo.io/script/install-firefox.ps1' | iex | Out-Null
Write-Host '[!] script/install-vscode.ps1'; Download-String 'https://sjb.koyo.io/script/install-vscode.ps1' | iex | Out-Null
Write-Host '[!] script/install-putty.ps1'; Download-String 'https://sjb.koyo.io/script/install-putty.ps1' | iex | Out-Null
