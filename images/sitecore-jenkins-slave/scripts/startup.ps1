$ProgressPreference = 'SilentlyContinue'

# SHOW CONTAINER INFO
$ip = Get-NetAdapter | 
    Select-Object -First 1 | 
    Get-NetIPAddress | 
    Where-Object { $_.AddressFamily -eq "IPv4"} |
    Select-Object -Property IPAddress | 
    ForEach-Object { $_.IPAddress }

$ID = 0

if($env:JENKINS_AGENT_ID -match '\d+') {
    $ID =  [convert]::ToInt32("$env:JENKINS_AGENT_ID") % 10
}

switch ($ID) 
    { 
        1 { $env:SECRET = "fcb77dae06ef07ce43e89fcace1a12b889c2a74ccafd63010df128989d6279df"}
        2 { $env:SECRET = "14630b9879639ada53e144cb7c2e5e0ca4a9887f1327a370e920fac56cbf2c7f"}
        3 { $env:SECRET = "f0a439f38b34d51e0854a0105d5e3184aa434d03b49990c8b8a1e47e6ab7068c"}
        4 { $env:SECRET = "bd42c68e433e179a1a805ce3521e8a1579d2ccdebe0094a8fe7a11ad227db0e8"}
        5 { $env:SECRET = "bf282fef1d767569f7dff912bc5d7c74db6db8052304449f53f786b8df689dee"}
        6 { $env:SECRET = "4ec2ab71c5eab5d7cc0b79211a737b2db7818cd577feb86fa4c7c3cbdd26cf5a"}
        7 { $env:SECRET = "c663ef78c4941c8ea1c5855630e2c07c680d96df014ce6be1ec6d1648233b8d0"}
        8 { $env:SECRET = "a39dfcb40204beca41942dc89ec5514b195b0a8b1e0ede7caa71bcbe78c863ab"}
        9 { $env:SECRET = "eca4e03a04db4faf9fb1ae74fd04ac3ab0890be5912070782509a0056ac4fbe6"}
        default { $env:SECRET = "50821f3fb4129adea445c101ab5e4e12c3338b2c391b5687dab77161a657029b"}
    }


Write-Host "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = " -ForegroundColor Yellow
Write-Host "JENKINS SLAVE CONTAINER" -ForegroundColor Yellow
Write-Host ("Started at:     {0}" -f [DateTime]::Now.ToString("yyyy-MMM-dd HH:mm:ss.fff")) -ForegroundColor Yellow
Write-Host ("Container Name: {0}" -f $env:COMPUTERNAME) -ForegroundColor Yellow
Write-Host ("Container IP:   {0}" -f $ip) -ForegroundColor Yellow
Write-Host ("Slave ID:       {0:00}" -f $ID) -ForegroundColor Yellow
Write-Host "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = " -ForegroundColor Yellow

& 'java.exe' '-jar' 'c:/jenkins/slave.jar' '-jnlpUrl' ("http://{0}:8080/computer/{1:00}/slave-agent.jnlp" -f $env:JENKINS_MASTER_HOST, $ID) '-secret' $env:SECRET