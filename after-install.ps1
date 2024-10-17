# Import the ServerManager module
Import-Module -Name ServerManager

# Define variables
$appPool = "Fekra.Pika.Ocpp.16.CentralSystem"
$siteName = "Fekra.Pika.Ocpp.16.CentralSystem"
$deployPath = "C:\Custom\Fekra.Pika.Ocpp.16.CentralSystem"

# Ensure the deployment directory exists
if (!(Test-Path $deployPath)) {
    Write-Host "Creating deployment directory: $deployPath"
    New-Item -Path $deployPath -ItemType Directory
}

# Start the application pool
Write-Host "Starting $appPool"
Start-WebAppPool -Name $appPool

# Restart IIS
Write-Host "Starting IIS..."
& iisreset /start

# Start the IIS site
Write-Host "Starting IIS Site $siteName"
Start-WebItem -Site $siteName

Write-Host "After install script completed."
