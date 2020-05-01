$accounts = az account list -o table
$vmSizes = @()
foreach ($account in $accounts) {
    if($account -ne 'Name' -and $account -ne '-----------------------------------------------------')
    {
        az account set --subscription $account
        $vmSizes += '-------------------------------------------------------'
        $vmSizes += "Subscription : " + $account
        $vmSizes += '-------------------------------------------------------'   
        $vmSizes += az vm list --query "[].{Name:name, VmSize:hardwareProfile.vmSize}" -o table
             
    }
}
Write-Output $vmSizes