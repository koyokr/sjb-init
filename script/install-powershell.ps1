# require choco, vscode

choco install powershell.portable -y

# install vscode extension
code --install-extension ms-vscode.PowerShell
@'
{
    "powershell.powerShellExePath": "C:\\ProgramData\\chocolatey\\bin\\pwsh.exe"
}
'@ | Set-Content -Path $env:APPDATA\Code\User\settings.json
