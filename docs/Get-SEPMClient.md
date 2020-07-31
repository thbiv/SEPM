---
external help file: SEPM-help.xml
Module Name: SEPM
online version: https://github.com/thbiv/SEPM/blob/master/docs/Get-SEPMClient.md
schema: 2.0.0
---

# Get-SEPMClient

## SYNOPSIS
Returns a list of client computers.

## SYNTAX

```
Get-SEPMClient [-ComputerName] <String> [-Port <Object>] [[-ClientName] <String>] [-Token] <String>
 [<CommonParameters>]
```

## DESCRIPTION
{{Long description}}

## EXAMPLES

### EXAMPLE 1
```
Get-SEPMClient -ComputerName 'server1' -Token <valid token>
```

This example will return a list of all client computers.

### EXAMPLE 2
```
Get-SEPMClient -ComputerName 'server1' -ClientName 'client1' -Token <valid token>
```

This example will return information on a computer named 'client1'.

## PARAMETERS

### -ClientName
The computername of a clinet to which to return information on.

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

[https://apidocs.symantec.com/home/saep#_getcomputers](https://apidocs.symantec.com/home/saep#_getcomputers)

