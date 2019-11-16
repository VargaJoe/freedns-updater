[CmdletBinding(SupportsShouldProcess=$True)]
Param(
	[Parameter(Mandatory=$true)]
	[string]$Domain,
	[Parameter(Mandatory=$true)]
	[string]$Key,
	[Parameter(Mandatory=$false)]
	[string]$UpdateBase = "http://freedns.afraid.org/dynamic/update.php",
	[Parameter(Mandatory=$false)]
	[string]$LogFolder = ".\logs"
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

if (-Not ($myip)) {
	Write-Output "$($currentDateTime) `tHost ip is null." | Tee-Object -FilePath $logFile -Append
	exit 1
}

$afraidip = [System.Net.Dns]::GetHostAddresses($domain)[0]
if (-Not ($afraidip)) {
	Write-Output "$($currentDateTime) `tFreeDNS ip is null." | Tee-Object -FilePath $logFile -Append
	exit 1
}

if ($afraidip -eq $myip) {
	Write-Output "$($currentDateTime) `tHost ip: $($myip), FreeDNS ip: $($afraidip). There was no change." | Tee-Object -FilePath $logFile -Append
} else {
	try {
		$updateurl = "$($updatebase)?$($key)"
		$updateResponse = (Invoke-WebRequest -uri $updateurl).Content 
		Write-Output "$($currentDateTime) `tHost ip: $($myip), FreeDNS ip: $($afraidip). Update was needed! $($updateResponse)" | Tee-Object -FilePath $logFile -Append
	} catch {
		Write-Output "$($currentDateTime) `tUpdate failed. $_.Exception" | Tee-Object -FilePath $logFile -Append
		exit 1
	}
}

exit 0
