function Get-ChurchMinistering {
    param (
        [psobject] $Session,
        [string] $HohId,
        [string] $Id,
        [int] $UnitNumber
    )
    $params = @{
        Uri         = (Get-ChurchConfig -Action "Ministering") -f $HohId, $Id, $UnitNumber
        WebSession  = $Session
        Method      = "Get"
        ContentType = "application/json"
    }
    $response = Invoke-ChurchWebRequest @params
    return $response.Content;
}

<#
{
    ministeringBrothers: [
    {
        personUuid: "00000000-0000-0000-0000-000000000000",
        legacyCmisId: 000000000,
        name: "Name, Fake",
        nameOrder: 0,
        youthBasedOnAge: false
    },
    {
        personUuid: "00000000-0000-0000-0000-000000000000",
        legacyCmisId: 000000000,
        name: "Name, Fake",
        nameOrder: 0,
        youthBasedOnAge: false
    }
    ],
    ministeringSisters: [ ],
    companions: [
    {
        personUuid: "00000000-0000-0000-0000-000000000000",
        legacyCmisId: 000000000,
        name: "Name, Fake",
        nameOrder: 0,
        youthBasedOnAge: false
    }
    ],
    assignments: [
    {
        personUuid: "00000000-0000-0000-0000-000000000000",
        legacyCmisId: 000000000,
        name: "Name, Fake",
        email: "fakeemail@fake.com",
        addressLines: [
        "Fake Address",
        "Fake City, Fake 00000-0000"
        ],
        youthBasedOnAge: false
    },
    {
        personUuid: "00000000-0000-0000-0000-000000000000",
        legacyCmisId: 000000000,
        name: "Name, Fake",
        addressLines: [
        "Fake Address",
        "Fake City, Fake 00000-0000"
        ],
        phone: "0000000000",
        youthBasedOnAge: false
    },
    {
        personUuid: "00000000-0000-0000-0000-000000000000",
        legacyCmisId: 000000000,
        name: "Name, Fake",
        email: "fakeemail@fake.com",
        addressLines: [
        "Fake Address",
        "Fake City, Fake 00000-0000"
        ],
        phone: "0000000000",
        youthBasedOnAge: false
    }
    ]
}
#>