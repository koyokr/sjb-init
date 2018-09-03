function Get-DownloadCode($path) {
  "Write-Host '[!] $path'; Download-String 'https://sjb.koyo.io/$path' | iex | Out-Null"
}

function Format-Code($path, $mapping) {
  $result = Get-Content $path
  $mapping.Keys | % { $result = $result -replace "{{$_}}", $mapping.Item($_) }
  return $result
}

$template = 'template'
$output = 'out'
$langs = @{
  'common'= @(
    'disable-policies'
    'configure-dns'
    'configure-hosts'
    'install-choco'
    'install-firefox'
    'install-vscode'
    'install-putty'
  )
  'clj'= @(
    'install-clojure'
  )
  'cs'= @(
    'install-dotnet'
  )
  'ps' = @(
    'install-powershell'
  )
}

# static
Copy-Item static $output -Recurse

# directory
$langs.Keys | % { New-Item "$output/$_" -ItemType directory }

# index.html
$langs.Keys | % { Format-Code "$template/index.html" @{'url'='init.bat'} | Set-Content "$output/$_/index.html" }
Format-Code "$template/index.html" @{'url'='/common/index.html'} | Set-Content "$output/index.html"

# init.bat
$langs.Keys | % { Format-Code "$template/init.bat" @{'lang'=$_} | Set-Content "out/$_/init.bat" }

# init.ps1
$langs.Keys | % {
  $codes = @()
  if ($_ -ne "common") { $codes += Get-DownloadCode "common/init.ps1" }
  $langs.Item($_) | % { $codes += Get-DownloadCode "script/$_.ps1" }
  Format-Code "$template/init.ps1" @{'code'=[string]::Join("`n", $codes)} | Set-Content "$output/$_/init.ps1"
}
