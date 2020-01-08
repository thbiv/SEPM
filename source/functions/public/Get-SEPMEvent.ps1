<#
.SYNOPSIS
    Gets a list of unacknowledged events on a SEPM server.
.DESCRIPTION
    {{Long description}}
.PARAMETER ComputerName
    The name of the SEPM server
.PARAMETER Port
    The port for the SEPM API. Defaults to 8446.
.PARAMETER Token
    A valid token retrieved from the Get-SEPMAccessToken function.
.EXAMPLE
    PS C:\> Get-SEPMEvent -ComputerName 'server1' -Token <a valid token>
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

$URL = "https://{0}:{1}/sepm/api/v1/events/critical" -f $ServerName,$Port
$Header = @{
    'Authorization' = "Bearer $Token"
}
$Response = Invoke-RestMethod -Uri $URL -Headers $Header -Method Get -UseBasicParsing

ForEach ($Item in $($Response.criticalEventsInfoList)) {
    Switch ($($Item.acknowledged)) {
        0 {$Acknowledged = $False}
        1 {$Acknowledged = $True}
        Default {$Acknowledged = 'Unknown'}
    }
    $Props = [ordered]@{
        'EventId' = $($Item.eventId)
        'EventDateTime' = [datetime]$($Item.eventDateTime)
        'Subject' = $($Item.subject)
        'Acknowledged' = $Acknowledged
        'Message' = $($Item.message)
    }
    Write-Output $(New-Object -TypeName PSObject -Property $Props)
}