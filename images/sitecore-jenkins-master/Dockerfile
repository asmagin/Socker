FROM asmagin/jenkins-on-windowsservercore:2.46.1

MAINTAINER Alex Smagin

# $ProgressPreference will disable download progress info and speed-up download
SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

# Install Git
# Note: Install Git
RUN \
    if (-not($env:GIT_VERSION)) { $env:GIT_VERSION = '2.12.2'; \
        [Environment]::SetEnvironmentVariable('GIT_VERSION', $env:GIT_VERSION, 'Machine') }; \
    New-Item -ItemType Directory -Force -Path 'c:/git'; \
    Invoke-WebRequest "https://github.com/git-for-windows/git/releases/download/v$env:GIT_VERSION.windows.1/Git-$env:GIT_VERSION-64-bit.exe" -OutFile "$env:TEMP/git.exe" -UseBasicParsing; \
    Start-Process -FilePath "$env:TEMP/git.exe" -ArgumentList '/VERYSILENT', '/NORESTART', '/NOCANCEL', '/SP-', '/DIR="c:/git"' -PassThru | Wait-Process; \
    dir "$env:TEMP" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

# Copy Jenkins Configurations that would be moved to Jenkins folder
COPY jenkins /jenkins

# Copy Scripts
COPY scripts /scripts

CMD [ "powershell", "c:/scripts/startup.ps1" ]