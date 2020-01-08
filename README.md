# church-posh
PowerShell module that uses Selenium to securely login to churchofjesuschrist.org and pull useful Ward Exec. Secretary information

## Install
I've published this module to PowerShellGallery, so you just need to run this script in an Admin window of PS
```
Install-Module church-posh -Scope CurrentUser
```

## Run
```
Write-ChurchPersons -UserName <UserName> -Password <Password> -UnitNumber <UnitNumber> |
  Out-File "$HOME\Desktop\ward-person-data.json"
```

## Other less useful scripts
```
Write-ChurchMinistering -UserName <UserName> -Password <Password> -UnitNumber <UnitNumber> |
  Out-File "$HOME\Desktop\ward-ministering-data.json" # takes awhile to run

Write-ChurchHouseholds -UserName <UserName> -Password <Password> -UnitNumber <UnitNumber> |
  Out-File "$HOME\Desktop\ward-household-data.json"
```

Each of these will, of course, prompt for your credentials and unit number.

Good luck!
