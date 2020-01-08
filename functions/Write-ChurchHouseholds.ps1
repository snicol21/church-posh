function Write-ChurchHouseholds {
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
    $membersMovedInJSON = Get-ChurchMembersMovedIn -Session $session -UnitNumber $UnitNumber;

    $memberList = $memberListJSON | ConvertFrom-Json
    $membersMovedIn = $membersMovedInJSON | ConvertFrom-Json

    $persons = @();
    foreach ($member in $memberList) {
        $index = $membersMovedIn.id.indexOf($member.legacyCmisId)
        if ($index -gt -1) {
            $memberMovedIn = $membersMovedIn[$index];
            $member | Add-Member -Type "NoteProperty" -Name "newMoveIn" -Value $true
            $member | Add-Member -Type "NoteProperty" -Name "newMoveInDate" -Value $memberMovedIn.moveDate
        }
        $persons += $member
    }    

    $households = @();
    $householdList = $persons | Group-Object "householdUuid"
    foreach ($household in $householdList) {
        $thisHousehold = @{
            uuid       = $household.Name
            unitNumber = $household.Group[0].householdMember.household.unit.unitNumber
            name       = $household.Group[0].householdMember.household.directoryPreferredLocal
            surname    = $household.Group[0].householdMember.household.familyNameLocal
            address    = $household.Group[0].householdMember.household.address.addressLines -join (" ")
            members    = @()
        }
        if ($household.Group[0].newMoveIn) {
            $thisHousehold.Add("newMoveIn", $household.Group[0].newMoveIn)
            $thisHousehold.Add("newMoveInDate", $household.Group[0].newMoveInDate)
        }

        foreach ($member in $household.Group | Sort-Object @{Expression = { $_.isHead }; Ascending = $false }, @{Expression = { $_.age }; Ascending = $false }) {
            $thisHousehold.members += @{
                uuid          = $member.uuid
                householdUuid = $member.householdUuid
                head          = $member.isHead
                name          = $member.nameListPreferredLocal
                displayName   = "$($member.nameFormats.givenPreferredLocal) $($member.nameFormats.familyPreferredLocal)"
                age           = $member.age
            }
        }

        $households += $thisHousehold
    }    

    return $households | ConvertTo-Json -Depth 10 -Compress;
}

<#
[{
    uuid: "00000000-0000-0000-0000-000000000000",
    unitNumber: 000000,
    name: "Name, Fake1 & Fake2",
    surname: "Name",
    address: "1000 W 1000 S Fake City, Fake 00000",
    newMoveIn: "true",
    newMoveInDate: "20190101"
    members: [
        {
            uuid: "00000000-0000-0000-0000-000000000000",
            householdUuid: "00000000-0000-0000-0000-000000000000",
            head: true,
            name: "Name, Fake1",
            displayName: "Fake1 Name",
            age: "0"
        },
        {
            uuid: "00000000-0000-0000-0000-000000000000",
            householdUuid: "00000000-0000-0000-0000-000000000000",
            unitNumber: 000000,
            Name: true,
            name: "Name, Fake2",
            displayName: "Fake2 Name",
            age: "0"
        }
    ]
}]
#>