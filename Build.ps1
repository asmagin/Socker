$ErrorActionPreference = "STOP"

$SC_VERSION = "8.2 rev. 161221"
$SC_VERSION_SHORT = ($SC_VERSION -replace " ", "") -replace "rev", "";

$JENKINS_VERSION = "2.46.1"

# # unzip sitecore and put files in required folders
# Remove-item ".\dependencies\Sitecore $SC_VERSION" -Force -Recurse -ErrorAction SilentlyContinue
# Remove-item ".\images\sitecore-$SC_VERSION_SHORT\Sitecore" -Force -Recurse -ErrorAction SilentlyContinue
# Remove-item ".\images\sitecore-$SC_VERSION_SHORT-db\Sitecore" -Force -Recurse -ErrorAction SilentlyContinue

# & ".\tools\7z.exe" "x" ".\dependencies\Sitecore $SC_VERSION.zip" "-aoa" "-o.\dependencies"

# ## Move folders close to images
# # Move website into sitecore base image
# New-Item -path ".\images\sitecore-$SC_VERSION_SHORT\Sitecore" -ItemType Directory -Force
# New-Item -path ".\images\sitecore-$SC_VERSION_SHORT\Overrides" -ItemType Directory -Force
# Move-Item ".\dependencies\Sitecore $SC_VERSION\Website" ".\images\sitecore-$SC_VERSION_SHORT\Sitecore" -Force
# Move-Item ".\dependencies\Sitecore $SC_VERSION\Data"    ".\images\sitecore-$SC_VERSION_SHORT\Sitecore" -Force

# # Move database files
# New-Item -path ".\images\sitecore-$SC_VERSION_SHORT-db\Sitecore" -ItemType Directory -Force
# Move-Item ".\dependencies\Sitecore $SC_VERSION\Databases" ".\images\sitecore-$SC_VERSION_SHORT-db\Sitecore" -Force

docker rm $(docker ps -a -q)
docker rmi $(docker images -f dangling=true -q)
 
# docker build -t epam/sitecore:$SC_VERSION_SHORT            .\images\sitecore-$SC_VERSION_SHORT
# docker build -t epam/sitecore-db:$SC_VERSION_SHORT         .\images\sitecore-$SC_VERSION_SHORT-db
docker build -t epam/jenkins:$JENKINS_VERSION              .\images\jenkins-$JENKINS_VERSION
docker build -t epam/jenkins-slave:$JENKINS_VERSION        .\images\jenkins-$JENKINS_VERSION-slave

docker build -t epam/sitecore-jenkins-master               .\images\sitecore-jenkins-master
docker build -t epam/sitecore-jenkins-slave                .\images\sitecore-jenkins-slave
# docker build -t sitecore-iis .\images\sitecore-iis
# docker build -t sitecore:8.2.161221 .\images\sitecore-82rev161221
# docker build -t traefik:win .\images\traefik-win