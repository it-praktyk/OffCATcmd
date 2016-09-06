<#

    .SYNOPSIS
    The function intended to find/detect Microsoft Office application installed on the computer

    .LINK
    https://github.com/it-praktyk/OffCATcmd

    .LINK
    https://www.linkedin.com/in/sciesinskiwojciech

    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
    KEYWORDS: PowerShell, OffCAT, Office

    VERSIONS HISTORY
    - 0.1.0 - 2016-07-26 - The first draft

    TODO
    - add support for detecting Office 2016
    - add support for detecting multiply versions of Office
    - check if detection works with Office ClickToRun
    - check if x64 are also detected

    LICENSE
    Copyright (c) 2016 Wojciech Sciesinski
    This function is licensed under The MIT License (MIT)
    Full license text: https://opensource.org/licenses/MIT


#>

Function Find-InstalledMSOfficeApps {


        #Check version of installed Windows
        [Bool]$WindowsIsX64 = if ([System.IntPtr]::Size -eq 4) { $false }
        else { $true }
        

    #Try detect installed Office version


    #http://windowsitpro.com/microsoft-office/determining-if-office-installation-click-run-or-not
    #HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{90150000-008C-0000-0000-0000000FF1CE}

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
