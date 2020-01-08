$ModulePath = $(Get-Item $PSScriptRoot).Parent.FullName
$env:PSModulePath = $env:PSModulePath + "$([System.IO.Path]::PathSeparator)$ModulePath"