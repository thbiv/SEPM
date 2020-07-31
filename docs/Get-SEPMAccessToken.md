---
external help file: SEPM-help.xml
Module Name: SEPM
online version: https://github.com/thbiv/SEPM/blob/master/docs/Get-SEPMAccessToken.md
schema: 2.0.0
---

# Get-SEPMAccessToken

## SYNOPSIS
Retrieves an Access Token to an On-Premise SEPM server for the purposes of using it's API.

## SYNTAX

```
Get-SEPMAccessToken [-ComputerName] <String> [-Port <Object>] [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves an Access Token to an On-Premise SEPM server for the purposes of using it's API by asking for credentials to
a SEPM administrator.
This function will ask for a username and password to pass and will return a UserToken object from
the SEPM server.
The Token property is the property to use when calling any other SEPM function except for Get-Version.

## EXAMPLES

### EXAMPLE 1
```
Get-SEPMAccessToken -ComputerName 'server1'
```

This example runs the function which will then ask for a username and password.

### EXAMPLE 2
```
Get-SEPMAccessToken -ComputerName 'server1' -Credential $Cred
```

This example runs the function that will use a PSCredential object called Cred to authenticate to the SEPM server.

## PARAMETERS

### -ComputerName
The name of the SEPM server.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
A PSCredential object used for SEPM Authentication.
If this parameter is not used, the user will be asked for a
username and password.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
The port for the SEPM API.
Defaults to 8446.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 8446
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### PSObject
## NOTES

## RELATED LINKS

[https://apidocs.symantec.com/home/saep#_authenticateuser](https://apidocs.symantec.com/home/saep#_authenticateuser)

