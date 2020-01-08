function Invoke-ChurchWebRequest {
    param (
        [Parameter(Mandatory = $true)]
        [psobject] $WebSession,
        [Parameter(Mandatory = $true)]
        [string] $Uri,
        [string] $Method,
        [string] $ContentType
    )
    try {
        Write-Host "[INF] Invoking WebRequest...$Uri"
        $params = @{
            Uri             = $Uri
            WebSession      = $WebSession
            UseBasicParsing = $true
            ErrorAction     = "Stop"
        }
        if ($Method) { $params.Add("Method", $Method) }
        if ($ContentType) { $params.Add("ContentType", $ContentType) }
        $response = Invoke-WebRequest @params
        if ($response.Headers.Expires) { throw }
    }
    catch {
        try {
            $response = Invoke-WebRequest @params
        }
        catch {
            $ErrorMessage = $_.Exception.Message
            Write-Host "[ERR] There was an error invoking webrequest $Uri. Exception Message: $ErrorMessage" -ForegroundColor "Red"
        }
    }
    return $response
}