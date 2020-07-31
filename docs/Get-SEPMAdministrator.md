---
external help file: SEPM-help.xml
Module Name: SEPM
online version: https://github.com/thbiv/SEPM/blob/master/docs/Get-SEPMAdministrator.md
schema: 2.0.0
---

# Get-SEPMAdministrator

## SYNOPSIS
Returns SEPM administrators along with information about those accounts.

## SYNTAX

```
Get-SEPMAdministrator [-ComputerName] <String> [-Port <Object>] [[-UserName] <String>] [-Token] <String>
 [<CommonParameters>]
```

## DESCRIPTION
{{Long description}}

## EXAMPLES

### EXAMPLE 1
```
Get-SEPMAdministrator -ComputerName 'server1' -Token <valid token>
```

This example will return a list of all administrators.

### EXAMPLE 2
```
Get-SEPMAdministrator -ComputerName 'server1'  -Username admin -Token <valid token>
```

This example will return information on just the administrator account named 'admin'.

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

### -Token
A valid token retrieved from the Get-SEPMAccessToken function.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName
A Username of an administrator for which to return information on.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
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

[https://apidocs.symantec.com/home/saep#_getalladminuserdetails](https://apidocs.symantec.com/home/saep#_getalladminuserdetails)

