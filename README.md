# Update-OffCATDefinitions
## SYNOPSIS
Function intended for download the updates of definitions used Office Configuration Analyzer Tool

## SYNTAX
```powershell
Update-OffCATDefinitions [[-Path] <DirectoryInfo>] [<CommonParameters>]
```

## DESCRIPTION
Office Configuration Analyzer Tool (OffCAT) use xml definition files what are periodicaly updated by Microsoft.
For full installation of OffCAT updates are downloaded on start of application. For version run from a command line updates need to be downloaded separately.

## PARAMETERS
### -Path &lt;DirectoryInfo&gt;
Folder when the definition files need to be saved. It should be the subfolder 'en' in OffCAT directory. By default files are saved in the current directory.
```
Required?                    false
Position?                    1
Default value                .
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS


## NOTES
AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net  
KEYWORDS: PowerShell, OffCAT

VERSIONS HISTORY
- 0.1.0 -  2016-05-30 - The first version published on GitHub

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

## EXAMPLES
### EXAMPLE 1
```powershell
PS C:\>Update-OffCATDefinition -Path C:\Users\UserName\AppData\Local\Microsoft\OffCAT\en

0

Download definition ended successufully - code 0 returned.
```


