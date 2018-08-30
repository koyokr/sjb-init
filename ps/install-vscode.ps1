# require init, choco

# install vscode, git
choco install vscode git -y
refresh-env 'Path'

# install extension language-pack-ko
code --install-extension ms-ceintl.vscode-language-pack-ko
@'
{
    "locale": "ko"
}
'@ | Set-Content -Path $env:APPDATA\Code\User\locale.json

# install extension other
code --install-extension eamodio.gitlens
code --install-extension avli.clojure
code --install-extension ms-vscode.csharp
@'
[
    {
        "key": "ctrl+oem_period",
        "command": "clojureVSCode.eval"
    },
    {
        "key": "ctrl+oem_2",
        "command": "clojureVSCode.evalAndShowResult"
    }
]
'@ | Set-Content -Path $env:APPDATA\Code\User\keybindings.json
