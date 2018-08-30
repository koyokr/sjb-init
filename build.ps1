function Get-Code($path) {
  "Write-Host '[!] $path'; download-string 'https://sjb.koyo.io/$path' | iex | Out-Null"
}

function Map-Code($path, $mapping) {
  $result = (Get-Content $path)
  $mapping.Keys | % {
    $key = $_
    $val = $mapping.Item($key)
    $result = $result -replace "{{$key}}", $val
  }
  return $result
}

$template = 'template'
$output = 'out'
$langs = @{
  'common'= @(
    'disable-policies'
    'configure-hosts'
    'install-choco'
    'install-firefox'
  )
  'clj'= @(
    'install-vscode'
    'install-clojure'
    'install-putty'
  )
  'cs'= @(
    'install-vscode'
    'install-dotnet'
    'install-putty'
  )
}

# static
Copy-Item static $output -Recurse

# directory
$langs.Keys | % { New-Item "$output/$_" -ItemType directory }

# index.html
$mapping = @{'url'='init.bat'}
$langs.Keys | % {
  $target = "$output/$_/index.html"
  Map-Code "$template/index.html" $mapping | Set-Content $target
}
$target = "$output/index.html"
$mapping = @{'url'='/common/index.html'}
Map-Code "$template/index.html" $mapping | Set-Content $target

# init.bat
$langs.Keys | % {
  $target = "out/$_/init.bat"
  $mapping = @{'lang'=$_}
  Map-Code "$template/init.bat" $mapping | Set-Content $target
}

# init.ps1
$langs.Keys | % {
  $codes = @()
  if ($_ -ne "common") { $codes += Get-Code "common/init.ps1" }
  $langs.Item($_) | % { $codes += Get-Code "ps/$_.ps1" }

  $target = "$output/$_/init.ps1"
  $mapping = @{'code'=[string]::Join("`n", $codes)}
  Map-Code "$template/init.ps1" $mapping | Set-Content $target
}
