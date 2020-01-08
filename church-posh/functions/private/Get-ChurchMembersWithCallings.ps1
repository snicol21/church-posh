function Get-ChurchMembersWithCallings {
    param (
        [psobject] $Session,
        [int] $UnitNumber
    )
    $params = @{
        Uri         = (Get-ChurchConfig -Action "MembersWithCallings") -f $UnitNumber
        WebSession  = $Session
        Method      = "Get"
        ContentType = "application/json"
    }
    $response = Invoke-ChurchWebRequest @params
    return $response.Content;
}

<#
[{
    mrn: "0000000000000",
    unitNumber: 000000,
    unitName: "Fake Ward",
    subOrgTypeId: 0000,
    subOrgId: 0000000,
    customSubOrgName: null,
    parentSubOrgId: null,
    positionTypeId: 0,
    positionId: 00000000,
    standardPosition: true,
    position: "Fake Calling",
    displaySequence: 0,
    activeCalender: "2001-01-01T00:00:00.000+0000",
    activeDate: "2001-01-01T00:00:00.000+0000",
    setApartCalender: null,
    setApartDate: null,
    leaderHomePhone: null,
    leaderWorkPhone: null,
    id: 2118705118,
    memberUnitNumber: 000000,
    memberUnitName: "Fake Ward",
    name: "Name, Fake",
    nameOrder: 1,
    birthDate: "18470101",
    phone: "000-000-0000",
    age: 0,
    outOfUnit: false,
    stake: false,
    district: false,
    organization: "Fake Organization",
    spokenName: "Fake Name",
    gender: "MALE",
    priesthood: "Fake Priesthod",
    email: "fakeemail@gmail.com",
    errors: { },
    sustainedDate: "2050-01-01T00:00:00.000+0000",
    subOrgType: "FAKE_ORG_TYPE",
    custom: false,
    setApart: false
}]
#>