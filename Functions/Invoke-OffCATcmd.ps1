
function Invoke-OffCATcmd
{
    
    <#
    .SYNOPSIS
        The function intended to run OffCATcmd from a command line
    
    .DESCRIPTION
        A detailed description of the Invoke-OffCATcmd function.
    
    .PARAMETER OfficeProgram
        A description of the OfficeProgram parameter.
    
    .PARAMETER OfficeVersion
    
    .PARAMETER Path
    
    .PARAMETER InstallType
    
    .PARAMETER OutlookScanType
    
    .PARAMETER DownloadUpdates
    
    .PARAMETER AcceptEULA
    
    .PARAMETER RunOffCABackground
    
    .EXAMPLE
    PS C:\> Invoke-OffCATcmd -OfficeProgram 'Value1'
      
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
    
    #>
    
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [Alias("cfg")]
        [ValidateSet("Access", "Excel", "InfoPath", "OneDrive", "OneNote", "Outlook", "PowerPoint", "Publisher", "Visio", "Word")]
        [String]$OfficeProgram,
        [Parameter(Mandatory = $true)]
        [Alias("AE")]
        [switch]$AceeptEULA,
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
        [Alias("NoRTS")]
        [switch]$RunOffCABackground,
        [Parameter(Mandatory = $false)]
        [String]$OffCATcmdPath
        
    )
    
    begin
    {
        
        #Minimal version of OffCATcmd.exe file version
        [version]$MinSupportedOffCATVersion = "2.2.6012.0527"
        
        #Used parameter validation
        
        If ($OfficeProgram -ne "Outlook" -and $OutlookScanType)
        {
            
            [String]$MessageText = "The parameter OutlookScanType can be only used with OfficeProgram set to Outlook"
            
            Throw $MessageText
            
        }
        
        If (-not ($AceeptEULA.IsPresent))
        {
            
            [String]$MessageText = "To invoke OffCATcmd you need accept EULA. Please use the 'AcceptEULA' switch"
            
            Throw $MessageText
            
        }
        
        #Get actual path from the script is running
        $ScriptPath = $PSScriptRoot
        
        If ([String]::IsNullOrEmpty($OffCATcmdPath))
        {
            
            #Set default path for OffCat files			
            [String]$OffCATcmdFile = "{0}\OffCAT\Offcatcmd.exe" -f $ScriptPath
            
            
        }
        Else
        {
            #Set path for OffCat files - based on provided via parameter		
            [String]$OffCATcmdFile = $OffCATcmdPath
            
        }
        
        
        #Check if OffCATcmd.exe exist
        If (-not (Test-Path -Path $OffCATcmdPath -PathType 'Leaf'))
        {
            
            [String]$MessageText = "The OffCATcmd.exe file doesn't exist in the location {0}" -f $OffCATcmdFile
            
            Throw $MessageText
            
        }
        Else
        {
            
            [version]$OffCATVersion = (Get-Item E:\OffCAT\OffCAT\OffCAT\OffCATcmd.exe).versioninfo.productversion
            
            $OffCATcmdVersionString = $OffCATcmdFile.ToString()
            
            If ($OffCATcmdFile -lt $MinSupportOffCATVersion)
            {
                
                [String]$MessageText = "Invoke-OffCATcmd support only OffCAT version {0} or newer." -f $MinSupportedOffCATVersion.ToString()
                
                Throw $MessageText
                
            }
            #Check requrired version of .Net
            #https://support.microsoft.com/en-us/kb/318785
            elseif ($OffCATcmdFile.major -eq 2 -and $OffCATVersion.Minor -eq 2)
            {
                
                $RequiredDotNetString = "4.5"
                
                $RequiredDotNetRelease = 378389
                
                $RequiredDotNetRegistryKey = 'HKLM:\software\microsoft\NET Framework Setup\NDP\v4\Full\'
                
            }
            
        }
        
        
        #Check installed .Net version - required 4.0 for OffCAT 2.1 and 4.5 for OffCAT 2.2
        If (-not (Test-Path $RequiredDotNetRegistryKey))
        {
            
            $DotNetMissed = $true
            
        }
        elseif ((Get-Item -Path $RequiredDotNetRegistryKey).GetValue('Release') -lt $RequiredDotNetRelease)
        {
            
            $DotNetMissed = $true
            
        }
        
        If ($DotNetMissed)
        {
            
            [String]$MessageText = "To run the OffCATcmd.exe version {0}, you first must install one of the following versions of the .NET Framework: {1}." -f $OffCATVersion, $RequiredDotNetString
            
            Throw $MessageText
            
            
        }
        
        #Get machinename and username from environment variables		
        [String]$ComputerName = Get-Content env:computername
        
        #Check version of installed Windows
        [Bool]$WindowsIsX64 = if ([System.IntPtr]::Size -eq 4) { $false }
        else { $true }
        
        
        [String]$USerName = Get-Content env:username
        
        
        [String]$ProfileDrive = (Get-Content -Path env:APPDATA).substring(0, 2)
        
        [String]$DesktopPath = "{0}\{1}\Desktop" -f $ProfileDrive, $(Get-Content -Path env:HOMEPATH)
        
        $OffCATcmdParams = New-Object System.Collections.ArrayList
        
        $OffCATcmdParams.Add("-cfg $OfficeProgram") | Out-Null
        
        If ($InstallType.ToLower -ceq 'msi')
        {
            
            $InstallTypeCasSens = "MSI"
            
        }
        Else
        {
            
            $InstallTypeCasSens = "ClickToRun"
            
        }
        
        
        If ($OfficeVersion)
        {
            
            switch ($OfficeVersion)
            {
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
        
        #Try detect installed Office version
        Else
        {
            
            #http://windowsitpro.com/microsoft-office/determining-if-office-installation-click-run-or-not
            #HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{90150000-008C-0000-0000-0000000FF1CE}
            
            #Check Office version
            #Check if version 2013 is installed
            if (test-path HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Office15.PROPLUS)
            {
                
                $OffCATcmdParams.Add("-gs MajorVersion 15 InstallType $InstallTypeCaseSens") | Out-Null
                
            }
            #Check if version 2010 is installed
            elseif (test-path HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Office14.PROPLUS)
            {
                
                $OffCATcmdParams.Add("-gs MajorVersion 14 InstallType $InstallTypeCaseSens") | Out-Null
                
            }
            #Check if version 2007 is installed
            elseif (test-path HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Office12.PROPLUS)
            {
                
                $OffCATcmdParams.Add("-gs MajorVersion InstallType $InstallTypeCaseSens 12") | Out-Null
                
            }
            else
            {
                
                [String]$MessageText = "Computer {0} have no Office 2007\2010\2013\2016 installed" -f $ComputerName
                
                Write-Error $MessageText -ErrorAction Stop
                
            }
        }
        
        Write-Output -InputObject $OffCATcmdParams
        
        
        
        #break
        
        
    }
    
    
}
 