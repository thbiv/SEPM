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
    .PARAMETER Credential
        A PSCredential object used for SEPM Authentication. If this parameter is not used, the user will be asked for a
        username and password.
    .EXAMPLE
        PS C:\> Get-SEPMAccessToken -ComputerName 'server1'

        This example runs the function which will then ask for a username and password.
    .EXAMPLE
        PS C:\> Get-SEPMAccessToken -ComputerName 'server1' -Credential $Cred

        This example runs the function that will use a PSCredential object called Cred to authenticate to the SEPM server.
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

        $Port = 8446,

        [Parameter(Mandatory=$False)]
        [PSCredential]$Credential
    )
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
    If ($Credential) {
        $UserName = $Credential.UserName
        $Password = $Credential.GetNetworkCredential().Password
    } Else {
        $UserName = Read-Host -Prompt 'UserName'
        $Password = Read-Host -Prompt 'Password' -AsSecureString
        $Password = "$([System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($Password)))"
    }
    $Creds = @{
        username = "$UserName"
        password = "$Password"
        domain = ""
    }
    $Body = $Creds | ConvertTo-Json
    $URL = "https://{0}:{1}/sepm/api/v1/identity/authenticate" -f $ComputerName,$Port
    $Response = Invoke-RestMethod -Uri $URL -Method Post -Body $Body -ContentType 'application/json'
    Remove-Variable Body,Creds,UserName,Password,Credential
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