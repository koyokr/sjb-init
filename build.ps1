function format-code($path, $mapping) {
  $result = get-content $path
  $mapping.keys | % { $result = $result -replace "{{$_}}", $mapping.item($_) }
  return $result
}

function convert-fn($fn) {
  "write-host '[!] $fn'; $fn | out-null"
}

$template = "template"
$output = "out"
$langs = @{
  "common"= @(
    "disable-policies"
    "configure-dns"
    "configure-hosts"
    "install-chrome"
    "install-bandizip"
    "install-choco"
    "install-vscode"
  )
  "clj"= @(
    "install-clojure"
  )
  "ps" = @(
    "install-powershell"
  )
}

# static
copy-item static $output -recurse

# directory
$langs.keys | % { new-item "$output/$_" -itemtype directory }

# index.html
$langs.keys | % { format-code "$template/index.html" @{"url"="init.bat"} | set-content "$output/$_/index.html" }
format-code "$template/index.html" @{"url"="/common/"} | set-content "$output/index.html"

# init.bat
$langs.keys | % { format-code "$template/init.bat" @{"lang"=$_} | set-content "out/$_/init.bat" }

# init.ps1
$langs.keys | % {
  $fns = $langs.item($_)
  if ($_ -ne "common") { $fns = $langs.item("common") + $fns }
  $fns = $fns | % { convert-fn $_ }
  format-code "$template/init.ps1" @{'code'=[string]::Join("`n", $fns)} | set-content -encoding utf8bom "$output/$_/init.ps1"
}
