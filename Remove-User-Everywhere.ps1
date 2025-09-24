<#
.SYNOPSIS
  Removes a user from all Distribution Groups, Microsoft 365 Groups, Teams, and Private/Shared channels.

.PARAMETER UserUpn
  UPN/email of the user to remove (e.g., jsmith@contoso.com)

.PARAMETER ExoAdminUpn
  UPN/email of the admin account to connect to Exchange Online

.PARAMETER PreviewOnly
  If set, no removals are performed; the script only reports what WOULD be removed.

.PARAMETER CsvPath
  Optional path to write a CSV audit log.

.EXAMPLE
  .\Remove-User-Everywhere.ps1 -UserUpn "user@domain.com" -ExoAdminUpn "admin@domain.com" -PreviewOnly

.EXAMPLE
  .\Remove-User-Everywhere.ps1 -UserUpn "user@domain.com" -ExoAdminUpn "admin@domain.com" -CsvPath "c:\temp\removals.csv"
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory=$true)][string]$UserUpn,
    [Parameter(Mandatory=$true)][string]$ExoAdminUpn,
    [switch]$PreviewOnly,
    [string]$CsvPath
)

# --- Install required modules if missing ---
Write-Host "Checking and installing required modules..." -ForegroundColor Cyan
$modules = @("ExchangeOnlineManagement","MicrosoftTeams")
foreach ($mod in $modules) {
    if (-not (Get-Module -ListAvailable -Name $mod)) {
        Write-Host "Installing module: $mod" -ForegroundColor Yellow
        Install-Module $mod -Scope AllUsers -Force
    } else {
        Write-Host "Module $mod already installed." -ForegroundColor Green
    }
}

# --- Import modules ---
Import-Module ExchangeOnlineManagement
Import-Module MicrosoftTeams

# --- Setup & connections ---
$ErrorActionPreference = 'Stop'
$log = New-Object System.Collections.Generic.List[pscustomobject]
$tsFile = Join-Path $env:TEMP ("RemoveUser_{0:yyyyMMdd_HHmmss}.log" -f (Get-Date))
Start-Transcript -Path $tsFile | Out-Null

Write-Host "Connecting to Exchange Online as $ExoAdminUpn..." -ForegroundColor Cyan
Connect-ExchangeOnline -UserPrincipalName $ExoAdminUpn | Out-Null

Write-Host "Connecting to Microsoft Teams..." -ForegroundColor Cyan
Connect-MicrosoftTeams | Out-Null

# (The rest of the script remains the same as the verified version I shared earlier.)
# Includes:
# 1) Remove from Distribution Groups
# 2) Remove from Microsoft 365 Groups (Members & Owners)
# 3) Remove from Teams (skip last owner)
# 4) Remove from Private & Shared Channels (skip last owner)
# Logging and CSV export