
# choco
Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# firefox
choco install firefox -y

# putty
choco install putty.install d2codingfont -y

# go, nodejs, python
choco install golang nodejs.install python -y

# leiningen
choco install curl -y
$env:HTTP_CLIENT = 'curl -f -L -k -o'
choco install lein -y

# clojurescript
curl -L https://github.com/clojure/clojurescript/releases/download/r1.10.339/cljs.jar \
  -o $env:USERPROFILE\Documents\cljs.jar

# vscode
choco install vscode git -y

# refresh env
$env:Path = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)

# vscode extension
code --install-extension ms-ceintl.vscode-language-pack-ko
code --install-extension ms-python.python
code --install-extension ms-vscode.go
code --install-extension avli.clojure
code --install-extension eamodio.gitlens
code --install-extension davidanson.vscode-markdownlint
code --install-extension yzhang.markdown-all-in-one
'{"locale":"ko"}' > $env:APPDATA\Code\User\locale.json
