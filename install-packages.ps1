# require init.ps1

# install choco
refresh-env 'ChocolateyInstall'
if ($env:ChocolateyInstall -eq $null) {
  download-string 'https://chocolatey.org/install.ps1' | iex
}

# install firefox
choco install firefox -y

# install vscode, clojure
download-string 'https://sjb.koyo.io/install-vscode.ps1' | Out-String | iex
download-string 'https://sjb.koyo.io/install-clojure.ps1' | Out-String | iex

# install putty, font
choco install putty.install d2codingfont -y
