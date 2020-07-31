---
external help file: SEPM-help.xml
Module Name: SEPM
online version: 
schema: 2.0.0
---

# Get-SEPMClientCountByVersion

## SYNOPSIS
Gets a list of client versions with the corresponding client count.

## SYNTAX

```
Get-SEPMClientCountByVersion [-ComputerName] <String> [-Port <Object>] [-Token] <String> [<CommonParameters>]
```

## DESCRIPTION
{{Long description}}

## EXAMPLES

### EXAMPLE 1
```
Get-SEPMClientCountByVersion -ComputerName 'server1' -Token <a valid token>
```

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### PSObject
## NOTES

## RELATED LINKS
