FROM asmagin/jenkins-on-windowsservercore:2.46.1

MAINTAINER Alex Smagin

# $ProgressPreference will disable download progress info and speed-up download
SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

# Copy Jenkins Configurations that would be moved to Jenkins folder
COPY jenkins /jenkins

CMD [ "powershell", "c:/scripts/startup.ps1" ]