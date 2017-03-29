$ErrorActionPreference = "STOP"

$version = "8.2 rev. 161221"
$shortVer = ($version -replace " ", "") -replace "rev", "";

# unzip sitecore and put files in required folders
Remove-item ".\dependencies\Sitecore $version" -Force -Recurse -ErrorAction SilentlyContinue
Remove-item ".\images\sitecore-$shortVer\Sitecore" -Force -Recurse -ErrorAction SilentlyContinue
Remove-item ".\images\sitecore-$shortVer-db\Sitecore" -Force -Recurse -ErrorAction SilentlyContinue

& ".\tools\7z.exe" "x" ".\dependencies\Sitecore $version.zip" "-aoa" "-o.\dependencies"

## Move folders close to images
# Move website into sitecore base image
New-Item -path ".\images\sitecore-$shortVer\Sitecore" -ItemType Directory -Force
New-Item -path ".\images\sitecore-$shortVer\Overrides" -ItemType Directory -Force
Move-Item ".\dependencies\Sitecore $version\Website" ".\images\sitecore-$shortVer\Sitecore" -Force
Move-Item ".\dependencies\Sitecore $version\Data"    ".\images\sitecore-$shortVer\Sitecore" -Force

# Move database files
New-Item -path ".\images\sitecore-$shortVer-db\Sitecore" -ItemType Directory -Force
Move-Item ".\dependencies\Sitecore $version\Databases" ".\images\sitecore-$shortVer-db\Sitecore" -Force

docker build -t epam/sitecore:8.2.161221 .\images\sitecore-$shortVer
docker build -t epam/sitecore-db:8.2.161221 .\images\sitecore-$shortVer-db
docker build -t epam/jenkins:2.32.2 .\images\jenkins-2.32.2
docker build -t epam/sitecore-jenkins-master .\images\sitecore-jenkins-master
# docker build -t sitecore-iis .\images\sitecore-iis
# docker build -t sitecore:8.2.161221 .\images\sitecore-82rev161221
# docker build -t traefik:win .\images\traefik-win