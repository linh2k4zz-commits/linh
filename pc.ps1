# Enable RDP
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' `
  -Name "fDenyTSConnections" -Value 0

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' `
  -Name "UserAuthentication" -Value 0

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Restart-Service TermService -Force

# Create User
$Username = "RDP"
$Password = "linhth2k4"

$SecurePass = ConvertTo-SecureString $Password -AsPlainText -Force

# Remove old user if exists
if (Get-LocalUser -Name $Username -ErrorAction SilentlyContinue) {
    net user $Username /delete
}

# Create new user
New-LocalUser -Name $Username `
    -Password $SecurePass `
    -AccountNeverExpires

# Add permissions
Add-LocalGroupMember -Group "Administrators" -Member $Username
Add-LocalGroupMember -Group "Remote Desktop Users" -Member $Username

# Install Tailscale
$installer = "$env:TEMP\tailscale.exe"

Invoke-WebRequest `
    -Uri "https://pkgs.tailscale.com/stable/tailscale-setup-1.96.3.exe" `
    -OutFile $installer

Start-Process $installer `
    -ArgumentList "/S" `
    -Wait

Start-Sleep 15

# Connect Tailscale
$TAILSCALE_KEY = "tskey-auth-kHbZ1PnEnD11CNTRL-fgTFfdT8mPFz1Q245SKnPFKGrYmurvixc"

& "$env:ProgramFiles\Tailscale\tailscale.exe" up `
    --authkey=$TAILSCALE_KEY `
    --hostname=windows-rdp `
    --accept-routes

Start-Sleep 10

# Get Tailscale IP
$IP = & "$env:ProgramFiles\Tailscale\tailscale.exe" ip -4

# Show Info
Write-Host ""
Write-Host "========== RDP INFO =========="
Write-Host "IP: $IP"
Write-Host "User: $Username"
Write-Host "Pass: $Password"
Write-Host "=============================="
Write-Host ""
