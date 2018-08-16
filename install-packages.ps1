# require choco, curl

$url = 'https://sjb.koyo.io'

# refresh env
$env:Path = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)

# install firefox
choco install firefox -y

# install vscode
curl -L $url/install-vscode.ps1 | Out-String | iex

# install clojure
curl -L $url/install-clojure.ps1 | Out-String | iex

# install putty, font
choco install putty.install  d2codingfont -y
