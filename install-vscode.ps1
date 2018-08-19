# require choco

function refresh-env($name) {
  Set-Item -Path env:$name -Value ([Environment]::GetEnvironmentVariable($name, [EnvironmentVariableTarget]::Machine))
}

# install vscode, git
choco install vscode git -y
refresh-env 'Path'

# install extension language-pack-ko
code --install-extension ms-ceintl.vscode-language-pack-ko
'{"locale":"ko"}' | Set-Content -Path $env:APPDATA\Code\User\locale.json

# install extension other
code --install-extension eamodio.gitlens
code --install-extension avli.clojure
