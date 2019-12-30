Function Get-SEPMCurrentVirusDef {
    <#
    .SYNOPSIS
        Returns the date and revision number of the Virus definitions that are available from the SEPM server
        and from Symantec Security Response.
    .DESCRIPTION
        {{Long description}}
    .PARAMETER ComputerName
        The name of the SEPM server.
    .PARAMETER Port
        The port for the SEPM API. Defaults to 8446.
    .PARAMETER Token
        A valid token retrieved from the Get-SEPMAccessToken function.
    .EXAMPLE
        PS C:\> Get-SEPMCurrentVirusDef -ComputerName 'server1' -Token <a valid token>

        This example will return the current virus def version from the SEPM server and from Symantec Security Response.
    .INPUTS
        None
    .OUTPUTS
        PSObject
    .LINK
        https://apidocs.symantec.com/home/saep#_getavdeflatestinfo
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True,Position=0)]
        [string]$ComputerName,

        $Port = 8446,

        [Parameter(Mandatory=$True,Position=1)]
        [string]$Token
    )
    $URL = "https://{0}:{1}/sepm/api/v1/content/avdef/latest" -f $ComputerName,$Port
    $Header = @{
        'Authorization' = "Bearer $Token"
    }
    $Response = Invoke-RestMethod -Uri $URL -Headers $Header -Method Get -UseBasicParsing
    $Props = [ordered]@{
        'ContentName' = $($Response.contentName)
        'PublishedBySymantec' = $($Response.publishedBySymantec)
        'PublishedBySEPM' = $($Response.publishedBySEPM)
    }
    Write-Output $(New-Object -TypeName PSObject -Property $Props)
}