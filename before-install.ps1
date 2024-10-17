# Import the ServerManager module
Import-Module -Name ServerManager

# Set execution policy
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Define variables
$currentRetry = 0
$success = $false
$appPool = "Fekra.Pika.Ocpp.16.CentralSystem"
$siteName = "Fekra.Pika.Ocpp.16.CentralSystem"
$finalPath = "C:\Custom\Fekra.Pika.Ocpp.16.CentralSystem"

# Stop the application pool
Write-Host "Stopping $appPool"
Stop-WebAppPool -Name $appPool

# Wait for the application pool to stop
do {
    $status = (Get-WebAppPoolState -name $appPool).Value
    if ($status -eq "Stopped") {
        $success = $true
        Write-Host "$appPool is $status."
    }
    else {
        Write-Host "Let's wait a few seconds. $appPool is $status"
        Start-Sleep -s 10
        $currentRetry = $currentRetry + 1
    }
} while (!$success -and $currentRetry -le 4)

# Stop the IIS website
Write-Host "Stopping IIS Site $siteName"
Stop-WebItem -Site $siteName -Force

# Stop IIS
Write-Host "Stopping IIS..."
& iisreset /Stop

Write-Host "Before install script completed."
