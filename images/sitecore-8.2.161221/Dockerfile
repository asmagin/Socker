FROM microsoft/iis

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop';"] 

ADD Sitecore/ /Sitecore
ADD Overrides/ /Sitecore

RUN Add-WindowsFeature NET-Framework-45-ASPNET; \
    Add-WindowsFeature Web-Asp-Net45; \
    Set-Itemproperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord; \
    Import-Module IISAdministration; \
    Import-Module WebAdministration; \
    New-IISSite -Name 'Sitecore' -PhysicalPath 'C:\Sitecore\Website' -BindingInformation '*:80:'; \
    Set-ItemProperty 'IIS:\apppools\DefaultAppPool' -Name 'enable32BitAppOnWin64' -Value 'True'; \
    Remove-IISSite -Name 'Default Web Site' -Confirm:$false; \
    Remove-Item 'C:\Sitecore\Data\logs' -Force -Recurse