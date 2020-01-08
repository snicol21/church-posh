function Get-SessionFromCookies {
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [psobject[]] $Cookies
    )
    Write-Host "[INF] Creating session from cookies..."
    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    foreach ($cookie in $Cookies) {
        $newCookie = New-Object System.Net.Cookie 
        $newCookie.Name = $cookie.Name
        $newCookie.Path = $cookie.Path
        $newCookie.Value = $cookie.Value
        $newCookie.Domain = $cookie.Domain
        $session.Cookies.Add($newCookie);
    }
    return $session
}