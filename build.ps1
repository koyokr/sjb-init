
function Get-Code($name) {
  "Write-Host '[!] $name'; download-string 'https://sjb.koyo.io/src/$name.ps1' | iex | Out-Null"
}

# directory
New-Item out/clj -ItemType directory
New-Item out/cs -ItemType directory

# static
Copy-Item static/* out/ -Recurse

# index.html
Copy-Item init/index.html out
Copy-Item init/index.html out/clj
Copy-Item init/index.html out/cs

# init.bat
(Get-Content init/init.bat) -replace '/init.ps1', '/init.ps1' | Set-Content out/init.bat
(Get-Content init/init.bat) -replace '/init.ps1', '/clj/init.ps1' | Set-Content out/clj/init.bat
(Get-Content init/init.bat) -replace '/init.ps1', '/cs/init.ps1' | Set-Content out/cs/init.bat

# init.ps1
$root = @(
  'disable-policies'
  'configure-hosts'
  'install-choco'
  'install-firefox'
)
$clj = @(
  'disable-policies'
  'configure-hosts'
  'install-choco'
  'install-firefox'
  'install-vscode'
  'install-clojure'
  'install-putty'
)
$cs = @(
  'disable-policies'
  'configure-hosts'
  'install-choco'
  'install-firefox'
  'install-vscode'
  'install-dotnet'
  'install-putty'
)
$complete = "Write-Host '[!] Complete' -ForegroundColor green; Read-Host"
Copy-Item init/init.ps1 out
Copy-Item init/init.ps1 out/clj
Copy-Item init/init.ps1 out/cs
$root | % {Get-Code $_} | Add-Content out/init.ps1
$clj | % {Get-Code $_} | Add-Content out/clj/init.ps1
$cs | % {Get-Code $_} | Add-Content out/cs/init.ps1
$complete | Add-Content out/init.ps1
$complete | Add-Content out/clj/init.ps1
$complete | Add-Content out/cs/init.ps1
