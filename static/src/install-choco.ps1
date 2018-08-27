# require init

# install choco
refresh-env 'ChocolateyInstall'
if ($env:ChocolateyInstall -eq $null) {
  download-string 'https://chocolatey.org/install.ps1' | iex
}
