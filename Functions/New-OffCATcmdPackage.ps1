<#
    .SYNOPSIS
	Function intended to create the OffCATcmd - OffCAT portable - package
    
    .DESCRIPTION
	Function intended to create the OffCATcmd package based on the locally installed OffCAT or downloaded from the internet.
	    
    .PARAMETER Path
	Specifies the path to the location where downloaded file need to be saved. If value contains folder name what not exist the structure will be created.
    
    .PARAMETER SourceInternet
	Select if the OffCATcmd package need to be created based on the package downloaded from the internet.

    .PARAMETER SourceLocal
	Select if OffCATcmd package need to be created based on the locally installed OffCAT
	
	.PARAMETER SourceLocalPath
	The folder where OffCAT is installed locally. By default %AppData\Microsoft\OffCAT\ folder, for current user, will be checked.
	
	.PARAMETER Compress
	Select if created OffCATcmd package need to be compressed

    .EXAMPLE
    PS C:\> New-OffCATcmdPackage -Path C:\OffCATcmd\ -SourceInternet -Compress
    
    .LINK
    https://github.com/it-praktyk/OffCATcmd

    .LINK
    https://www.linkedin.com/in/sciesinskiwojciech
    
    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
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
    
  
#>
function New-OffCATcmdPackage
{
    [CmdletBinding(DefaultParameterSetName = 'SourceLocal')]
    param
    (
        [Parameter(Mandatory = $false)]
        [System.IO.DirectoryInfo]$Path,
        [Parameter(ParameterSetName = 'SourceInternet',
                   Mandatory = $false)]
        [Switch]$SourceInternet,
        [Parameter(ParameterSetName = 'SourceLocal',
                   Mandatory = $false)]
        [switch]$SourceLocal,
        [Parameter(ParameterSetName = 'SourceLocal',
                   Mandatory = $false)]
        [String]$SourceLocalPath,
        [Parameter(Mandatory = $false)]
        [switch]$Compress
        
        
    )
    
    switch ($PsCmdlet.ParameterSetName)
    {
        'SourceInternet' {
            
            (New-Object System.Net.WebClient).DownloadFile($file, $output)
            
            $Success = $Success -and (Test-Path -Path $Output)
            
            
            
            #Invoke-WebRequest https://download.microsoft.com/download/5/F/D/5FD540BF-5AC6-4261-895F-676B38AA8406/OffCAT.msi -OutFile .\OffCAT.msi
            
        }
        'SourceLocal' {
            #TODO: Place script here
            break
        }
    }
    
}


