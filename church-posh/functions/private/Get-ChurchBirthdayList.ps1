function Get-ChurchBirthdayList {
    param (
        [psobject] $Session
    )
    $params = @{
        Uri         = Get-ChurchConfig -Action "BirthdayList"
        WebSession  = $Session
        Method      = "Get"
        ContentType = "application/json"
    }
    $response = Invoke-ChurchWebRequest @params
    return $response.Content;
}

<#
birthdays: [{
    name: "Name, Really Fake",
    spokenName: "Really Fake Name",
    nameOrder: null,
    birthDate: "20500101",
    birthDateSort: "20500101",
    gender: "MALE",
    genderCode: 1,
    mrn: "00000000000000",
    id: 000000000000,
    email: null,
    householdEmail: "fakeemail@gmail.com",
    phone: "000-000-0000",
    householdPhone: "000-000-0000",
    unitNumber: 0000000,
    unitName: "Fake Ward",
    priesthood: null,
    priesthoodCode: null,
    priesthoodType: null,
    age: 0,
    actualAge: 0,
    actualAgeInMonths: 0,
    genderLabelShort: "M",
    visible: null,
    nonMember: false,
    outOfUnitMember: false,
    address: "0000 W Fake Address Drive<br />Fake City, Fake 00000",
    monthInteger: 0,
    dayInteger: 0,
    birthDayAge: 0,
    displayBirthdate: " 1 Jan",
    sustainedDate: null,
    setApart: false,
    formattedMrn: "000-0000-0000"
}]
#>