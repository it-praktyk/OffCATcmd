---
external help file: OffCATcmd-help.xml
online version: https://github.com/it-praktyk/OffCATcmd
schema: 2.0.0
---

# Invoke-OffCATcmd
## SYNOPSIS
The function intended to run OffCATcmd from a command line

## SYNTAX

```
Invoke-OffCATcmd [-OfficeProgram] <String> [-AcceptEULA] [[-Path] <String>] [[-OfficeVersion] <String>]
 [[-InstallType] <String>] [[-OutlookScanType] <String>] [-DownloadUpdates] [[-OffCATcmdPath] <String>]
```

## DESCRIPTION
A detailed description of the Invoke-OffCATcmd function.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Invoke-OffCATcmd -OfficeProgram 'Outlook' -AcceptEULA -OutlookScanType Full -OfficeVersion 2013
```

## PARAMETERS

### -OfficeProgram
A description of the OfficeProgram parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases: cfg

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -AcceptEULA
Select to confirm that you accept the End User License Agreement

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: AE

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Path where scan report need to be stored

```yaml
Type: String
Parameter Sets: (All)
Aliases: dat, ReportPath

Required: False
Position: 2
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -OfficeVersion
Microsoft Office version what need to be scanned - e.g.
2010

```yaml
Type: String
Parameter Sets: (All)
Aliases: MajorVersion

Required: False
Position: 3
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstallType
Intallation type

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: MSI
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutlookScanType
Select type of Outlook scan.
Prefered is Full.
Use Offline only when you can't run Outlook.

```yaml
Type: String
Parameter Sets: (All)
Aliases: r

Required: False
Position: 5
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -DownloadUpdates
Select if scan rules need to be updated from the internet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: ND

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -OffCATcmdPath
Path to the OffCATcmd.exe file.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 6
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES
AUTHOR: Wojciech Sciesinski, wojciech\[at\]sciesinski\[dot\]net
KEYWORDS: PowerShell, OffCAT

VERSIONS HISTORY
- 0.1.0 - 2016-06-02 - The first version published on GitHub, draft
- 0.2.0 - 2016-06-05 - The second draft, still doesn't work
- 0.3.0 - 2016-07-02 - The third draft, updated validation of available OffCATcmd.exe and .Net
- 0.3.1 - 2016-07-02 - The project name changed from OffCAT to OffCATcmd
- 0.3.2 - 2016-07-08 - Help updated, the parameter RunOffCABackground removed

TODO
- add support for detecting Office 2016
- add support for detecting multiply versions of Office
- check if detection works with Office ClickToRun
- check if x64 are also detected
- add support for ShouldProcess
- add support for PassThrou


LICENSE
Copyright (c) 2016 Wojciech Sciesinski
This function is licensed under The MIT License (MIT)
Full license text: https://opensource.org/licenses/MIT

## RELATED LINKS

[https://github.com/it-praktyk/OffCATcmd](https://github.com/it-praktyk/OffCATcmd)

[https://www.linkedin.com/in/sciesinskiwojciech](https://www.linkedin.com/in/sciesinskiwojciech)

