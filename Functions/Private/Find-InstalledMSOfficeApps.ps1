#Try detect installed Office version
Else {
    
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