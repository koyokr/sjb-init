# require .NET 4 runtime

Set-ExecutionPolicy Bypass -Scope Process -Force

function Download-String($url) {
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  (New-Object System.Net.WebClient).DownloadString($url)
}

function Refresh-Environment($name) {
  Set-Item -Path env:$name -Value ([Environment]::GetEnvironmentVariable($name, [EnvironmentVariableTarget]::Machine))
}

{{code}}
