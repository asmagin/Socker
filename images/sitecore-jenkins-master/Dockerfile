FROM epam/jenkins:2.32.2

# $ProgressPreference will disable download progress info and speed-up download
SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

# Install Git
RUN New-Item -Path 'c:/git' -Type Directory -ErrorAction SilentlyContinue; \
    Invoke-WebRequest "https://github.com/git-for-windows/git/releases/download/v2.12.2.windows.1/Git-2.12.2-64-bit.exe" -OutFile "C:/git/install.exe" -UseBasicParsing; \
    & 'C:/git/install.exe' '/VERYSILENT' '/NORESTART' '/NOCANCEL' '/SP-' '/DIR="c:/git"';

# Copy Scripts
ADD scripts /scripts

# Copy Jemkins Configurations that would be moved to Jenkins folder
ADD jenkins /temp

CMD [ "powershell", "c:/scripts/startup.ps1" ]