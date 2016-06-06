$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Invoke-OffCATcmd" {
    
    It "Using OutlookScanType with other than Outlook OfficeProgram" {
        
        { Invoke-OffCATcmd -OfficeProgram "Access" -OutlookScanType "Full" } | Should Throw
        
    }
    
    
    
}
