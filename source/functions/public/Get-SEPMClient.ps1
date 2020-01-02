Function Get-SEPMClient {
    <#
    .SYNOPSIS
        Returns a list of client computers.
    .DESCRIPTION
        {{Long description}}
    .PARAMETER ComputerName
        The name of the SEPM server.
    .PARAMETER Port
        The port for the SEPM API. Defaults to 8446.
    .PARAMETER ClientName
        The computername of a clinet to which to return information on.
    .PARAMETER Token
        A valid token retrieved from the Get-SEPMAccessToken function.
    .EXAMPLE
        PS C:\> Get-SEPMClient -ComputerName 'server1' -Token <valid token>

        This example will return a list of all client computers.
    .EXAMPLE
        PS C:\> Get-SEPMClient -ComputerName 'server1' -ClientName 'client1' -Token <valid token>

        This example will return information on a computer named 'client1'.
    .INPUTS
        None
    .OUTPUTS
        PSObject
    .LINK
        https://apidocs.symantec.com/home/saep#_getcomputers
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True,Position=0)]
        [string]$ComputerName,

        $Port = 8446,

        [Parameter(Mandatory=$False,Position=1)]
        [string]$ClientName,

        [Parameter(Mandatory=$True,Position=2)]
        [string]$Token
    )
    $URL = "https://{0}:{1}/sepm/api/v1/computers" -f $ComputerName,$Port
    $Header = @{
        'Authorization' = "Bearer $Token"
    }
    $Body = @{
        'pageSize' = 1300
    }
    If ($ClientName) {$Body += @{'computerName' = $ClientName}}
    $Response = Invoke-RestMethod -Uri $URL -Headers $Header -Body $Body -Method Get -UseBasicParsing
    $Response.content | ForEach-Object {
        Switch ($($_.onlineStatus)) {
            0 {$OnlineStatus = $False}
            1 {$OnlineStatus = $True}
            Default {$OnlineStatus = 'Unknown'}
        }

        If ($Null -ne $($_.avDefsetVersion)) {
            $CharArray = $($_.avDefsetVersion).ToCharArray()
            $VersionYear = $CharArray[0,1] -join ""
            $VersionMonth = $CharArray[2,3] -join ""
            $VersionDay = $CharArray[4,5] -join ""
            $VersionRevision = $CharArray[6,7,8] -join ""
            $VirusDefVersion = "{0}/{1}/20{2} rev. {3}" -f $VersionMonth,$VersionDay,$VersionYear,$VersionRevision
        } Else { $VirusDefVersion = $Null}

        $Props = @{
            'ComputerName' = $($_.computerName)
            'SEPVersion' = $($_.agentVersion)
            'LogonUserName' = $($_.logonUserName)
            'OperatingSystem' = $($_.operatingSystem)
            'Group' = $($_.group.name)
            'CreationTime' = $(Get-SEPMEpochDate $($_.creationTime))
            'OnlineStatus' = $OnlineStatus
            'LastUpdateTime' = $(Get-SEPMEpochDate $($_.lastUpdateTime))
            'GroupUpdateProvider' = $($_.groupUpdateProvider)
            'VirusDefVersion' = $VirusDefVersion
        }
        Write-Output $(New-Object -TypeName PSObject -Property $Props)
    }
}