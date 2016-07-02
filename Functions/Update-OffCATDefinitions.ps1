Function Update-OffCATDefinitions {
    
    <#
    .SYNOPSIS
    Function intended for download the updates of definitions used Office Configuration Analyzer Tool
   
    .DESCRIPTION
    Office Configuration Analyzer Tool (OffCAT) use xml definition files what are periodicaly updated by Microsoft.
    For full installation of OffCAT updates are downloaded on start of application. For version run from a command line updates need to be downloaded separately. 
    
    .PARAMETER Path
    Folder when the definition files need to be saved. It should be the subfolder 'en' in OffCAT directory. By default files are saved in the current directory.   
   
    .EXAMPLE
    Update-OffCATDefinition -Path C:\Users\UserName\AppData\Local\Microsoft\OffCAT\en
    0
    
    Download definition ended successufully - code 0 returned.
     
    .LINK
    https://github.com/it-praktyk/OffCATcmd
    
    .LINK
    https://www.linkedin.com/in/sciesinskiwojciech
          
    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
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
    
   
#>
    
    [Cmdletbinding()]
    param (
        
        [parameter (Mandatory = $false)]
        [System.IO.DirectoryInfo]$Path = '.'
        
    )
    
    begin {
        
        if (-not (Test-Path -Path $Path -Type Container)) {
            
            [String]$MessageText = "Provide value for the parameter Path is not a correct folder path."
            
            Throw $MessageText
            
        }
        
        #region FilesToDownload
        
        [array]$FilesToDownload = @()
        
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/offcat.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/access.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/all.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/calcheck.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/common.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/communicator.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/officeupdates.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/access.crashes.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/excel.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/kms.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/infopath.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/excel.crashes.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/lync.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/infopath.crashes.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/onedrive.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/onenote.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/outlook.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/lync.crashes.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/onedrive.crashes.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/onenote.crashes.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/outlook.autodiscover.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/outlook.logging.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/outlook.search.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/outlook.uptodate.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/publisher.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/visio.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/outlook.crashes.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/word.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/offcat.nextversion.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/howto.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/publisher.crashes.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/visio.crashes.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/errorlookup.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/powerpoint.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/word.crashes.config.xml"
        $FilesToDownload += "http://www.microsoft.com/office/offcat/2.5/en/powerpoint.crashes.config.xml"
        
        #endregion
        
        $Success = $true
        
    }
    
    process {
        
        foreach ($file in $FilesToDownload) {
            
            [uri]$Url = $file
            
            $FileName = $Url | select-Object -ExpandProperty segments | Select-Object -Last 1
            
            [String]$Output = "{0}\{1}" -f $(Resolve-Path $Path), $FileName
            
            [String]$MessageText = "Downloading from {0} , saving to {1}" -f $file, $Output
            
            Write-Verbose $MessageText
            
            [String]$url = $file
            
            (New-Object System.Net.WebClient).DownloadFile($file, $output)
            
            $Success = $Success -and (Test-Path -Path $Output)
            
        }
        
    }
    
    end {
        
        if ($Success) {
            
            $ExitCode = 0
            
        }
        Else {
            
            $ExitCode = 1
            
        }
        
        Return $ExitCode
        
    }
}