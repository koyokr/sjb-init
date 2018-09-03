# require choco, vscode

# install leiningen
choco install curl -y
$env:HTTP_CLIENT = 'curl -f -L -k -o'
choco install jdk8 lein -y

# install vscode extension
code --install-extension avli.clojure
@'
[
    {
        "key": "ctrl+oem_period",
        "command": "clojureVSCode.eval"
    },
    {
        "key": "ctrl+oem_2",
        "command": "clojureVSCode.evalAndShowResult"
    },
    {
        "key": "ctrl+oem_1",
        "command": "clojureVSCode.formatFile"
    },
    {
        "key": "ctrl+oem_7",
        "command": "clojureVSCode.testNamespace"
    }
]
'@ | Set-Content -Path $env:APPDATA\Code\User\keybindings.json

# install nodejs
choco install nodejs.install -y
