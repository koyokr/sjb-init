# require init

# replace hosts
download-string 'https://sjb.koyo.io/hosts' | Set-Content -Path C:\Windows\System32\drivers\etc\hosts
