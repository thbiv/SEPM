Function Get-SEPMGroup {
    <#
    .SYNOPSIS
        Returns a list of SEPM Groups
    .DESCRIPTION
        {{Long description}}

    .PARAMETER ComputerName
        The name of the SEPM server
    .PARAMETER Port
        The port for the SEPM API. Defaults to 8446.
    .PARAMETER Token
        A valid token retrieved from the Get-SEPMAccessToken function.
    .EXAMPLE
        PS C:\> Get-SEPMGroup -ComputerName 'server1' -Token <a valid token>

        This example will return a list of all groups from the SEPM server.
    .INPUTS
        None
    .OUTPUTS
        PSObject
    .LINK
        https://apidocs.symantec.com/home/saep#_getgroups
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True,Position=0)]
        [string]$ComputerName,

        $Port = 8446,

        [Parameter(Mandatory=$True,Position=2)]
        [string]$Token
    )
    $URL = "https://{0}:{1}/sepm/api/v1/groups" -f $ComputerName,$Port
    $Header = @{
        'Authorization' = "Bearer $Token"
    }
    $Body = @{
        'pageSize' = 100
    }
    $Response = Invoke-RestMethod -Uri $URL -Headers $Header -Body $Body -Method Get -UseBasicParsing
    $Response.content | Select-Object -First 1 | ForEach-Object {
        $Props = [ordered]@{
            'ID' = $($_.id)
            'Name' = $($_.name)
            'Description' = $($_.description)
            'FullPathName' = $($_.fullPathName)
            'ClientCount' = $($_.numberOfPhysicalComputers)
            'CreatedBy' = $($_.createdBy)
            'CreatedDate' = $(Get-SEPMEpochDate $($_.created))
            'LastModifiedDate' = $(Get-SEPMEpochDate $($_.lastModified))
            'PolicySerialNumber' = $($_.policySerialNumber)
            'PolicyDate' = $(Get-SEPMEpochDate $($_.policyDate))
            'Domain' = $($_.domain.name)
            'PolicyInheritanceEnabled' = $($_.policyInheritanceEnabled)
        }
        Write-Output $(New-Object -TypeName PSObject -Property $Props)
    }
}