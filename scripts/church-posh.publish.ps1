param (
    [Parameter(Mandatory = $true)]
    [string]$apiKey
)

Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
# Publish-Module -Name 'church-posh' -NuGetApiKey $apiKey

