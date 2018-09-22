# require .NET 4 runtime

Set-ExecutionPolicy Bypass -Scope Process -force

function download-string($url) {
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
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
remove-item -path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -recurse -force
remove-item -path HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -recurse -force
remove-item -path HKLM:\SYSTEM\CurrentControlSet\Control\"Keyboard Layout"          -recurse -force
# restart explorer
stop-process -name explorer
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

{{code}}
write-host '[!] complete' -foregroundcolor green; read-host
