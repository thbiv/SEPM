Function Get-SEPMGroupUpdateProvider {
    <#
    .SYNOPSIS
        Returns a list of SEPM Group Update Providers
    .DESCRIPTION
        {{Long description}}
    .PARAMETER ComputerName
        The name of the SEPM server.
    .PARAMETER Port
        The port for the SEPM API. Defaults to 8446.
    .PARAMETER Token
        A valid token retrieved from the Get-SEPMAccessToken function.
    .EXAMPLE
        PS C:\> Get-SEPMGroupUpdateProvider -ComputerName 'server1' -Token <a valid token>

        This example returns a full list of Group Update Providers clients.
    .INPUTS
        None
    .OUTPUTS
        PSObject
    .LINK
        https://apidocs.symantec.com/home/saep#_getgupdata
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True,Position=0)]
        [string]$ComputerName,

        $Port = 8446,

        [Parameter(Mandatory=$True,Position=2)]
        [string]$Token
    )
    $URL = "https://{0}:{1}/sepm/api/v1/gup/status" -f $ComputerName,$Port
    $Header = @{
        'Authorization' = "Bearer $Token"
    }
    $Response = Invoke-RestMethod -Uri $URL -Headers $Header -Method Get -UseBasicParsing
    $Response | ForEach-Object {
        $Props = [ordered]@{
            'ComputerName' = $($_.computerName)
            'IPAddress' = $($_.ipAddress)
            'Port' = $($_.port)
            'LastHeartBeat' = $($_.lastHeartBeat)
            'Status' = $($_.status)
            'AgentVersion' = $($_.agentVersion)
            'AVDefs' = $($_.avas)
            'IPSDefs' = $($_.ips)
            'SEPMGroup' = $($_.sepmgroup)
            'OperatingSystem' = $($_.operationSystem)
        }
        Write-Output $(New-Object -TypeName PSObject -Property $Props)
    }
}