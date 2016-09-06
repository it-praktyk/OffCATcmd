Function Update-OffCATDefinitions {
    
    <#
    .SYNOPSIS
    Function intended for download the updates of definitions used Office Configuration Analyzer Tool
   
    .DESCRIPTION
    Office Configuration Analyzer Tool (OffCAT) use xml definition files what are periodicaly updated by Microsoft.
    For full installation of OffCAT updates are downloaded on start of application. For version run from a command line updates need to be downloaded separately. 
    
    .PARAMETER Path
    Folder when the definition files need to be saved. It should be the subfolder 'en' in OffCAT directory. By default files are saved in the current directory.   
   
    .PARAMETER KeepExistingDefinitions
    
    .PARAMETER PassThru
    
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
    - add support for PassThru
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
        [System.IO.DirectoryInfo]$Path = '.',
        [Parameter(Mandatory = $false)]
        [Switch]$KeepExistingDefinitions,
        [Parameter(Mandatory = $false, ParameterSetName = 'ReturnExitCode')]
        [System.Diagnostics.Switch]$ReturnExitCode,
        [Parameter(Mandatory = $false)]
        [Switch]$PassThru
    )
    
        if (-not (Test-Path -Path $Path -Type Container)) {
            
            [String]$MessageText = "Provide value for the parameter Path is not a correct folder path."
            
            Throw $MessageText
            
        }
        
        #region FilesToDownload
        
        $FilesToDownload = New-Object System.Collections.ArrayList
        
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/offcat.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/access.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/all.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/calcheck.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/common.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/communicator.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/officeupdates.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/access.crashes.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/excel.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/kms.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/infopath.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/excel.crashes.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/lync.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/infopath.crashes.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/onedrive.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/onenote.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/outlook.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/lync.crashes.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/onedrive.crashes.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/onenote.crashes.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/outlook.autodiscover.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/outlook.logging.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/outlook.search.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/outlook.uptodate.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/publisher.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/visio.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/outlook.crashes.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/word.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/offcat.nextversion.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/howto.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/publisher.crashes.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/visio.crashes.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/errorlookup.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/powerpoint.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/word.crashes.config.xml") | Out-Null
        $FilesToDownload.Add("http://www.microsoft.com/office/offcat/2.5/en/powerpoint.crashes.config.xml") | Out-Null
        
        #endregion
    
    $Success = $true
    
    $DefinitionFiles = New-Object System.Collections.ArrayList
    
    process {
        
        foreach ($file in $FilesToDownload) {
            
            $DefinitionFile = New-Object -TypeName PSCustomObject            
            
            [uri]$Url = $file
            
            $FileName = $Url | select-Object -ExpandProperty segments | Select-Object -Last 1
            
            [String]$Output = "{0}\{1}" -f $(Resolve-Path $Path), $FileName
            
            #Prepopulate properties for DefintionFile object
            
            $DefinitionFile | Select-Object -Property filename,VersionBefore,VersionAfter,Updated,KeepedFilePath,NewFilePath
            
            $DefinitionFile.FileName = $file
            
            If ($KeepExistingDefinitions.IsPresent -and (Test-Path -Path $Output)) {
                
                [xml]$DefinitionBefore = Get-Content -Path $Output
                
                [Version]$DefinitionBeforeVersion = $DefinitionBefore.ObjectCollector.Configuration.ConfigVersion
                
                [String]$FileNameForKeep = "{0}.{1}" -f $Output, $DefinitionBeforeVersion.ToString()
                
                $DefinitionFile.VersionBefore = $DefinitionBeforeVersion.ToString()
                
                $DefinitionFile.KeepedFilePath = $FileNameForKeep
                
                Move-Item -Path $Output -Destination $FileNameForKeep
                
            }
            
            [String]$MessageText = "Downloading from {0} , saving to {1}." -f $file, $Output
            
            Write-Verbose $MessageText
            
            [String]$url = $file
            
            (New-Object System.Net.WebClient).DownloadFile($file, $output)
            
            $Success = $Success -and (Test-Path -Path $Output)
            
            If ($Success) {
                
                [xml]$DefinitionAfter = Get-Content -Path $Output
                
                [Version]$DefinitionAfterVersion = $DefinitionAfter.ObjectCollector.Configuration.ConfigVersion
                
                $DefinitionFile.VersionAfter = $NewDefinitionsVersion.ToString()
                
                If ($DefinitionAfterVersion -gt $DefinitionBeforeVersion) {
                    
                    $DefinitionFile.Updated = $true
                    
                }
                Else {
                    
                    $DefinitionFile.Updated = $false
                    
                }
                
                $DefinitionFile.NewFilePath = $Output
                
            }
            
            $DefinitionFiles.Add($DefinitionFile) | Out-Null
            
        }
        
    }
    
    end {
        
        If ($PassThru.IsPresent) {
            
            Return $DefinitionFiles
            
        }
        elseif ($ReturnExitCode.isPresent)  {
            
            
            if ($Success) {
                
                $ExitCode = 0
                
            }
            Else {
                
                $ExitCode = 1
                
            }
            
            Return $ExitCode
        }
        
    }
    
}