# require choco

# install googlechrome
choco install googlechrome -y

# set chrome as default browser
$regKey = 'HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\{0}\UserChoice'
$regKeyFtp   = $regKey -f 'ftp'
$regKeyHttp  = $regKey -f 'http'
$regKeyHttps = $regKey -f 'https'
Set-ItemProperty $regKeyFtp   -Name ProgId ChromeHTML
Set-ItemProperty $regKeyHttp  -Name ProgId ChromeHTML
Set-ItemProperty $regKeyHttps -Name ProgId ChromeHTML

# install 7zip
choco install 7zip.install -y
