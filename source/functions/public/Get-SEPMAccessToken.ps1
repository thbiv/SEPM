Function Get-SEPMAccessToken {
    [CmdletBinding()]
    Param()
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
    $Response = Invoke-RestMethod -Uri https://sfhouav01:8446/sepm/api/v1/identity/authenticate -Method Post -Body $Body -ContentType 'application/json'
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