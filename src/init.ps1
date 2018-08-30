# require .NET 4 runtime

Set-ExecutionPolicy Bypass -Scope Process -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function download-string($url) {
  (New-Object System.Net.WebClient).DownloadString($url)
}

function refresh-env($name) {
  Set-Item -Path env:$name -Value ([Environment]::GetEnvironmentVariable($name, [EnvironmentVariableTarget]::Machine))
}

{{code}}
