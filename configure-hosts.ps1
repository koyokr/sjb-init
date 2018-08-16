# require curl

# refresh env
$env:Path = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)

# configure hosts
curl -L https://sjb.koyo.io/hosts | Add-Content -Path C:\Windows\System32\drivers\etc\hosts
