param (
    [Parameter(Mandatory = $true)]
    [string]$apiKey
)

Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
# Get-Module church-posh
# Get-Module -ListAvailable
# Publish-Module -Name 'church-posh' -NuGetApiKey $apiKey

