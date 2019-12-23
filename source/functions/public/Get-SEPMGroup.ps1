Function Get-SEPMGroup {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True,Position=0)]
        [string]$ComputerName,

        $Port = 8446,

        [Parameter(Mandatory=$True,Position=2)]
        [string]$Token
    )
    $URL = "https://{0}:{1}/sepm/api/v1/groups" -f $ComputerName,$Port
    $Header = @{
        'Authorization' = "Bearer $Token"
    }
    $Body = @{
        'pageSize' = 100
    }
    $Response = Invoke-RestMethod -Uri $URL -Headers $Header -Body $Body -Method Get -UseBasicParsing
    $Response.content | Select-Object -First 1 | ForEach-Object {
        $Props = [ordered]@{
            'ID' = $($_.id)
            'Name' = $($_.name)
            'Description' = $($_.description)
            'FullPathName' = $($_.fullPathName)
            'ClientCount' = $($_.numberOfPhysicalComputers)
            'CreatedBy' = $($_.createdBy)
            'CreatedDate' = $(Get-SEPMEpochDate $($_.created))
            'LastModifiedDate' = $(Get-SEPMEpochDate $($_.lastModified))
            'PolicySerialNumber' = $($_.policySerialNumber)
            'PolicyDate' = $(Get-SEPMEpochDate $($_.policyDate))
            'Domain' = $($_.domain.name)
            'PolicyInheritanceEnabled' = $($_.policyInheritanceEnabled)
        }
        Write-Output $(New-Object -TypeName PSObject -Property $Props)
    }
}