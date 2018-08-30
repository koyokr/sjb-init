# https://blog.hakase.io/ckis-unlocker

# disable policies registry, taskmgr
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name DisableRegistryTools -Value 0
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name DisableTaskMgr -Value 0

# disable policies explorer, keyboard
Remove-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -Recurse
Remove-Item -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -Recurse
Remove-Item -Path HKLM:\SYSTEM\CurrentControlSet\Control\'Keyboard Layout' -Recurse

# restart explorer
Stop-Process -Name explorer
