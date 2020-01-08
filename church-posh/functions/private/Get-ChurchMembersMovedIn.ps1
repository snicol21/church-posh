function Get-ChurchMembersMovedIn {
    param (
        [psobject] $Session,
        [int] $UnitNumber
    )
    $params = @{
        Uri         = (Get-ChurchConfig -Action "MembersMovedIn") -f $UnitNumber
        WebSession  = $Session
        Method      = "Get"
        ContentType = "application/json"
    }
    $response = Invoke-ChurchWebRequest @params
    return $response.Content;
}

<#
[ {
    name: "Name, Fake",
    spokenName: "Fake Name",
    nameOrder: 000,
    birthDate: "20500101",
    birthDateSort: "20500101",
    gender: "FEMALE",
    genderCode: 2,
    mrn: "00000000000000",
    id: 00000000000,
    email: "fakemail@gmail.com",
    householdEmail: "fakemail@gmail.com",
    phone: "000-000-0000",
    householdPhone: "000-000-0000",
    unitNumber: 000000,
    unitName: "Fake Ward",
    priesthood: null,
    priesthoodCode: null,
    priesthoodType: null,
    age: 0,
    actualAge: 0,
    actualAgeInMonths: 0,
    genderLabelShort: "F",
    visible: null,
    nonMember: false,
    outOfUnitMember: false,
    moveDate: "20500101",
    hohMrn: "0000000000000",
    addressUnknown: false,
    deceased: false,
    priorUnit: "0000000",
    priorUnitName: "Prior Fake Ward",
    moveDateOrder: 0,
    householdPosition: "Head of Household",
    address: "0000 E Fake Drive<br />Fake City, Fake 00000",
    textAddress: "0000 E 0000 N, Fake City, Fake 000000",
    sustainedDate: null,
    setApart: false,
    formattedMrn: "000-0000-0000"
}]
#>