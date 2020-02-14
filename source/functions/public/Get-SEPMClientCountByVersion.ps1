Function Get-SEPMClientCountByVersion {
    <#
    .SYNOPSIS
        Gets a list of client versions with the corresponding client count.
    .DESCRIPTION
        {{Long description}}
    .PARAMETER ComputerName
        The name of the SEPM server.
    .PARAMETER Port
        The port for the SEPM API. Defaults to 8446.
    .PARAMETER Token
        A valid token retrieved from the Get-SEPMAccessToken function.
    .EXAMPLE
        PS C:\> Get-SEPMClientCountByVersion -ComputerName 'server1' -Token <a valid token>
    .INPUTS
        None
    .OUTPUTS
        PSObject
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True,Position=0)]
        [string]$ComputerName,

        $Port = 8446,

        [Parameter(Mandatory=$True,Position=2)]
        [string]$Token
    )

    $URL = "https://{0}:{1}/sepm/api/v1/stats/client/version" -f $ComputerName,$Port,$CommandId
    $Header = @{
        'Authorization' = "Bearer $Token"
    }
    $Response = Invoke-RestMethod -Uri $URL -Headers $Header -Method Get -UseBasicParsing

    ForEach ($Item in $($Response.clientVersionList)) {
        $Props = [ordered]@{
            'Version' = $($Item.version)
            'ClientCount' = $($Item.clientsCount)
            'FormattedVersion' = $($Item.formattedVersion)
        }
        Write-Output $(New-Object -TypeName PSObject -Property $Props)
    }
}