# require choco, curl

# refresh env
$env:Path = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)

# install leiningen
$env:HTTP_CLIENT = 'curl -f -L -k -o'
choco install jdk8 lein -y

# download clojurescript
curl -L https://github.com/clojure/clojurescript/releases/download/r1.10.339/cljs.jar `
  -o $env:USERPROFILE\Documents\cljs.jar

# install nodejs
choco install nodejs.install -y
