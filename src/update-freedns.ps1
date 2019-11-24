[CmdletBinding(SupportsShouldProcess=$True)]
Param(
	[Parameter(Mandatory=$true)]
	[string]$Domain,
	[Parameter(Mandatory=$true)]
	[string]$Key,
	[Parameter(Mandatory=$false)]
	[string]$UpdateBase = "http://freedns.afraid.org/dynamic/update.php",
	[Parameter(Mandatory=$false)]
	[string]$LogFolder = ".\logs",
	[Parameter(Mandatory=$false)]
	[string]$Notify = "windows"
)

$currentDate = Get-Date -format yyyy-MM-dd
$currentDateTime = Get-Date -format yyyy-MM-dd-HH-mm-ss
$logFile = "$($LogFolder)\$($CurrentDate)-log-ipupdate.txt"

# Create log file if not exists
if (-Not (Test-Path($logFile))) {
	Write-Output "$($currentDateTime) `tLog file created." | Tee-Object -FilePath $logFile 
}

# Get host ip address
try {
	$myip = (Invoke-RestMethod "http://ipinfo.io/json").ip
	# $myip = (Invoke-WebRequest -uri "https://ifconfig.me/ip").Content
} catch {
	Write-Output "$($currentDateTime) `tHost ip can't be fetched. $_.Exception" | Tee-Object -FilePath $logFile -Append
	exit 1
}

# Skip, if host ip is not available
if (-Not ($myip)) {
	Write-Output "$($currentDateTime) `tHost ip is null." | Tee-Object -FilePath $logFile -Append
	exit 1
}

# Get ip of domain and skip if it's not available
$afraidip = [System.Net.Dns]::GetHostAddresses($domain)[0]
if (-Not ($afraidip)) {
	Write-Output "$($currentDateTime) `tFreeDNS ip is null." | Tee-Object -FilePath $logFile -Append
	exit 1
}

# Just log when host and domain ip is the same
if ($afraidip -eq $myip) {
	Write-Output "$($currentDateTime) `tHost ip: $($myip), FreeDNS ip: $($afraidip). There was no change." | Tee-Object -FilePath $logFile -Append
} else {
	try {
		# and trigger an update when they are different
		$updateurl = "$($updatebase)?$($key)"
		$updateResponse = (Invoke-WebRequest -uri $updateurl).Content 
		Write-Output "$($currentDateTime) `tHost ip: $($myip), FreeDNS ip: $($afraidip). Update was needed! $($updateResponse)" | Tee-Object -FilePath $logFile -Append

		# Make a Windows notification if required (with 24 hours timout)
		if ($Notify -eq "windows") {			
			[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
			$notifyIcon = New-Object System.Windows.Forms.NotifyIcon
			$notifyIcon.Icon = [System.Drawing.SystemIcons]::Information		
			$notifyIcon.BalloonTipTitle = "Dynamic IP has been updated!"
			$notifyIcon.BalloonTipText = "New ip: $($afraidip)." 
			$notifyIcon.BalloonTipIcon = "Info" 		
			$notifyIcon.Visible = $True 		
			$notifyIcon.ShowBalloonTip(86400000)
		}

	} catch {
		Write-Output "$($currentDateTime) `tUpdate failed. $_.Exception" | Tee-Object -FilePath $logFile -Append
		exit 1
	}
}

exit 0
