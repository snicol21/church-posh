param (
    [Parameter(Mandatory = $true)]
    [string]$apiKey
)

$ModulePath = $(Get-Item $PSScriptRoot).Parent.FullName
$env:PSModulePath = $env:PSModulePath + "$([System.IO.Path]::PathSeparator)$ModulePath"
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
Publish-Module -Name 'church-posh' -NuGetApiKey $apiKey