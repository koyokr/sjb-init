@echo off

:: set env
SET POSH=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -InputFormat None -ExecutionPolicy Bypass

:: install choco
IF NOT %ChocolateyInstall%=="" GOTO INSTALLED
%POSH% -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
SET Path=%Path%;%ALLUSERSPROFILE%\chocolatey\bin

:INSTALLED
:: install curl
choco install curl -y

:: init
%POSH% -Command "curl -L https://sjb.koyo.io/init.ps1 | Out-String | iex"
