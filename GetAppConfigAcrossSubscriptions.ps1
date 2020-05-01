$accounts = az account list -o table
foreach ($account in $accounts) {
  az account set --subscription $account
  $webapps = az webapp list | ConvertFrom-Json
  $myList = @()
  $webapps | ForEach-Object { 
    $config = az webapp config show -g $_.resourceGroup -n $_.name -o table    
    $myList += $config[2]
  }  
  Write-Output $myList
}