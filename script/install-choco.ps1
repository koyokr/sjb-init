# require init

# install choco
Refresh-Environment 'ChocolateyInstall'
if ($env:ChocolateyInstall -eq $null) {
  Download-String 'https://chocolatey.org/install.ps1' | iex
}
