Function Get-SEPMLicense {
    <#
    .SYNOPSIS
        Returns a list of SEPM licenses..
    .DESCRIPTION
        {{Long description}}
    .PARAMETER ComputerName
        The name of the SEPM server
    .PARAMETER Port
        The port for the SEPM API. Defaults to 8446.
    .PARAMETER Token
        A valid token retrieved from the Get-SEPMAccessToken function.
    .EXAMPLE
        PS C:\> Get-SEPMLicense -ComputerName 'server1' -Token <a valid token>

        This example will return a list of licenses and their details.
    .INPUTS
        None
    .OUTPUTS
        PSObject
    .LINK
        https://apidocs.symantec.com/home/saep#_getalllicenses
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True,Position=0)]
        [string]$ComputerName,

        $Port = 8446,

        [Parameter(Mandatory=$True,Position=1)]
        [string]$Token
    )
    $URL = "https://{0}:{1}/sepm/api/v1/licenses" -f $ComputerName,$Port
    $Header = @{
        'Authorization' = "Bearer $Token"
    }
    $Response = Invoke-RestMethod -Uri $URL -Headers $Header -Method Get -UseBasicParsing
    $Response | ForEach-Object {
        $Props = [ordered]@{
            'SerialNumber' = $($_.serialNumber)
            'ProductName' = $($_.productName)
            'Seats' = $($_.seats)
            'StartDate' = $(Get-SEPMEpochDate $($_.startDate))
            'ExpirationDate' = $(Get-SEPMEpochDate $($_.expireDate))
        }
        Write-Output $(New-Object -TypeName PSObject -Property $Props)
    }
}