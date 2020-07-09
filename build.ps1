[CmdletBinding()]
param
(
    [Parameter()]
    [Switch]$TagLatest
)
$ErrorActionPreference = "Stop"
. .\build.config.ps1
$UNIFI_VERSION=$env:DOCKER_APPLICATION_VERSION
$BASE_IMAGE=$env:DOCKER_BASE_IMAGE
$imageFullName = ("{0}/{1}:{2}-windowsservercore-{3}" -f $env:DOCKER_REPO, $env:DOCKER_IMAGE, $UNIFI_VERSION,$env:DOCKER_IMAGE_TAG)
$imageLatestName = ("{0}/{1}:latest" -f $env:DOCKER_REPO, $env:DOCKER_IMAGE)

Write-Host `Building $imageFullName`
docker build --build-arg BASE_IMAGE=$BASE_IMAGE --build-arg UNIFI_VERSION=$UNIFI_VERSION . -t $imageFullName
if($TagLatest){
    Write-Host "Tagging image as latest"
    docker tag $imageFullName $imageLatestName
}