Function Get-SEPMCurrentVirusDef {
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