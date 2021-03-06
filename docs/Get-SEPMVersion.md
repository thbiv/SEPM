---
external help file: SEPM-help.xml
Module Name: SEPM
online version: https://github.com/thbiv/SEPM/blob/master/docs/Get-SEPMVersion.md
schema: 2.0.0
---

# Get-SEPMVersion

## SYNOPSIS
Returns the current version of SEPM that is installed.
This fuction does not require authorization.

## SYNTAX

```
Get-SEPMVersion [-ComputerName] <String[]> [-Port <Object>] [<CommonParameters>]
```

## DESCRIPTION
{{Long description}}

## EXAMPLES

### EXAMPLE 1
```
Get-SEPMVersion -ComputerName 'server1'
```

This example will return the cersion of SEPM that is installed on the server named server1.

## PARAMETERS

### -ComputerName
The name of the SEPM server

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
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

[https://apidocs.symantec.com/home/saep#_getversion](https://apidocs.symantec.com/home/saep#_getversion)

