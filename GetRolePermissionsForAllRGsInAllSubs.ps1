$accounts = az account list -o table
$roleassignment = @()
foreach ($account in $accounts) {
    if($account -ne 'Name' -and $account -ne '-----------------------------------------------------')
    {
        az account set --subscription $account
        $resourceGroups = @()
        $resourceGroups = az group list --query "sort_by([].{Name:name}, &Name)" -o table
        $roleassignment += '-------------------------------------------------------'
        $roleassignment += "Subscription : " + $account
        $roleassignment += '-------------------------------------------------------'
        foreach ($resourceGroup in $resourceGroups) {       
            if($resourceGroup -ne 'Name' -and $resourceGroup -ne '-----------------------------------------------------')
            {
                $roleassignment += ''
                $roleassignment += $resourceGroup
                $roleassignment += az role assignment list -g $resourceGroup -o table
            }
        }
        $roleassignment += '-------------------------------------------------------'
    }
}
Write-Output $roleassignment