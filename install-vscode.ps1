# require choco

# install vscode, git
choco install vscode git -y

# refresh env
$env:Path = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)

# install extension language-pack-ko
code --install-extension ms-ceintl.vscode-language-pack-ko
'{"locale":"ko"}' | Set-Content -Path $env:APPDATA\Code\User\locale.json

# install extension other
code --install-extension eamodio.gitlens
code --install-extension avli.clojure

code; Stop-Process code
