# require .NET 4 runtime

Set-ExecutionPolicy Bypass -Scope Process -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function download-string($url) {
  (New-Object System.Net.WebClient).DownloadString($url)
}

function refresh-env($name) {
  Set-Item -Path env:$name -Value ([Environment]::GetEnvironmentVariable($name, [EnvironmentVariableTarget]::Machine))
}

Write-Host '[!] common/init.ps1'; download-string 'https://sjb.koyo.io/common/init.ps1' | iex | Out-Null
Write-Host '[!] ps/install-vscode.ps1'; download-string 'https://sjb.koyo.io/ps/install-vscode.ps1' | iex | Out-Null
Write-Host '[!] ps/install-dotnet.ps1'; download-string 'https://sjb.koyo.io/ps/install-dotnet.ps1' | iex | Out-Null
Write-Host '[!] ps/install-putty.ps1'; download-string 'https://sjb.koyo.io/ps/install-putty.ps1' | iex | Out-Null
