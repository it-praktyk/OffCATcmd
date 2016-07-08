---
external help file: OffCATcmd-help.xml
schema: 2.0.0
online version: https://github.com/it-praktyk/OffCATcmd
---

# Update-OffCATDefinitions
## SYNOPSIS
Function intended for download the updates of definitions used Office Configuration Analyzer Tool
## SYNTAX

```
Update-OffCATDefinitions [[-Path] <DirectoryInfo>] [<CommonParameters>]
```

## DESCRIPTION
Office Configuration Analyzer Tool (OffCAT) use xml definition files what are periodicaly updated by Microsoft.
For full installation of OffCAT updates are downloaded on start of application.
For version run from a command line updates need to be downloaded separately.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Update-OffCATDefinition -Path C:\Users\UserName\AppData\Local\Microsoft\OffCAT\en
```

0

Download definition ended successufully - code 0 returned.
## PARAMETERS

### -Path
Folder when the definition files need to be saved.
It should be the subfolder 'en' in OffCAT directory.
By default files are saved in the current directory.

```yaml
Type: DirectoryInfo
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

## OUTPUTS

## NOTES
AUTHOR: Wojciech Sciesinski, wojciech\[at\]sciesinski\[dot\]net
KEYWORDS: PowerShell, OffCAT

VERSIONS HISTORY
- 0.1.0 - 2016-05-30 - The first version published on GitHub
- 0.1.1 - 2016-06-03 - The script reformatted
- 0.1.2 - 2016-07-02 - The project name changed from OffCAT to OffCATcmd

TODO
- add support for ShouldProcess
- add support for PassThrou
- add support for overwriting
- add support for proxy (?)
- add support for alternative download location

LICENSE
Copyright (c) 2016 Wojciech Sciesinski
This function is licensed under The MIT License (MIT)
Full license text: https://opensource.org/licenses/MIT
## RELATED LINKS

[https://github.com/it-praktyk/OffCATcmd](https://github.com/it-praktyk/OffCATcmd)

[https://www.linkedin.com/in/sciesinskiwojciech](https://www.linkedin.com/in/sciesinskiwojciech)

