FROM epam/jenkins-slave:2.46.1

# Note: Install .NET 3.5 and 2.0 required by TDS
ADD win2016/sources/sxs /sources/sxs
RUN Install-WindowsFeature -Name NET-Framework-Features -Source c:\sources\sxs -Restart:$false ;\
    Remove-Item /sources -Force -Recurse -ErrorAction SilentlyContinue

# Note: Install TDS
ENV TDS_VERSION 5.6.0.13
ENV VS_VERSION VS2015

RUN $version = "$env:TDS_VERSION" -replace '\.', ''; \
    Invoke-WebRequest "https://www.teamdevelopmentforsitecore.com/-/media/TDS/Files/TDS%20Downloads/TDS%20$version.ashx" -OutFile "$env:TEMP/tds.zip" -UseBasicParsing; \
    Expand-Archive "$env:TEMP/tds.zip" -Destination "$env:TEMP/tds"; \
    Start-Process -FilePath "$env:TEMP/tds/$env:TDS_VERSION/HedgehogDevelopmentTDS_$env:VS_VERSION.msi" -ArgumentList '/quiet', '/norestart', '/l*', "$env:TEMP/tds.log" -PassThru | Wait-Process -Timeout 30 -ErrorAction SilentlyContinue; \
    Get-Process | ? {$_.ProcessName -eq 'msiexec'} | Stop-Process -Force; \
    dir "$env:TEMP" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

ENV JENKINS_MASTER_HOST 'jenkins-master'
ENV JENKINS_AGENT_ID '00'

# Copy Scripts
ADD scripts /scripts


CMD [ "powershell", "c:/scripts/startup.ps1" ]
