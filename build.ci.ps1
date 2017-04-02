Clear-Host

$ErrorActionPreference = "STOP"


# Note: run clean-up
docker rm $(docker ps -a -q)
docker rmi $(docker images -f dangling=true -q)

docker build -t epam/sitecore-jenkins-master .\images\sitecore-jenkins-master
docker build -t epam/sitecore-jenkins-slave  .\images\sitecore-jenkins-slave