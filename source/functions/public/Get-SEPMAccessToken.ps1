Function Get-SEPMAccessToken {
    <#
    .SYNOPSIS
        Retrieves an Access Token to an On-Premise SEPM server for the purposes of using it's API.
    .DESCRIPTION
        Retrieves an Access Token to an On-Premise SEPM server for the purposes of using it's API by asking for credentials to
        a SEPM administrator. This function will ask for a username and password to pass and will return a UserToken object from
        the SEPM server. The Token property is the property to use when calling any other SEPM function except for Get-Version.
    .PARAMETER ComputerName
        The name of the SEPM server.
    .PARAMETER Port
        The port for the SEPM API. Defaults to 8446.
    .EXAMPLE
        PS C:\> Get-SEPMAccessToken

        This example runs the function which will then ask for a username and password.
    .INPUTS
        None
    .OUTPUTS
        PSObject
    .LINK
        https://apidocs.symantec.com/home/saep#_authenticateuser
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,Position=0)]
        [string]$ComputerName,

        $Port = 8446
    )
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $True }
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
    $UserName = Read-Host -Prompt 'UserName'
    $Password = Read-Host -Prompt 'Password' -AsSecureString
    $Creds = @{
        username = "$UserName"
        password = "$([System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($Password)))"
        domain = ""
    }
    $Body = $Creds | ConvertTo-Json
    $URL = "https://{0}:{1}/sepm/api/v1/identity/authenticate" -f $ComputerName,$Port
    $Response = Invoke-RestMethod -Uri $URL -Method Post -Body $Body -ContentType 'application/json'
    Remove-Variable Body,Creds,UserName,Password
    $Props = [ordered]@{
        'UserName' = $($Response.username)
        'FullName' = $($Response.fullname)
        'Domain' = $($Response.domain)
        'Token' = $($Response.token)
        'TokenExpiration' = $($Response.tokenExpiration)
        'RefreshToken' = $($Response.refreshToken)
        'RefreshTokenExpiration' = $($Response.refreshTokenExpiration)
        'Role' = $($Response.role.title)
        'AdminID' = $($Response.adminid)
        'ClientID' = $($Response.clientId)
        'ClientSecret' = $($Response.clientSecret)
        'DomainID' = $($Response.domainid)
    }
    Write-Output $(New-Object -TypeName PSObject -Property $Props)
}