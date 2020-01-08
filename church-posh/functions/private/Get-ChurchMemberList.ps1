function Get-ChurchMemberList {
    param (
        [psobject] $Session,
        [int] $UnitNumber
    )
    $params = @{
        Uri         = (Get-ChurchConfig -Action "MemberList") -f $UnitNumber
        WebSession  = $Session
        Method      = "Get"
        ContentType = "application/json"
    }
    $response = Invoke-ChurchWebRequest @params
    return $response.Content;
}

<#
[{
    nameFormats: {
        listPreferredLocal: "Name, Fake",
        givenPreferredLocal: "Fake",
        familyPreferredLocal: "Name"
    },
    uuid: "00000000-0000-0000-0000-000000000000",
    nameOrder: 1,
    age: 0,
    emails: null,
    phones: null,
    phoneNumber: null,
    priesthoodOffice: "NONE",
    membershipUnit: null,
    legacyCmisId: 000000000,
    sex: "F",
    unitOrgsCombined: [
    "00000000-0000-0000-0000-000000000000",
    "00000000-0000-0000-0000-000000000000"
    ],
    householdMember: {
        householdRole: "SPOUSE",
        household: {
            anchorPerson: {
                legacyCmisId: 000000000,
                uuid: "00000000-0000-0000-0000-000000000000"
            },
            uuid: "00000000-0000-0000-0000-000000000000",
            familyNameLocal: "Name",
            directoryPreferredLocal: "Name, Fake & Fake",
            address: {
                formattedLine1: "0000 W 0000 S",
                formattedLine2: "Fake City, Fake 00000",
                formattedLine3: null,
                formattedLine4: null,
                addressLines: [
                "0000 W 0000 S",
                "Fake City, Fake 00000"
                ]
            },
            emails: null,
            phones: null,
            unit: {
                parentUnit: null,
                uuid: null,
                unitNumber: 000000,
                nameLocal: "Fake Ward",
                unitType: null,
                children: null
            }
        },
        membershipUnitFlag: true
    },
    email: null,
    member: true,
    isOutOfUnitMember: false,
    nameFamilyPreferredLocal: "Name",
    unitNumber: 000000,
    nameGivenPreferredLocal: "Fake",
    houseHoldMemberNameForList: "Fake",
    isHead: true,
    personUuid: "00000000-0000-0000-0000-000000000000",
    nameListPreferredLocal: "Name, Fake",
    householdNameDirectoryLocal: "Name, Fake & Fake",
    isAdult: false,
    outOfUnitMember: false,
    householdUuid: "00000000-0000-0000-0000-000000000000",
    formattedAddress: "0000 W 0000 S<br/>Fake City, Fake 00000",
    householdEmail: null,
    isMember: true,
    priesthoodTeacherOrAbove: false,
    convert: false,
    youthBasedOnAge: false,
    isSpouse: true,
    isSingleAdult: false,
    householdPhoneNumber: null,
    householdRole: "SPOUSE",
    householdAnchorPersonUuid: "00000000-0000-0000-0000-000000000000",
    householdNameFamilyLocal: "Name",
    isProspectiveElder: false,
    isYoungSingleAdult: false,
    unitName: "Fake Ward",
    address: {
        formattedLine1: "0000 W 0000 S",
        formattedLine2: "Fake City, Fake 00000",
        formattedLine3: null,
        formattedLine4: null,
        addressLines: [
        "0000 W 0000 S",
        "Fake City, Fake 00000"
        ]
    },
    birth: {
        date: {
            date: "1870-01-01",
            calc: "1870-01-01",
            display: "01 Jan 1870"
        }
    },
    personStatusFlags: {
        member: true,
        convert: false,
        adult: false,
        singleAdult: false,
        youngSingleAdult: false,
        prospectiveElder: false
    }
}]
#>