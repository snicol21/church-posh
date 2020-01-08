function New-ChurchSession {
    param (
        [Parameter(Mandatory = $true)]
        [string] $UserName,
        [Parameter(Mandatory = $true)]
        [string] $Password
    )
    
    $uri = Get-ChurchConfig -Action "Login"
    $driver = Start-SeChrome
    Enter-SeUrl -Url $uri -Driver $driver
    $username_input = Find-SeElement -Driver $driver -Name 'username' -Wait -Timeout 2
    $password_input = Find-SeElement -Driver $driver -Name 'password' -Wait -Timeout 2
    $submit_button = Find-SeElement -Driver $driver -Id 'sign-in' -Wait -Timeout 2

    $username_input.Clear()
    $password_input.Clear()
    
    $username_input.SendKeys($UserName)
    $password_input.SendKeys($Password)
    $submit_button.Click()
    Start-Sleep -Seconds 2
    
    $cookies = $driver.Manage().Cookies.AllCookies
    $session = Get-SessionFromCookies -Cookies $cookies

    return $session
}