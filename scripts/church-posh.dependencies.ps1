$modules = @(
    @{ModuleName = "Selenium"; RequiredVersion = "2.3.1" }
)

foreach ($module in $modules) {
    Install-Module -Name $module.ModuleName -RequiredVersion $module.RequiredVersion -Force
}
