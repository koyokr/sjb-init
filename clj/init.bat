@echo off

:: set env
set PSHOME=%SystemRoot%\System32\WindowsPowerShell\v1.0
set PWSH=%PSHOME%\powershell.exe -NoProfile -InputFormat None -ExecutionPolicy Bypass

:: run powershell with the .NET 4 runtime
:: https://stackoverflow.com/questions/2094694/how-can-i-run-powershell-with-the-net-4-runtime
(
  echo.^<?xml version="1.0"?^>
  echo.^<configuration^>
  echo.  ^<startup useLegacyV2RuntimeActivationPolicy="true"^>
  echo.    ^<supportedRuntime version="v4.0.30319"/^>
  echo.    ^<supportedRuntime version="v2.0.50727"/^>
  echo.  ^</startup^>
  echo.^</configuration^>
) > %PSHOME%\powershell.exe.config

:: init
%PWSH% -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex ((New-Object Net.WebClient).DownloadString('https://sjb.koyo.io/clj/init.ps1'))"
