$ProgressPreference = 'SilentlyContinue'

if(Test-Path 'c:/temp'){
    Copy-Item 'c:/temp/*' -Destination 'c:/jenkins/' -Recurse -Force
    Remove-Item 'c:/temp' -Recurse -Force
}

& 'java.exe' '-jar' 'c:/jenkins.war'
