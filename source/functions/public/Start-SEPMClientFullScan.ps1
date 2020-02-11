Function Start-SEPMClientFullScan {
    <#
    .SYNOPSIS
        Sends a command to a SEPM management server to start a Full Scan on one or more clients.
    .DESCRIPTION
        {{Long description}}
    .PARAMETER ComputerName
            The name of the SEPM server.
    .PARAMETER Port
        The port for the SEPM API. Defaults to 8446.
    .PARAMETER ComputerId
        The unique id for a client. You can get this from the Get-SEPMClient command. Multiple Ids can be used separated by commas (,).
    .PARAMETER Token
        A valid token retrieved from the Get-SEPMAccessToken function.
    .EXAMPLE
        PS C:\> PS C:\> Start-SEPMClientActiveScan -ComputerName 'server1' -ComputerId <a valid id> -Token <a valid token>
    .INPUTS
        None
    .OUTPUTS
        PSObject
    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory=$True,Position=0)]
        [string]$ComputerName,

        $Port = 8446,

        [Parameter(Mandatory=$True, Position=1)]
        [string]$ComputerId,

        [Parameter(Mandatory=$True,Position=2)]
        [string]$Token
    )

    $URL = "https://{0}:{1}/sepm/api/v1/command-queue/fullscan" -f $ComputerName,$Port
    $Header = @{
        'Authorization' = "Bearer $Token"
    }
    $Body = @{
        'computer_ids' = $ComputerId
    }
    If ($PSCmdlet.ShouldProcess('Send Command to Start Full Scan')) {
        $Response = Invoke-RestMethod -Uri $URL -Headers $Header -Body $Body -Method Post -UseBasicParsing
        $Props = @{
            'CommandId' = $($Response.commandID_computer)
        }
        Write-Output $(New-Object -TypeName PSObject -Property $Props)
    }
}