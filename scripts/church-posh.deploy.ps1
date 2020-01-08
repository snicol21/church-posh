param (
    [Parameter(Mandatory = $true)]
    [string]$apiKey
)
$Root = $(Get-Item $PSScriptRoot).Parent.FullName;
$ModulePath = "$Root\church-posh";
$env:PSModulePath = $env:PSModulePath + "$([System.IO.Path]::PathSeparator)$ModulePath"
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
Publish-Module -Name 'church-posh' -NuGetApiKey $apiKey -Path $ModulePath