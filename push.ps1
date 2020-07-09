[CmdletBinding()]
param
(
    [Parameter()]
    [Switch]$TagLatest
)
. .\build.config.ps1

$UNIFI_VERSION = $env:DOCKER_APPLICATION_VERSION
$imageFullName = ("{0}/{1}:{2}-windowsservercore-{3}" -f $env:DOCKER_REPO, $env:DOCKER_IMAGE, $UNIFI_VERSION,$env:DOCKER_IMAGE_TAG)
$imageLatestName = ("{0}/{1}:latest" -f $env:DOCKER_REPO, $env:DOCKER_IMAGE)

Write-Host `Pushing $imageFullName`
docker push $imageFullName

if($TagLatest){
    Write-Host "Tagging image as latest"
    docker push $imageLatestName
}
