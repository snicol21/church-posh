function Write-ChurchPersons {
    param (
        [Parameter(Mandatory = $true)]
        [string] $UserName,
        [Parameter(Mandatory = $true)]
        [string] $Password,
        [Parameter(Mandatory = $true)]
        [int] $UnitNumber
    )

    $session = New-ChurchSession -UserName $UserName -Password $Password;

    $memberListJSON = Get-ChurchMemberList -Session $session -UnitNumber $UnitNumber;
    $birthdayListJSON = Get-ChurchBirthdayList -Session $session
    $membersMovedInJSON = Get-ChurchMembersMovedIn -Session $session -UnitNumber $UnitNumber;
    $membersWithCallingsJSON = Get-ChurchMembersWithCallings -Session $session -UnitNumber $UnitNumber;
    $recommendStatusJSON = Get-ChurchRecommendStatus -Session $session -UnitNumber $UnitNumber;
    $actionInterviewListJSON = Get-ChurchActionInterviewList -Session $session -UnitNumber $UnitNumber;

    $memberList = $memberListJSON | ConvertFrom-Json
    $birthdayList = ($birthdayListJSON | ConvertFrom-Json) | Select-Object -ExpandProperty "birthdays"
    $membersMovedIn = $membersMovedInJSON | ConvertFrom-Json
    $membersWithCallings = $membersWithCallingsJSON | ConvertFrom-Json
    $recommendStatus = $recommendStatusJSON | ConvertFrom-Json
    $actionInterviewList = $actionInterviewListJSON | ConvertFrom-Json

    $actionInterviews = @();
    foreach ($type in $actionInterviewList) {
        foreach ($person in $type.list) {
            $action = @{
                id          = $person.id;
                type        = $type.type;
                title       = "$($type.title)$(if ($type.subTitle) { ' - ' + $type.subTitle })";
                description = $type.description;
                action      = $person.action;                
            };
            $actionInterviews += $action;
        }
    }

    $persons = @();

    foreach ($member in $memberList) {
        
        $index = $birthdayList.id.indexOf($member.legacyCmisId)
        if ($index -gt -1) {
            $birthday = $birthdayList[$index];
            $member | Add-Member -Type "NoteProperty" -Name "mrn" -Value $birthday.mrn
            $member | Add-Member -Type "NoteProperty" -Name "formattedMrn" -Value $birthday.formattedMrn
            $member.nameFormats | Add-Member -Type "NoteProperty" -Name "spokenName" -Value $birthday.spokenName
        }

        $index = $membersMovedIn.id.indexOf($member.legacyCmisId)
        if ($index -gt -1) {
            $memberMovedIn = $membersMovedIn[$index];
            $member | Add-Member -Type "NoteProperty" -Name "newMoveIn" -Value $true
            $member | Add-Member -Type "NoteProperty" -Name "newMoveInDate" -Value $memberMovedIn.moveDateCalc

            <#get prior unit detail#>
            $priorUnitNumber = $memberMovedIn.priorUnitNumber;
            if ($priorUnitNumber) {
                $priorUnitDetailJSON = Get-ChurchUnitDetail -Session $session -UnitNumber $priorUnitNumber;
                $priorUnitDetail = $priorUnitDetailJSON | ConvertFrom-Json
                if ($priorUnitDetail) {
                    $member | Add-Member -Type "NoteProperty" -Name "priorUnitDetail" -Value $priorUnitDetail
                }
            }

        }

        $index = $recommendStatus.id.indexOf($member.legacyCmisId)
        if ($index -gt -1) {
            $recommend = $recommendStatus[$index];
            $member | Add-Member -Type "NoteProperty" -Name "recommendExpirationDate" -Value $recommend.expirationDate
            $member | Add-Member -Type "NoteProperty" -Name "recommendStatus" -Value $recommend.status
            $member | Add-Member -Type "NoteProperty" -Name "recommendType" -Value $recommend.type
        }

        $indexes = @()
        $singleIndex = -1
        do {
            $singleIndex = [array]::IndexOf($actionInterviews.id, $member.legacyCmisId, $singleIndex + 1)
            if ($singleIndex -ge 0) { $indexes += $singleIndex }
        } while ($singleIndex -ge 0)

        if ($indexes.Length) {
            $member | Add-Member -Type "NoteProperty" -Name "actionInterviews" -Value @();
            foreach ($index in $indexes) {
                $actionInterview = $actionInterviews[$index];
                $member.actionInterviews += @{
                    type        = $actionInterview.type;
                    title       = $actionInterview.title;
                    description = $actionInterview.description;
                    action      = $actionInterview.action;                
                }    
            }
        }

        $indexes = @()
        $singleIndex = -1
        do {
            $singleIndex = [array]::IndexOf($membersWithCallings.id, $member.legacyCmisId, $singleIndex + 1)
            if ($singleIndex -ge 0) { $indexes += $singleIndex }
        } while ($singleIndex -ge 0)

        if ($indexes.Length) {
            $member | Add-Member -Type "NoteProperty" -Name "callings" -Value @();
            foreach ($index in $indexes) {
                $calling = $membersWithCallings[$index];
                $member.callings += @{
                    organization  = $calling.organization
                    position      = $calling.position
                    activeDate    = $calling.activeDate
                    sustainedDate = $calling.sustainedDate
                    setApartDate  = $calling.setApartDate
                    setApart      = $calling.setApart
                }    
            }
        }

        $persons += $member
    }    

    return $persons | ConvertTo-Json -Depth 10 -Compress;
}