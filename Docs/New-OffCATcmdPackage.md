---
external help file: OffCATcmd-help.xml
online version: https://github.com/it-praktyk/OffCATcmd
schema: 2.0.0
---

# New-OffCATcmdPackage
## SYNOPSIS
Function intended to create the OffCATcmd - OffCAT portable - package

## SYNTAX

### SourceLocal (Default)
```
New-OffCATcmdPackage [-Path <DirectoryInfo>] [-SourceLocal] [-SourceLocalPath <String>] [-Compress]
```

### SourceInternet
```
New-OffCATcmdPackage [-Path <DirectoryInfo>] [-SourceInternet] [-Compress]
```

## DESCRIPTION
Function intended to create the OffCATcmd package based on the locally installed OffCAT or downloaded from the internet.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
New-OffCATcmdPackage -Path C:\OffCATcmd\ -SourceInternet -Compress
```

## PARAMETERS

### -Path
Specifies the path to the location where downloaded file need to be saved.
If value contains folder name what not exist the structure will be created.

```yaml
Type: DirectoryInfo
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceInternet
Select if the OffCATcmd package need to be created based on the package downloaded from the internet.

```yaml
Type: SwitchParameter
Parameter Sets: SourceInternet
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceLocal
Select if OffCATcmd package need to be created based on the locally installed OffCAT

```yaml
Type: SwitchParameter
Parameter Sets: SourceLocal
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceLocalPath
The folder where OffCAT is installed locally.
By default %AppData\Microsoft\OffCAT\ folder, for current user, will be checked.

```yaml
Type: String
Parameter Sets: SourceLocal
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Compress
Select if created OffCATcmd package need to be compressed

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES
AUTHOR: Wojciech Sciesinski, wojciech\[at\]sciesinski\[dot\]net
KEYWORDS: PowerShell, OffCAT

VERSIONS HISTORY
- 0.1.0 - 2016-07-02 - The first draft
- 0.2.0 - 2016-07-02 - The second draft, the project name changed from OffCAT to OffCATcmd
- 0.2.1 - 2016-07-08 - Help updated

TODO
- 

LICENSE  
Copyright (c) 2016 Wojciech Sciesinski  
This function is licensed under The MIT License (MIT)  
Full license text: https://opensource.org/licenses/MIT

## RELATED LINKS

[https://github.com/it-praktyk/OffCATcmd](https://github.com/it-praktyk/OffCATcmd)

[https://www.linkedin.com/in/sciesinskiwojciech](https://www.linkedin.com/in/sciesinskiwojciech)

