# Tools-Remove-USERS-EveryWhere
Tools-Remove-USERS-EveryWhere remove entra accounts from Teams channels (inc private), SharePoint groups, Distribution groups, security groups 

download the remove-user-everywhere.PS1 to a local device. i typically have a c:\scripts folder that i use to drop and run my scripts from

NOTE: Please remove the quotes on the accounts and also replace with your details (added as a request becuase people left the quotes on and complained this did not work)

User - Account that you need to remove from the groups, etc...
admin - needs to be a global admin or have the following administrative Entra Roles for User, Teams, SharePoint, Exchange   


run from an administrative Powershell -- it will prompt to login into office 365 

 this is your PS command line... this is a dry run  aka preview see and review the output

 
.\Remove-User-Everywhere.ps1 -UserUpn "user@domain.com" -ExoAdminUpn "admin@domain.com" -PreviewOnly -CsvPath "C:\Temp\preview.csv"


if it looks good run this command to remove the user account from everywhere :)

.\Remove-User-Everywhere.ps1 -UserUpn "user@domain.com" -ExoAdminUpn "admin@domain.com" -CsvPath "C:\Temp\removals.csv"

happy cleaning up your groups, and teams channels of all those stale "offboarded" account
