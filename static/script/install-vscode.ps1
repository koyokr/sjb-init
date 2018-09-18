# require init, choco

# install vscode, git
choco install vscode git.install -y
Refresh-Environment 'Path'

# install extension language-pack-ko
code --install-extension ms-ceintl.vscode-language-pack-ko
@'
{
    "locale": "ko"
}
'@ | Set-Content -Path $env:APPDATA\Code\User\locale.json

# install extension gitlens
code --install-extension eamodio.gitlens
