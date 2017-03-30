FROM openjdk:windowsservercore

# $ProgressPreference will disable download progress info and speed-up download
SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

# Note: Add .NET + ASP.NET
RUN Install-WindowsFeature NET-Framework-45-ASPNET ; \
    Install-WindowsFeature Web-Asp-Net45; 

# # Note: Get MSBuild 12.
# RUN Invoke-WebRequest "https://download.microsoft.com/download/9/B/B/9BB1309E-1A8F-4A47-A6C5-ECF76672A3B3/BuildTools_Full.exe" -OutFile "$env:TEMP\BuildTools_Full.exe" -UseBasicParsing; \
#     & Start-Process -FilePath "$env:TEMP\BuildTools_Full.exe" -ArgumentList '/Passive', '/NoRestart' -PassThru | Wait-Process; \
#     & Get-ChildItem "$env:TEMP" -Recurse | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
#     # Todo: delete the BuildTools_Full.exe file in this layer

# Note: Get MSBuild 14.
RUN Invoke-WebRequest "https://download.microsoft.com/download/E/E/D/EEDF18A8-4AED-4CE0-BEBE-70A83094FC5A/BuildTools_Full.exe" -OutFile "$env:TEMP\BuildTools_Full.exe" -UseBasicParsing; \
    Start-Process -FilePath "$env:TEMP\BuildTools_Full.exe" -ArgumentList '/Passive', '/NoRestart' -PassThru | Wait-Process; \
    dir "$env:TEMP" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    # Todo: delete the BuildTools_Full.exe file in this layer

WORKDIR c:/nuget

# Note: Add NuGet
RUN Invoke-WebRequest "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" -OutFile "c:/nuget/nuget.exe" -UseBasicParsing; 

# WORKDIR c:/Program Files (x86)/MSBuild/Microsoft/VisualStudio/v12.0
# # Note: Install Web Targets v12
# RUN & "c:/nuget/nuget.exe" Install MSBuild.Microsoft.VisualStudio.Web.targets -Version 12.0.4 ; \
#     mv 'c:/Program Files (x86)/MSBuild/Microsoft/VisualStudio/v12.0/MSBuild.Microsoft.VisualStudio.Web.targets.12.0.4/tools/VSToolsPath/*' 'c:/Program Files (x86)/MSBuild/Microsoft/VisualStudio/v12.0/'; \
#     setx PATH '%PATH%;c:/Program Files (x86)/MSBuild/12.0/Bin/msbuild.exe'; 

WORKDIR c:/Program Files (x86)/MSBuild/Microsoft/VisualStudio/v14.0
# Note: Install Web Targets v14
RUN & "c:/nuget/nuget.exe" Install MSBuild.Microsoft.VisualStudio.Web.targets -Version 14.0.0.3 ; \
    mv 'c:/Program Files (x86)/MSBuild/Microsoft/VisualStudio/v14.0/MSBuild.Microsoft.VisualStudio.Web.targets.14.0.0.3/tools/VSToolsPath/*' 'c:/Program Files (x86)/MSBuild/Microsoft/VisualStudio/v14.0/'; \
    setx PATH '%PATH%;c:/Program Files (x86)/MSBuild/14.0/Bin/msbuild.exe'; 

# Note: Install Git
ENV GIT_VERSION=2.12.2
WORKDIR c:/git
RUN Invoke-WebRequest "https://github.com/git-for-windows/git/releases/download/v$env:GIT_VERSION.windows.1/Git-$env:GIT_VERSION-64-bit.exe" -OutFile "$env:TEMP/git.exe" -UseBasicParsing; \
    Start-Process -FilePath "$env:TEMP/git.exe" -ArgumentList '/VERYSILENT', '/NORESTART', '/NOCANCEL', '/SP-', '/DIR="c:/git"' -PassThru | Wait-Process; \
    dir "$env:TEMP" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

# Note: Install NodeJS
ENV NODEJS_VERSION=6.10.1
RUN Invoke-WebRequest "https://nodejs.org/dist/v$env:NODEJS_VERSION/node-v$env:NODEJS_VERSION-x64.msi" -OutFile "$env:TEMP/nodejs.msi" -UseBasicParsing; \
    Start-Process -FilePath "$env:TEMP/nodejs.msi" -ArgumentList '/quiet', '/norestart' -PassThru | Wait-Process; \
    dir "$env:TEMP" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

# Note: Install Jenkins slave
WORKDIR c:/jenkins
# jenkins version being bundled in this docker image
ENV JENKINS_VERSION 2.32.3

RUN Invoke-WebRequest "https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/$env:JENKINS_VERSION/jenkins-war-$env:JENKINS_VERSION.war" -OutFile "$env:TEMP/jenkins.zip" -UseBasicParsing; \
    Expand-Archive "$env:TEMP/jenkins.zip" -Destination "$env:TEMP/jenkins"; \
    Copy-Item "$env:TEMP/jenkins/WEB-INF/slave.jar" -Destination "c:/jenkins/slave.jar"; \
    dir "$env:TEMP" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

WORKDIR c:/

ENV JENKINS_MASTER_HOST 'jenkins-master'
ENV JENKINS_AGENT_ID '00'

# Copy Scripts
ADD scripts /scripts

CMD [ "powershell", "c:/scripts/startup.ps1" ]
