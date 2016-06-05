
function Invoke-OffCATcmd {
    
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
    https://github.com/it-praktyk/OffCAT
    
    .LINK
    https://www.linkedin.com/in/sciesinskiwojciech
    
    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
    KEYWORDS: PowerShell, OffCAT
    
    VERSIONS HISTORY
    - 0.1.0 - 2016-06-02 - The first version published on GitHub, draft
    - 0.2.0 - 2016-06-05 - The second draft, still doesn't work
    
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
        [Alias("dat","ReportPath")]
        [String]$Path,
    
        [Parameter(Mandatory = $false)]
        [Alias("MajorVersion")]
        [ValidateSet("2007","2010","2013","2016")]
        [String]$OfficeVersion,
    
        [Parameter(Mandatory = $false)]
        [ValidateSet("MSI", "ClickToRun")]
        [String]$InstallType = "MSI",
        
        [Parameter(Mandatory = $false)]
        [Alias("r")]
        [ValidateSet("Full","Offline")]
        [String]$OutlookScanType,
    
        [Parameter(Mandatory = $false)]
        [Alias("ND")]
        [switch]$DownloadUpdates,
                
        [Parameter(Mandatory = $false)]
        [Alias("NoRTS")]
        [switch]$RunOffCABackground
        
    )
    
    begin {
        
        #Used parameter validation
        
        If ($OfficeProgram -ne "Outlook" -and $OutlookScanType) {
            
            [String]$MessageText = "The parameter OutlookScanType can be only used with OfficeProgram set to Outlook"
            
            Throw $MessageText
            
        }
        
        If (-not ($AceeptEULA.IsPresent)) {
            
            [String]$MessageText = "To invoke OffCATcmd you need accept EULA. Please use the 'AcceptEULA' switch"
            
            Throw $MessageText
            
        }
        
        
        #Get actual path from the script is running
        $ScriptPath = $PSScriptRoot
        
        #Set path for OffCat files			
        [String]$OffCATcmdFile = "{0}\OffCAT\Offcatcmd.exe" -f $ScriptPath
        
        #Get machinename and username from environment variables		
        [String]$ComputerName = Get-Content env:computername
        
        [String]$USerName = Get-Content env:username
        
        
        [String]$ProfileDrive = (Get-Content -Path env:APPDATA).substring(0, 2)
        
        [String]$DesktopPath = "{0}\{1}\Desktop" -f $ProfileDrive, $(Get-Content -Path env:HOMEPATH)
        
        $OffCATcmdParams = New-Object System.Collections.ArrayList
        
        $OffCATcmdParams.Add("-cfg $OfficeProgram") | Out-Null
        
        If ($InstallType.ToLower -ceq 'msi') {
            
            $InstallTypeCasSens = "MSI"
            
        }
        Else {
            
            $InstallTypeCasSens = "ClickToRun"
            
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
        
        #Try detect installed Office version
        Else {
            
            #Check Office version
            #Check if version 2013 is installed
            if (test-path HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Office15.PROPLUS) {
                
                $OffCATcmdParams.Add("-gs MajorVersion 15 InstallType $InstallTypeCaseSens") | Out-Null
                
            }
            #Check if version 2010 is installed
            elseif (test-path HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Office14.PROPLUS) {
                
                $OffCATcmdParams.Add("-gs MajorVersion 14 InstallType $InstallTypeCaseSens") | Out-Null
                
            }
            #Check if version 2007 is installed
            elseif (test-path HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Office12.PROPLUS) {
                
                $OffCATcmdParams.Add("-gs MajorVersion InstallType $InstallTypeCaseSens 12") | Out-Null
                
            }
            else {
                
                [String]$MessageText = "Computer {0} have no Office 2007\2010\2013\2016 installed" -f $ComputerName
                
                Write-Error $MessageText -ErrorAction Stop
                
            }
        }
        
        Write-Output -InputObject $OffCATcmdParams
        
        
        
        #break
        
        
    }
    
    
}
