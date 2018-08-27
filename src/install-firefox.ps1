# require init, choco

# install firefox
choco install firefox -y

# https://stackoverflow.com/questions/9739772/how-to-pin-to-taskbar-using-powershell
$ff = (New-Object -ComObject Shell.Application).NameSpace("$env:ProgramFiles\Mozilla Firefox").ParseName('firefox.exe')
$ff.InvokeVerb('taskbarpin')
