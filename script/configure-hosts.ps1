# require init

# replace hosts
Download-String 'https://sjb.koyo.io/hosts' | Set-Content -Path C:\Windows\System32\drivers\etc\hosts
