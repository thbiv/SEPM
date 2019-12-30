Function Get-SEPMVersion {
    <#
    .SYNOPSIS
        Returns the current version of SEPM that is installed. This fuction does not require authorization.
    .DESCRIPTION
        {{Long description}}
    .PARAMETER ComputerName
        The name of the SEPM server
    .PARAMETER Port
        The port for the SEPM API. Defaults to 8446.
    .EXAMPLE
        PS C:\> Get-SEPMVersion -ComputerName 'server1'

        This example will return the cersion of SEPM that is installed on the server named server1.
    .INPUTS
        None
    .OUTPUTS
        PSObject
    .LINK
        https://apidocs.symantec.com/home/saep#_getversion
    #>
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