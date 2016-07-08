---
external help file: OffCATcmd-help.xml
online version: https://github.com/it-praktyk/OffCATcmd
schema: 2.0.0
---

# Invoke-FileDownload
## SYNOPSIS
Function intended to download file from internet

## SYNTAX

### Normal
```
Invoke-FileDownload -Url <Uri> [-Destination <String>]
```

### PassThru
```
Invoke-FileDownload [-PassThru]
```

## DESCRIPTION
Function intended to download file from internet, compatible with PowerShell 2.0.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Invoke-FileDownload -Url http:\\internetlocaion.pl\file.txt -Destination C:\Downloaded\file2.txt
```

## PARAMETERS

### -Url
Specifies the Uniform Resource Identifier (URI) of the Internet resource to which the web request is sent.
Enter a URI.
This parameter supports HTTP, HTTPS, FTP, and FILE values.

```yaml
Type: Uri
Parameter Sets: Normal
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Destination
Specifies the path to the location where downloaded file need to be saved.
If value contains folder name what not exist the structure will be created.

```yaml
Type: String
Parameter Sets: Normal
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Returns an object representing the downloaded file.
By default, this cmdlet returns numeric exit codes.

```yaml
Type: SwitchParameter
Parameter Sets: PassThru
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
KEYWORDS: PowerShell, download

VERSIONS HISTORY
- 0.1.0 - 2016-07-02 - The first version
- 0.2.0 - 2016-07-03 - The first working version
- 0.2.1 - 2016-07-03 - Doubled conditional check corrected
- 0.2.2 - 2016-07-08 - Help updated

TODO
- implement download with credentials (?)

LICENSE  
Copyright (c) 2016 Wojciech Sciesinski  
This function is licensed under The MIT License (MIT)  
Full license text: https://opensource.org/licenses/MIT

## RELATED LINKS

[https://github.com/it-praktyk/OffCATcmd](https://github.com/it-praktyk/OffCATcmd)

[https://www.linkedin.com/in/sciesinskiwojciech](https://www.linkedin.com/in/sciesinskiwojciech)

