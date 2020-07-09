
$ErrorActionPreference = "Stop"
. .\build.config.ps1
$imageFullName = ("{0}/{1}:{2}-windowsservercore" -f $env:DOCKER_REPO, $env:DOCKER_IMAGE, $env:DOCKER_APPLICATION_VERSION)
docker run -p 8080:8080  -p 8081:8081 -p 8443:8443 -p 8843:8843 -p 8880:8880 -v C:/temp/unifi-test:c:/Unifi/data -it --rm $imageFullName powershell