# require choco

# install googlechrome
choco install googlechrome -y

# set chrome as default browser
$base = 'HKCU:\Software\Microsoft\Windows\Shell\'
$assoc = 'Associations\UrlAssociations\{0}\UserChoice'

$ftp   = $assoc -f 'ftp'
$http  = $assoc -f 'http'
$https = $assoc -f 'https'
New-Item -Path $base -Name $ftp   -Force
New-Item -Path $base -Name $http  -Force
New-Item -Path $base -Name $https -Force

$ftp   = $base + $ftp
$http  = $base + $http
$https = $base + $https
Set-ItemProperty -Path $ftp   -Name ProgId -Value ChromeHTML
Set-ItemProperty -Path $http  -Name ProgId -Value ChromeHTML
Set-ItemProperty -Path $https -Name ProgId -Value ChromeHTML

# install 7zip
choco install 7zip.install -y
