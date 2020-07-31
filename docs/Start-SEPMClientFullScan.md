---
external help file: SEPM-help.xml
Module Name: SEPM
online version: https://github.com/thbiv/SEPM/blob/master/docs/Get-SEPMClientFullScan.md
schema: 2.0.0
---

# Start-SEPMClientFullScan

## SYNOPSIS
Sends a command to a SEPM management server to start a Full Scan on one or more clients.

## SYNTAX

```
Start-SEPMClientFullScan [-ComputerName] <String> [-Port <Object>] [-ComputerId] <String> [-Token] <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{Long description}}

## EXAMPLES

### EXAMPLE 1
```
PS C:\> Start-SEPMClientActiveScan -ComputerName 'server1' -ComputerId <a valid id> -Token <a valid token>
```

## PARAMETERS

### -ComputerId
The unique id for a client.
You can get this from the Get-SEPMClient command.
Multiple Ids can be used separated by commas (,).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
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
