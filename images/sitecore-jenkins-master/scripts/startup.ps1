$ProgressPreference = 'SilentlyContinue'

# Note: move default files to attached volume after the start of container
if(Test-Path 'c:/temp'){
    Copy-Item 'c:/temp/*' -Destination 'c:/jenkins/' -Recurse -Force
    Remove-Item 'c:/temp' -Recurse -Force
}

# Note: download plugins
if(Test-Path 'c:/scripts/plugins.txt') {
    Get-Content 'c:/scripts/plugins.txt' |
        ForEach-Object {
            $plugin = $_
            $url = "$env:JENKINS_UC/download/plugins/$plugin/latest/${plugin}.hpi"
            Write-Host "Downloading plugin:`t[$plugin]`tfrom`t$url"
            Invoke-WebRequest  $url -OutFile "c:/jenkins/plugins/${plugin}.jpi" -UseBasicParsing -ErrorAction SilentlyContinue
        }

    Remove-Item 'c:/scripts/plugins.txt'
}

& 'java.exe' '-jar' 'c:/jenkins.war'
