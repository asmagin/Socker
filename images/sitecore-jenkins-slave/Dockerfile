FROM openjdk:windowsservercore

# $ProgressPreference will disable download progress info and speed-up download
SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

# Note: Add .NET + ASP.NET
RUN Install-WindowsFeature NET-Framework-45-ASPNET ; \
    Install-WindowsFeature Web-Asp-Net45; 

# Note: Get MSBuild 12.
RUN Invoke-WebRequest "https://download.microsoft.com/download/9/B/B/9BB1309E-1A8F-4A47-A6C5-ECF76672A3B3/BuildTools_Full.exe" -OutFile "$env:TEMP\BuildTools_Full.exe" -UseBasicParsing; \
    & "$env:TEMP\BuildTools_Full.exe" /Silent /Full; 
    # Todo: delete the BuildTools_Full.exe file in this layer

WORKDIR c:/Program Files (x86)/MSBuild/Microsoft/VisualStudio/v12.0

# Note: Add NuGet
RUN Invoke-WebRequest "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" -OutFile "c:/windows/nuget.exe" -UseBasicParsing; \
# Note: Install Web Targets
    & "c:/windows/nuget.exe" Install MSBuild.Microsoft.VisualStudio.Web.targets -Version 12.0.4 ; \
    mv 'c:/Program Files (x86)/MSBuild/Microsoft/VisualStudio/v12.0/MSBuild.Microsoft.VisualStudio.Web.targets.12.0.4/tools/VSToolsPath/*' 'c:/Program Files (x86)/MSBuild/Microsoft/VisualStudio/v12.0/'; \
# Note: Add Msbuild ot path
    setx PATH '%PATH%;c:/Program Files (x86)/MSBuild/12.0/Bin/msbuild.exe'; 

WORKDIR c:/

ENV GIT_VERSION=2.12.2
# Note: Install Git
RUN New-Item -Path 'c:/git' -Type Directory -ErrorAction SilentlyContinue; \
    Invoke-WebRequest "https://github.com/git-for-windows/git/releases/download/v$env:GIT_VERSION.windows.1/Git-$env:GIT_VERSION-64-bit.exe" -OutFile "$env:TEMP/git.exe" -UseBasicParsing; \
    & "$env:TEMP/git.exe" '/VERYSILENT' '/NORESTART' '/NOCANCEL' '/SP-' '/DIR="c:/git"';

ENV NODEJS_VERSION=6.10.1
# Note: Install NodeJS
RUN Invoke-WebRequest "https://nodejs.org/dist/v$env:NODEJS_VERSION/node-v$env:NODEJS_VERSION-x64.msi" -OutFile "$env:TEMP/nodejs.msi" -UseBasicParsing; \
    & "$env:TEMP/nodejs.msi" '/quiet' '/norestart';

# Note: Install NodeJS

# ARG BASE_URL  
# ARG SECRET

# RUN (New-Object System.Net.WebClient).DownloadFile('http://{0}:8080/jnlpJars/slave.jar' -f $env:BASE_URL, 'slave.jar') ;  
# ENTRYPOINT ["java", "-jar", ".\\slave.jar"]  
