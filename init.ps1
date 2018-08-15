$url = 'https://sjb.koyo.io'

Set-ExecutionPolicy Bypass -Scope Process -Force
if ($env:ChocolateyInstall -eq $null) {
  iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  choco install curl -y
}

curl -L $url/disable-policies.ps1 | iex
curl -L $url/configure-hosts.ps1 | iex
curl -L $url/install-packages.ps1 | iex
