# require .NET 4 runtime

Set-ExecutionPolicy Bypass -Scope Process -force

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function download-file($url, $file) {
(new-object System.Net.WebClient).DownloadFile($url, $file)
}

function download-string($url) {
(new-object System.Net.WebClient).DownloadString($url)
}

function refresh-environment($name) {
set-item -path env:$name -value ([Environment]::GetEnvironmentVariable($name, [EnvironmentVariableTarget]::Machine))
}

function configure-dns {
netsh interface ip set dns "로컬 영역 연결" static 1.1.1.1 primary
netsh interface ip add dns "로컬 영역 연결" 1.0.0.1
ipconfig /flushdns
}

function configure-hosts {
download-string "https://sjb.koyo.io/hosts" | set-content -path C:\Windows\System32\drivers\etc\hosts
}

function disable-policies {
# disable policies registry, taskmgr
set-itemproperty -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System -name DisableRegistryTools -value 0
set-itemproperty -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System -name DisableTaskMgr       -value 0
# disable policies explorer, keyboard
remove-item -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -recurse -force -erroraction silentlycontinue
remove-item -path HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -recurse -force -erroraction silentlycontinue
remove-item -path HKLM:\SYSTEM\CurrentControlSet\Control\"Keyboard Layout"          -recurse -force -erroraction silentlycontinue
# restart explorer
stop-process -name explorer
}

function install-bandizip {
$bandizip = "BANDIZIP-SETUP-KR.EXE"
download-file "https://dl.bandisoft.com/bandizip.kr/$bandizip" $bandizip
& .\$bandizip /S
}

function install-choco {
refresh-environment "ChocolateyInstall"
if ($env:ChocolateyInstall -eq $null) {
  download-string "https://chocolatey.org/install.ps1" | iex
}
}

function install-vscode {
choco install vscode -y
refresh-environment "Path"
# install extension language-pack-ko
code --install-extension ms-ceintl.vscode-language-pack-ko
@"
{
  "locale": "ko"
}
"@ | set-content -path $env:APPDATA\Code\User\locale.json

$version = (code --list-extensions --show-versions | select-string vscode-language-pack | out-string).trim().split('@')[1]
$translations = "$env:USERPROFILE/.vscode/extensions/ms-ceintl.vscode-language-pack-ko-$version/translations".replace("\", "/")
$extensions   = "$translations/extensions"
@"
{
  "ko": {
    "hash": "",
    "translations": {
      "vscode": "$translations/main.i18n.json",
      "vscode.bat": "$extensions/bat.i18n.json",
      "vscode.clojure": "$extensions/clojure.i18n.json",
      "vscode.coffeescript": "$extensions/coffeescript.i18n.json",
      "vscode.configuration-editing": "$extensions/configuration-editing.i18n.json",
      "vscode.csharp": "$extensions/csharp.i18n.json",
      "vscode.cpp": "$extensions/cpp.i18n.json",
      "vscode.css": "$extensions/css.i18n.json",
      "vscode.css-language-features": "$extensions/css-language-features.i18n.json",
      "vscode.debug-auto-launch": "$extensions/debug-auto-launch.i18n.json",
      "vscode.docker": "$extensions/docker.i18n.json",
      "vscode.extension-editing": "$extensions/extension-editing.i18n.json",
      "vscode.fsharp": "$extensions/fsharp.i18n.json",
      "vscode.emmet": "$extensions/emmet.i18n.json",
      "vscode.go": "$extensions/go.i18n.json",
      "vscode.groovy": "$extensions/groovy.i18n.json",
      "vscode.grunt": "$extensions/grunt.i18n.json",
      "vscode.gulp": "$extensions/gulp.i18n.json",
      "vscode.handlebars": "$extensions/handlebars.i18n.json",
      "vscode.hlsl": "$extensions/hlsl.i18n.json",
      "vscode.html": "$extensions/html.i18n.json",
      "vscode.html-language-features": "$extensions/html-language-features.i18n.json",
      "vscode.git": "$extensions/git.i18n.json",
      "vscode.ini": "$extensions/ini.i18n.json",
      "vscode.jake": "$extensions/jake.i18n.json",
      "vscode.java": "$extensions/java.i18n.json",
      "vscode.javascript": "$extensions/javascript.i18n.json",
      "vscode.json-language-features": "$extensions/json-language-features.i18n.json",
      "vscode.json": "$extensions/json.i18n.json",
      "vscode.less": "$extensions/less.i18n.json",
      "vscode.log": "$extensions/log.i18n.json",
      "vscode.lua": "$extensions/lua.i18n.json",
      "vscode.make": "$extensions/make.i18n.json",
      "vscode.markdown-basics": "$extensions/markdown-basics.i18n.json",
      "vscode.merge-conflict": "$extensions/merge-conflict.i18n.json",
      "vscode.markdown-language-features": "$extensions/markdown-language-features.i18n.json",
      "vscode.npm": "$extensions/npm.i18n.json",
      "vscode.objective-c": "$extensions/objective-c.i18n.json",
      "vscode.perl": "$extensions/perl.i18n.json",
      "vscode.php": "$extensions/php.i18n.json",
      "vscode.powershell": "$extensions/powershell.i18n.json",
      "vscode.php-language-features": "$extensions/php-language-features.i18n.json",
      "vscode.pug": "$extensions/pug.i18n.json",
      "vscode.razor": "$extensions/razor.i18n.json",
      "vscode.python": "$extensions/python.i18n.json",
      "vscode.r": "$extensions/r.i18n.json",
      "vscode.rust": "$extensions/rust.i18n.json",
      "vscode.ruby": "$extensions/ruby.i18n.json",
      "vscode.scss": "$extensions/scss.i18n.json",
      "vscode.search-rg": "$extensions/search-rg.i18n.json",
      "vscode.shaderlab": "$extensions/shaderlab.i18n.json",
      "vscode.swift": "$extensions/swift.i18n.json",
      "vscode.sql": "$extensions/sql.i18n.json",
      "vscode.shellscript": "$extensions/shellscript.i18n.json",
      "vscode.theme-kimbie-dark": "$extensions/theme-kimbie-dark.i18n.json",
      "vscode.theme-defaults": "$extensions/theme-defaults.i18n.json",
      "vscode.theme-abyss": "$extensions/theme-abyss.i18n.json",
      "vscode.theme-monokai-dimmed": "$extensions/theme-monokai-dimmed.i18n.json",
      "vscode.theme-monokai": "$extensions/theme-monokai.i18n.json",
      "vscode.theme-quietlight": "$extensions/theme-quietlight.i18n.json",
      "vscode.theme-red": "$extensions/theme-red.i18n.json",
      "vscode.theme-seti": "$extensions/theme-seti.i18n.json",
      "vscode.theme-solarized-dark": "$extensions/theme-solarized-dark.i18n.json",
      "vscode.theme-solarized-light": "$extensions/theme-solarized-light.i18n.json",
      "vscode.theme-tomorrow-night-blue": "$extensions/theme-tomorrow-night-blue.i18n.json",
      "vscode.typescript-basics": "$extensions/typescript-basics.i18n.json",
      "vscode.vb": "$extensions/vb.i18n.json",
      "vscode.xml": "$extensions/xml.i18n.json",
      "vscode.yaml": "$extensions/yaml.i18n.json",
      "vscode.typescript-language-features": "$extensions/typescript-language-features.i18n.json",
      "msjsdiag.debugger-for-chrome": "$extensions/vscode-chrome-debug.i18n.json",
      "ms-vscode.node-debug2": "$extensions/vscode-node-debug2.i18n.json",
      "ms-vscode.node-debug": "$extensions/vscode-node-debug.i18n.json"
    }
  }
}
"@ | set-content -path $env:APPDATA\Code\languagepacks.json
# install git
choco install git -y
code --install-extension eamodio.gitlens
}

function install-chrome {
choco install googlechrome -y
# set chrome as default browser
$base = "HKCU:\Software\Microsoft\Windows\Shell\"
$assoc = "Associations\UrlAssociations\{0}\UserChoice"
$ftp   = $assoc -f "ftp"
$http  = $assoc -f "http"
$https = $assoc -f "https"
new-item -path $base -name $ftp   -force
new-item -path $base -name $http  -force
new-item -path $base -name $https -force
$ftp   = $base + $ftp
$http  = $base + $http
$https = $base + $https
set-itemproperty -path $ftp   -name ProgId -value ChromeHTML
set-itemproperty -path $http  -name ProgId -value ChromeHTML
set-itemproperty -path $https -name ProgId -value ChromeHTML
}

function install-clojure {
# install leiningen
choco install curl -y
$env:HTTP_CLIENT = "curl -f -L -k -o"
choco install jdk8 lein -y
# install vscode extension
code --install-extension avli.clojure
@"
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
"@ | set-content -path $env:APPDATA\Code\User\keybindings.json
}

function install-powershell {
choco install powershell.portable -y
# install vscode extension
code --install-extension ms-vscode.PowerShell
@"
{
  "powershell.powerShellExePath": "C:\\ProgramData\\chocolatey\\bin\\pwsh.exe"
}
"@ | set-content -path $env:APPDATA\Code\User\settings.json
}

write-host '[!] disable-policies'; disable-policies | out-null
write-host '[!] configure-dns'; configure-dns | out-null
write-host '[!] configure-hosts'; configure-hosts | out-null
write-host '[!] install-bandizip'; install-bandizip | out-null
write-host '[!] install-choco'; install-choco | out-null
write-host '[!] install-chrome'; install-chrome | out-null
write-host '[!] install-vscode'; install-vscode | out-null
write-host '[!] install-clojure'; install-clojure | out-null
write-host '[!] complete' -foregroundcolor green; read-host
