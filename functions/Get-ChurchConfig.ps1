function Get-ChurchConfig {
    param (
        [ValidateSet(
            "Login",
            "MemberList",
            "BirthdayList",
            "MembersMovedIn",
            "MembersWithCallings",
            "Ministering",
            "RecommendStatus",
            "ActionInterviewList",
            "UnitDetail"
        )]
        [string] $Action
    )
    $file = "$($MyInvocation.MyCommand.Module.ModuleBase)\church-posh.config.json"
    
    $Config = Get-Content $file | ConvertFrom-Json

    switch ($Action) {
        "Login" { return $config."auth-url" }
        
        # lcr-services (requires elevated access)
        "MemberList" { return $config."lcr-services"."member-list" }
        "BirthdayList" { return $config."lcr-services"."birthday-list" }
        "MembersMovedIn" { return $config."lcr-services"."members-moved-in" }
        "MembersWithCallings" { return $config."lcr-services"."members-with-callings" }
        "Ministering" { return $config."lcr-services"."ministering" }
        "RecommendStatus" { return $config."lcr-services"."recommend-status" }
        "ActionInterviewList" { return $config."lcr-services"."action-interview-list" }
        "UnitDetail" { return $config."lcr-services"."unit-detail" }

        default { return $config }
    }
}