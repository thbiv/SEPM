Function Get-SEPMCommandStatus {
    <#
    .SYNOPSIS
        Gets the status of a command that was sent to the SEPM management server.
    .DESCRIPTION
        {{Long description}}
    .PARAMETER ComputerName
        The name of the SEPM server.
    .PARAMETER Port
        The port for the SEPM API. Defaults to 8446.
    .PARAMETER CommandId
        The unique Id of the command you are requesting the status of.
    .PARAMETER Token
        A valid token retrieved from the Get-SEPMAccessToken function.
    .EXAMPLE
        PS C:\> Get-SEPMCommandStatus -ComputerName 'server1' -CommandId <valid commandid> -Token <a valid token>
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

        [Parameter(Mandatory=$True,Position=1)]
        [string]$CommandId,

        [Parameter(Mandatory=$True,Position=2)]
        [string]$Token
    )

    $URL = "https://{0}:{1}/sepm/api/v1/command-queue/$CommandId" -f $ComputerName,$Port
    $Header = @{
        'Authorization' = "Bearer $Token"
    }
    $Response = Invoke-RestMethod -Uri $URL -Headers $Header -Method Get -UseBasicParsing

    ForEach ($Item in $Response.content) {
        Switch ($($Item.stateId)) {
            0 {$Status = 'Not Received'}
            1 {$Status = 'Received'}
            2 {$Status = 'In Progress'}
            3 {$Status = 'Completed'}
            Default {$Status = $($Item.stateId)}
        }
        $Props = [ordered]@{
            'Id' = $($Item.computerId)
            'ComputerName' = $($Item.computerName)
            'CurrentUser' = $($Item.currentLoginUserName)
            'CommandStatus' = $Status
        }
        Write-Output $(New-Object -TypeName PSObject -Property $Props)
    }
}