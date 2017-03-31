FROM epam/jenkins:2.46.1

# $ProgressPreference will disable download progress info and speed-up download
SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

# Install Git
ENV GIT_VERSION=2.12.2
RUN New-Item -Path 'c:/git' -Type Directory -ErrorAction SilentlyContinue; \
    Invoke-WebRequest "https://github.com/git-for-windows/git/releases/download/v$env:GIT_VERSION.windows.1/Git-$env:GIT_VERSION-64-bit.exe" -OutFile "$env:TEMP/git.exe" -UseBasicParsing; \
    & "$env:TEMP/git.exe" '/VERYSILENT' '/NORESTART' '/NOCANCEL' '/SP-' '/DIR="c:/git"';

# Copy Jemkins Configurations that would be moved to Jenkins folder
ADD jenkins /temp

# Copy Scripts
ADD scripts /scripts

CMD [ "powershell", "c:/scripts/startup.ps1" ]