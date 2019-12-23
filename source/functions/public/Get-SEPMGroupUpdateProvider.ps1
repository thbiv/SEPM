Function Get-SEPMGroupUpdateProvider {
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