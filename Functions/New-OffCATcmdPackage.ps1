
<#
    .SYNOPSIS
        Function intended to create OffCATcmd - OffCAT portable - package
    
    .DESCRIPTION
        A detailed description of the New-OffCATcmdPackage function.
    
    .PARAMETER Path
        A description of the Path parameter.
    
    .PARAMETER SourceInternet
        A description of the Source parameter.


    .PARAMETER SourceLocal


    .EXAMPLE

        PS C:\> New-OffCATcmdPackage -Path 'Value1' -Source 'Value2'
    
    
    .NOTES
        Additional information about the function.
    
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
    
    TODO
    - 
    
    LICENSE  
    Copyright (c) 2016 Wojciech Sciesinski  
    This function is licensed under The MIT License (MIT)  
    Full license text: https://opensource.org/licenses/MIT  
    
    #>

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
        [String]$LocalSourcePath,
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


