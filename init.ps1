# install choco
Set-ExecutionPolicy Bypass -Scope Process -Force
if ($env:ChocolateyInstall -eq $null) {
  iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
# install curl
choco install curl -y

# set url
$url = 'https://sjb.koyo.io'

# refresh env
$env:Path = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)

curl -L $url/disable-policies.ps1 | Out-String | iex
curl -L $url/configure-hosts.ps1 | Out-String | iex
curl -L $url/install-packages.ps1 | Out-String | iex
