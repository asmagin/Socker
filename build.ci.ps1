$ErrorActionPreference = "STOP"

$SC_VERSION = "8.2 rev. 161221"
$SC_VERSION_SHORT = ($SC_VERSION -replace " ", "") -replace "rev", "";

$JENKINS_VERSION = "2.46.1"

# Note: run clean-up
docker rm $(docker ps -a -q)
docker rmi $(docker images -f dangling=true -q)

docker build -t asmagin/jenkins-on-windowsservercore:$JENKINS_VERSION              .\images\jenkins-$JENKINS_VERSION
docker build -t asmagin/jenkins-on-windowsservercore:$JENKINS_VERSION-slave        .\images\jenkins-$JENKINS_VERSION-slave

docker build -t epam/sitecore-jenkins-master               .\images\sitecore-jenkins-master
docker build -t epam/sitecore-jenkins-slave                .\images\sitecore-jenkins-slave