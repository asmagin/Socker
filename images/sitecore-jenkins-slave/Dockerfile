FROM asmagin/jenkins-on-windowsservercore:2.46.1-slave

MAINTAINER Alex Smagin

# $ProgressPreference will disable download progress info and speed-up download
SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

# Note: Install .NET 3.5 and 2.0 required by TDS
COPY win2016/sources/sxs /sources/sxs
RUN \
    Install-WindowsFeature -Name NET-Framework-Features -Source c:\sources\sxs -Restart:$false ;\
    Remove-Item /sources -Force -Recurse -ErrorAction SilentlyContinue

# Note: Install TDS
RUN \
    # TODO: refactor with docker ENV after 1.4 release.
    if (-not($env:TDS_VERSION)) { $env:TDS_VERSION = '5.6.0.13' }; \
    if (-not($env:TDS_VERSION)) { [Environment]::SetEnvironmentVariable('TDS_VERSION', $env:TDS_VERSION, 'Machine') }; \
    if (-not($env:VS_VERSION)) { $env:VS_VERSION = 'VS2015' }; \
    if (-not($env:VS_VERSION)) { [Environment]::SetEnvironmentVariable('VS_VERSION', $env:VS_VERSION, 'Machine') }; \
    $version = "$env:TDS_VERSION" -replace '\.', ''; \
    $url = 'https://www.teamdevelopmentforsitecore.com/-/media/TDS/Files/TDS%20Downloads/TDS%20{0}.ashx' -f $version; \
    cd $env:TEMP; \
    Invoke-WebRequest $url -OutFile './tds.zip' -UseBasicParsing -Verbose; \
    Expand-Archive './tds.zip' -Destination './tds' -Verbose; \
    # Unpack nuget package & move target tiles into MSBuild folder
    cd "./tds/$env:TDS_VERSION/NuGetPackages/" ; \
    Rename-Item "./HedgehogDevelopment.TDS.$env:TDS_VERSION.nupkg" -NewName './nupkg.zip' -Verbose; \
    Expand-Archive './nupkg.zip' -Destination './nupkg' -Verbose; \
    New-Item -ItemType Directory -Force -Path 'c:/Program Files (x86)/MSBuild/HedgehogDevelopment/SitecoreProject/v9.0'; \
    mv './nupkg/build/*' 'c:/Program Files (x86)/MSBuild/HedgehogDevelopment/SitecoreProject/v9.0'; \
    cd 'c:/Program Files (x86)/MSBuild/HedgehogDevelopment/SitecoreProject/v9.0'; \
    # targets file references in TDS project named differently
    Copy-Item './HedgehogDevelopment.TDS.targets' -Destination './HedgehogDevelopment.SitecoreProject.targets'; \
    cd / ; \
    dir "$env:TEMP" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue;

CMD [ "powershell", "c:/scripts/startup.ps1" ]
