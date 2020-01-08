# church-posh
PowerShell module that uses Selenium to securely login to churchofjesuschrist.org and pull useful Ward Exec. Secretary information

## Install
I've published this module to PowerShell Gallery, so you just need to run this script in an Admin window of PS
```
Install-Module church-posh
```

## Run
```
Write-ChurchPersons | Out-File "$HOME\Desktop\ward-person-data.json"
Write-ChurchMinistering | Out-File "$HOME\Desktop\ward-ministering-data.json"
Write-ChurchHouseholds | Out-File "$HOME\Desktop\ward-household-data.json"
```

Each of these will of course prompt you for your credentials and unit number

Good luck!
