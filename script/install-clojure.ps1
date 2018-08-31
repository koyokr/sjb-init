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
    }
]
'@ | Set-Content -Path $env:APPDATA\Code\User\keybindings.json

# download clojurescript
curl -L https://github.com/clojure/clojurescript/releases/download/r1.10.339/cljs.jar `
  -o $env:USERPROFILE\Documents\cljs.jar

# install nodejs
choco install nodejs.install -y
