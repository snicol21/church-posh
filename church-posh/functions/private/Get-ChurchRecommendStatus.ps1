function Get-ChurchRecommendStatus {
    param (
        [psobject] $Session,
        [int] $UnitNumber
    )
    $params = @{
        Uri         = (Get-ChurchConfig -Action "RecommendStatus") -f $UnitNumber
        WebSession  = $Session
        Method      = "Get"
        ContentType = "application/json"
    }
    $response = Invoke-ChurchWebRequest @params
    return $response.Content;
}