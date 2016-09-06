<#
    .SYNOPSIS
	The function intended to run OffCATcmd from a command line
    
    .DESCRIPTION
	By using the Invoke-OffCATcmd function you can create OffCAT report without installing the OffCAT tool on the computer - by invoking OffCATcmd.exe tool.
    
    .PARAMETER OfficeProgram
	Select what program what need to be scanned.
    
	.PARAMETER AcceptEULA
	Select to confirm that you accept the End User License Agreement.
	
    .PARAMETER Path
	Path where scan report need to be stored
	
    .PARAMETER OutlookScanType
	Select type of Outlook scan. Prefered is Full. Use Offline only when you can't run Outlook. 
	
    .PARAMETER OfficeVersion
	Microsoft Office version what need to be scanned - e.g. 2010
    
	.PARAMETER InstallType
	Intallation type - ussually it is 'MSI' for Office distributed as part of Office 365: 'ClickToRun'.
	
    .PARAMETER DownloadUpdates
    Select if scan rules need to be updated from the internet.
	
	.PARAMETER OffCATcmdPath 
	Path to the OffCATcmd.exe file.
	
    .EXAMPLE
    PS C:\> Invoke-OffCATcmd -OfficeProgram 'Outlook' -AcceptEULA -OutlookScanType Full -OfficeVersion 2013
	
	Scan Microsoft Outook 2013 in the full mode. Other parameters values will be assigned from default. 
      
    .LINK
    https://github.com/it-praktyk/OffCATcmd
    
    .LINK
    https://www.linkedin.com/in/sciesinskiwojciech
    
    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
    KEYWORDS: PowerShell, OffCAT
    
    VERSIONS HISTORY
    - 0.1.0 - 2016-06-02 - The first version published on GitHub, draft
    - 0.2.0 - 2016-06-05 - The second draft, still doesn't work
    - 0.3.0 - 2016-07-02 - The third draft, updated validation of available OffCATcmd.exe and .Net
    - 0.3.1 - 2016-07-02 - The project name changed from OffCAT to OffCATcmd
	- 0.3.2 - 2016-07-08 - Help updated, the parameter RunOffCABackground removed
	- 0.3.3 - 2016-07-09 - Help updated
    - 0.3.4 - 2016-07-26 - Part of code to detect installed Office application moved to the external function, code reformated
    
    TODO
    
    - add support for ShouldProcess
    - add support for PassThrou
    
    
    LICENSE
    Copyright (c) 2016 Wojciech Sciesinski
    This function is licensed under The MIT License (MIT)
    Full license text: https://opensource.org/licenses/MIT
    
#>

function Invoke-OffCATcmd {
    
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [Alias("cfg")]
        [ValidateSet("Access", "Excel", "InfoPath", "OneDrive", "OneNote", "Outlook", "PowerPoint", "Publisher", "Visio", "Word")]
        [String]$OfficeProgram,
        [Parameter(Mandatory = $true)]
        [Alias("AE")]
        [switch]$AcceptEULA,
        [Parameter(Mandatory = $false)]
        [Alias("dat", "ReportPath")]
        [String]$Path,
        [Parameter(Mandatory = $false)]
        [Alias("MajorVersion")]
        [ValidateSet("2007", "2010", "2013", "2016")]
        [String]$OfficeVersion,
        [Parameter(Mandatory = $false)]
        [ValidateSet("MSI", "ClickToRun")]
        [String]$InstallType = "MSI",
        [Parameter(Mandatory = $false)]
        [Alias("r")]
        [ValidateSet("Full", "Offline")]
        [String]$OutlookScanType,
        [Parameter(Mandatory = $false)]
        [Alias("ND")]
        [switch]$DownloadUpdates,
        [Parameter(Mandatory = $false)]
        [String]$OffCATcmdPath
        
    )
    
    begin {
        
        #Minimal version of OffCATcmd.exe file version
        [version]$MinSupportedOffCATVersion = "2.2.6012.0527"
        
        #Used parameter validation
        
        If ($OfficeProgram -ne "Outlook" -and $OutlookScanType) {
            
            [String]$MessageText = "The parameter OutlookScanType can be only used with OfficeProgram set to Outlook"
            
            Throw $MessageText
            
        }
        
        If (-not ($AceeptEULA.IsPresent)) {
            
            [String]$MessageText = "To invoke OffCATcmd you need accept EULA. Please use the 'AcceptEULA' switch"
            
            Throw $MessageText
            
        }
        
        
        #Get machinename and username from environment variables		
        [String]$ComputerName = Get-Content env:computername
        
        [String]$USerName = Get-Content env:username
        
        [String]$LocalAppDataFolder = Get-Content -Path env:LOCALAPPDATA
        
        [String]$ProfileDrive = ($LocalAppDataFolder).substring(0, 2)
        
        [String]$DesktopPath = "{0}\{1}\Desktop" -f $ProfileDrive, $(Get-Content -Path env:HOMEPATH)
        
        #Get actual path from the script is running
        $ScriptPath = $PSScriptRoot
        
        $OffCATcmdFileInSubfolder = "{0}\OffCAT\Offcatcmd.exe" -f $ScriptPath
        
        $OffCATcmdFileInLocaAppdata = "{0}\Microsoft\Offcat\Offcat.cmd.exe" -f $LocalAppDataFolder
        
        #Set path for OffCat files - based on provided via parameter		
        If ($OffCATcmdPath) {
            
            [String]$OffCATcmdFile = $OffCATcmdPath
            
        }
        elseif (Test-Path -Path $OffCATcmdFileInSubfolder -Type Leaf) {
            
            [String]$OffCATcmdFile = $OffCATcmdFileInSubfolder
            
        }
        
        elseif (Test-Path -Path $OffCATcmdFileInLocaAppdata -Type Leaf) {
            
            [String]$OffCATcmdFile = $OffCATcmdFileInLocaAppdata
            
        }
        Else {
            
            [String]$MessageText = "The OffCATcmd.exe file doesn't exist in the location {0}" -f $OffCATcmdFile
            
            Throw $MessageText
            
        }
        
        [version]$OffCATVersion = (Get-Item $OffCATcmdFile).versioninfo.productversion
        
        $OffCATVersion = $OffCATVersion.ToString()
        
        If ($OffCATcmdVersionString -lt $MinSupportedOffCATVersion) {
            
            [String]$MessageText = "Invoke-OffCATcmd support only OffCAT version {0} or newer." -f $MinSupportedOffCATVersion.ToString()
            
            Throw $MessageText
            
        }
        
        #Check requrired version of .Net
        #https://support.microsoft.com/en-us/kb/318785
        elseif ($OffCATcmdFile.major -eq 2 -and $OffCATVersion.Minor -eq 2) {
            
            $RequiredDotNetString = "4.5"
            
            $RequiredDotNetRelease = 378389
            
            $RequiredDotNetRegistryKey = 'HKLM:\software\microsoft\NET Framework Setup\NDP\v4\Full\'
            
        }
        
        #Check installed .Net version - required 4.0 for OffCAT 2.1 and 4.5 for OffCAT 2.2
        #Check if the item in registry exists
        If (-not (Test-Path $RequiredDotNetRegistryKey)) {
            
            $DotNetMissed = $true
            
        }
        #Check value for existing registry item 
        elseif ((Get-Item -Path $RequiredDotNetRegistryKey).GetValue('Release') -lt $RequiredDotNetRelease) {
            
            $DotNetMissed = $true
            
        }
        
        If ($DotNetMissed) {
            
            [String]$MessageText = "To run the OffCATcmd.exe version {0}, you first must install one of the following versions of the .NET Framework: {1}." -f $OffCATVersion, $RequiredDotNetString
            
            Throw $MessageText
            
        }
        
        If ($DownloadUpdates.IsPresent) {
            
            $DefinitionsPath = "{0}\{1}" -f $OffCATcmdPath, "en"
            
            Update-OffCATDefinitions -path $OffCATcmdPath
            
        }
        
        $OffCATcmdParams = New-Object System.Collections.ArrayList
        
        $OffCATcmdParams.Add("-cfg $OfficeProgram") | Out-Null
        
        If ($InstallType.ToLower -ceq 'msi') {
            
            $InstallTypeCaseSens = "MSI"
            
        }
        Else {
            
            $InstallTypeCaseSens = "ClickToRun"
            
        }
        
        
        If ($OfficeVersion) {
            
            switch ($OfficeVersion) {
                "2007" {
                    
                    $OffCATcmdParams.Add("-gs MajorVersion 12 InstallType $InstallTypeCaseSens") | Out-Null
                    
                }
                "2010" {
                    
                    $OffCATcmdParams.Add("-gs MajorVersion 14 InstallType $InstallTypeCaseSens") | Out-Null
                    
                }
                "2013" {
                    
                    $OffCATcmdParams.Add("-gs MajorVersion 15 InstallType $InstallTypeCaseSens") | Out-Null
                    
                }
                "2016" {
                    
                    $OffCATcmdParams.Add("-gs MajorVersion 16  InstallType $InstallTypeCaseSens") | Out-Null
                    
                }
                
            }
            
        }
        
        [String]$MessageText = "{0}" -f $OffCATcmdParams
        
        Write-Verbose -Message $MessageText
        
    }
    
    #Invoke-Command -ScriptBlock { }
    
}
 