$ErrorActionPreference="Stop"

Get-Process java
Get-Process mongod
Test-NetConnection $env:COMPUTERNAME -Port 8443
Test-NetConnection localhost -Port 27117