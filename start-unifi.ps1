$UNIFI_PATH='C:\Unifi'
$UNIFI_JAR=Join-Path $UNIFI_PATH '\lib\ace.jar'
$UNIFI_DBLOCK=Join-Path $UNIFI_PATH '\data\db\WiredTiger.lock'
$LAUNCH_ARGS=@('-Xmx1024M','-jar',$UNIFI_JAR,'start')
if(Test-Path $UNIFI_DBLOCK){
    Write-Host "Found Mongo LOCK. Deleting $UNIFI_DBLOCK ..."
    Remove-Item $UNIFI_DBLOCK -Force
}

Write-Host "Starting Unifi Controller - java.exe $LAUNCH_ARGS"
Start-Process -FilePath 'java.exe' -ArgumentList $LAUNCH_ARGS -WorkingDirectory $UNIFI_PATH -NoNewWindow -Wait