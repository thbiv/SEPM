Function Get-SEPMVersion {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True,
                Position=0,
                ValueFromPipeline=$True,
                HelpMessage="Enter one or more computer names separated by commas.")]
        [string[]]$ComputerName,

        [Parameter(Mandatory=$False)]
        $Port = 8446
    )
    Begin{
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    }
    Process {
        ForEach ($Server in $ComputerName) {
            Try {
                $URL = "https://{0}:{1}/sepm/api/v1/version" -f $Server,$Port
                $Result = Invoke-RestMethod -Uri $URL -Method Get -UseBasicParsing -ErrorAction Stop
                $Props = [ordered]@{
                    'ManagementServer' = $Server
                    'Version' = $($Result.Version)
                }
                Write-Output $(New-Object -TypeName PSObject -Property $Props)
            } Catch {
                $ErrorMessage = $_.exception.message
                Write-Warning $ErrorMessage
            }
        }
    }
}