<#
Group Policy Object Report v1.0
Created by Connor Walton

    v1.0 [xxJUL2024]- initial release

This script was created to pull all GPOs in an OU and gather the GPO Name, Creation date, Last modified date, and additional delegation info
#>
$targetOU = 'ou=myOU,dc=contoso,dc=com'

Get-GPInheritance -Target $targetOU | ForEach-Object{

    ##Gathers all the information

    $policyName = (Get-GPO -Name $_.displayname)
    $policyName = $policyName.DisplayName
    $policyCDate = $policyName.CreationTime
    $policyMDate = $policyName.ModificationTime
    $policyDelegate = Get-GPPermission -Name $policyName -All

    $policy = @(
        [pscustomobject]@{PolicyName=$PolicyName;CreationDate=$policyCDate;ModifiedDate=$policyMDate;Delegation=$policyDelegate}
    )

    ##Writes to a spreadsheet

    Add-Content -Path C:\temp\test.csv -Value $policy
}