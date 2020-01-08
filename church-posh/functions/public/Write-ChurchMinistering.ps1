function Write-ChurchMinistering {
    param (
        [Parameter(Mandatory = $true)]
        [string] $UserName,
        [Parameter(Mandatory = $true)]
        [string] $Password,
        [Parameter(Mandatory = $true)]
        [int] $UnitNumber
    )
    begin {
        function Get-StringHash([String] $String, $HashName = "MD5") { 
            $StringBuilder = New-Object System.Text.StringBuilder 
            [System.Security.Cryptography.HashAlgorithm]::Create($HashName).ComputeHash([System.Text.Encoding]::UTF8.GetBytes($String)) | % { 
                [Void]$StringBuilder.Append($_.ToString("x2")) 
            } 
            $StringBuilder.ToString() 
        }
        function F {
            return "sisters"
        }

        function M {
            return "brothers"
        }
    }
    process {
        $session = New-ChurchSession -UserName $UserName -Password $Password;

        $memberListJSON = Get-ChurchMemberList -Session $session -UnitNumber $UnitNumber;
        $memberList = $memberListJSON | ConvertFrom-Json

        $output = @{
            households     = @{ }
            persons        = @{ }
            companionships = @{ 
                brothers = @{ }
                sisters  = @{ }
            }
        };

        foreach ($member in $memberList) {
        
            $churchMinisteringParams = @{
                HohId = $member.householdMember.household.anchorPerson.legacyCmisId
                Id    = $member.legacyCmisId
            }
            $ministeringJSON = Get-ChurchMinistering -Session $session -UnitNumber $UnitNumber @churchMinisteringParams;
            # $ministeringJSON = (Get-Content "C:\Users\spencer.nicol\Desktop\church\test\ministering\$($member.uuid).json" | Out-String)
            if ($ministeringJSON) {
                $ministering = $ministeringJSON | ConvertFrom-Json

                $output.persons."$($member.uuid)" = @{ }

                if ($ministering.ministeringBrothers) {
                    $output.households."$($member.householdUuid)" = $ministering.ministeringBrothers
                    $output.persons."$($member.uuid)".Add("brothers", $ministering.ministeringBrothers)
                }

                if ($ministering.ministeringSisters) {
                    $output.persons."$($member.uuid)".Add("sisters", $ministering.ministeringSisters)
                }

                if ($ministering.companions) {
                    $output.persons."$($member.uuid)".Add("companions", $ministering.companions)
                
                    $companionship = @()
                    $companionship += $member.uuid
                    foreach ($companion in $ministering.companions) {
                        $companionship += $companion.personUuid
                    }
                    $companionshipString = (($companionship | Sort-Object) -join ('|'))
                    $companionshipUuid = Get-StringHash -String $companionshipString
                    $companionshipGroup = & $member.sex

                    if (!$output.companionships.$companionshipGroup.ContainsKey($companionshipUuid)) {
                        $output.companionships.$companionshipGroup.Add($companionshipUuid, @{ companions = @() })
                    }
                    $thisCompanionship = $output.companionships.$companionshipGroup.$companionshipUuid
                    foreach ($companion in $ministering.companions) {
                        if ($thisCompanionship.companions.personUuid -notcontains $companion.personUuid) {
                            $thisCompanionship.companions += $companion
                        }
                    }
                }

                if ($ministering.assignments) {
                    $output.persons."$($member.uuid)".Add("assignments", $ministering.assignments)

                    if (!$output.companionships.$companionshipGroup.$companionshipUuid.ContainsKey("assignments")) {
                        $output.companionships.$companionshipGroup.$companionshipUuid.Add("assignments", $ministering.assignments)
                    }
                }

                if ($output.persons."$($member.uuid)".Count -eq 0) {
                    $output.persons.Remove($member.uuid)
                }
            }
        }    

        return $output | ConvertTo-Json -Depth 10 -Compress;
    }
}