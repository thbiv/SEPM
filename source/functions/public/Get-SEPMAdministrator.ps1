Function Get-SEPMAdministrator {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True,Position=0)]
        [string]$ComputerName,

        $Port = 8446,

        [Parameter(Mandatory=$False,Position=1)]
        [string]$UserName,

        [Parameter(Mandatory=$True,Position=2)]
        [string]$Token
    )
    $URL = "https://{0}:{1}/sepm/api/v1/admin-users" -f $ComputerName,$Port
    $Header = @{
        'Authorization' = "Bearer $Token"
    }
    $Response = Invoke-RestMethod -Uri $URL -Headers $Header -Method Get
    $Output = @()
    ForEach ($Item in $Response) {

        Switch ($($Item.adminType)) {
            1 {$AdminType = 'System Administrator'}
            2 {$AdminType = 'Domain Administrator'}
            3 {$AdminType = 'Limited Administrator'}
            Default {$AdminType = 'Unknown'}
        }

        Switch ($($Item.authenticationMethod)) {
            0 {$AuthenticationMethod = 'Symantec Endpoint Protection Manager Authentication'}
            1 {$AuthenticationMethod = 'RSA SecurID Authentication'}
            2 {$AuthenticationMethod = 'Directory Authentication'}
            Default {$AuthenticationMethod = 'Unknown'}
        }

        $Props = [ordered]@{
            'Id' = $Item.id
            'AdminType' = $AdminType
            'UserName' = $($Item.loginName)
            'FullName' = $($Item.fullName)
            'Enabled' = $($Item.enabled)
            'LockStatus' = $($Item.lockStatus)
            'OnlineStatus' = $($Item.onlineStatus)
            'AuthenticationMethod' = $AuthenticationMethod
            'ComanyName' = $($Item.companyName)
            'EmailAddress' = $($Item.email)
            'LastLogonTime' = $(Get-SEPMEpochDate $($Item.lastLoginTime))
            'LastLogonIP' = $($Item.lastLogonIP)
            'FailedLogonCount' = $($Item.failedLoginCount)
            'AttemptThreshold' = $($Item.attemptThreshold)
            'CreationTime' =  $(Get-SEPMEpochDate $($Item.creationTime))
            'LockTimeThreshold' = $($Item.lockTimeThreshold)
            'LockAccount' = $($Item.lockAccount)
            'NotifyAdminOfLockedState' = $($Item.notifyAdminOfLockedState)
        }
        $Obj = New-Object -TypeName PSObject -Property $Props
        $Output += $Obj
    }

    If ($UserName) {
        Write-Output $($Output | Where-Object {$_.UserName -eq $UserName})
    } Else {
        Write-Output $Output
    }
}