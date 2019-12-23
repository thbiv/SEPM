Function Get-SEPMLicense {
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