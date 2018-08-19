Set-ExecutionPolicy Bypass -Scope Process -Force

function refresh-env($name) {
  Set-Item -Path env:$name -Value ([Environment]::GetEnvironmentVariable($name, [EnvironmentVariableTarget]::Machine))
}

# install choco
refresh-env 'ChocolateyInstall'
if ($env:ChocolateyInstall -eq $null) {
  download-string 'https://chocolatey.org/install.ps1' | iex
}

# install firefox, curl
choco install firefox, curl -y
refresh-env 'Path'

# install vscode, clojure
curl -L https://sjb.koyo.io/install-vscode.ps1 | Out-String | iex
curl -L https://sjb.koyo.io/install-clojure.ps1 | Out-String | iex

# install putty, font
choco install putty.install d2codingfont -y
