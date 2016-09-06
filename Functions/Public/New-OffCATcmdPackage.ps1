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
    - 0.3.0 - 2016-07-12 - The function logic partially implemented
    
    TODO
    - 
    
    LICENSE  
    Copyright (c) 2016 Wojciech Sciesinski  
    This function is licensed under The MIT License (MIT)  
    Full license text: https://opensource.org/licenses/MIT  
    
  
#>
function New-OffCATcmdPackage {
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
    
    #Download url for OffCAT v. 2.2.
    $OffCATmsiURL = 'https://download.microsoft.com/download/5/F/D/5FD540BF-5AC6-4261-895F-676B38AA8406/OffCAT.msi'
    
    switch ($PsCmdlet.ParameterSetName) {
        'SourceInternet' {
            
            $TempDirectory = (Get-Item -Path env:TEMP).Value
            
            
            [String]$OffCATmsiDestination = "{0}.\OffCAT.msi" -f $TempDirectory
            
            $OffCATmsiFile = Invoke-FileDownload -url $OffCATmsiURL -Destination $TempDirectory -PassThru
            
            # Check if the file was downloaded successfully
            If ($OffCATmsiFile) {
                
                #http://www.powershellmagazine.com/2012/01/12/find-an-unused-drive-letter/
                $FreeDriveLetter = $(for ($j = 67; gdr($d = [char]++$j)2>0) { }$d)
                
                #Create temporary drive letter - will point to current user temp directory
                [String]$CreateTempDriveCommand = "{0}\System32\subst.exe {1}: {2}" -f $WindowsDir, $FreeDriveLetter, $TempDirectory
                
                Invoke-Expression -Command $CreateTempDriveCommand
                
                [String]$DirectoryForExtract = "{0}:\OffCATExtract" -f $FreeDriveLetter
                
                $WindowsDir = (Get-Item -Path env:WINDIR).Value
                
                [String]$MsiFile = "{0}\System32\msiexec.exe /a {1} targetdir={2} /quiet" -f $WindowsDir, $OffCATmsiFile.FullName, $DirectoryForExtract
                
                Invoke-Expression -Command $MsiFile
                
                [String]$Source = "{0}\OffCATExtract\LocalAppDataFolder\Microsoft\OffCAT" -f $DirectoryForExtract
                
                If (-not (Test-Path $Source -PathType Container)) {
                    
                    [String]$MessageText = "Extracting of downloaded OffCAT.msi wasn't successfully. Please verfiy if {0} exist." -f $OffCATmsiFile.FullName
                    
                    Throw $MessageText
                    
                    
                    
                }
                
            }
            
            
            
        }
        'SourceLocal' {
            
            $UserAppDataLocal = (Get-Item env:localappdata).Value
            
            [String]$LocalDefaultOffCATPath = "{0}\Microsoft\OffCAT" -f $UserAppDataLocal
            
            If ([String]::IsNullOrEmpty($SourceLocalPath)) {
                
                If (-not (Test-Path -Path $LocalDefaultOffCATPath -PathType Container)) {
                    
                    [String]$MessageText = "Local installation of OffCAT doesn't exist. Please provide path to foler where OffCAT is installed as a value of the parameter SourceLocalPath."
                    
                    Throw $MessageText
                    
                }
                
                Else {
                    
                    $Source = $LocalDefaultOffCATPath
                    
                }
                
            }
            
        }
        
    }
    
    
    
    If ($PsCmdlet.ParameterSetName -eq 'SourceInternet') {
        
        #Remove temporary drive
        [String]$RemoveTempDriveCommand = "{0}\System32\subst.exe /d {1}:" -f $WindowsDir, $FreeDriveLetter
        
        
    }
    
}



