[String]$ModuleName = "OffCATcmd"
[String]$ModuleManifestName = "{0}.psd1" -f $ModuleName
[String]$RepositoryLink = "https://github.com/it-praktyk/OffCATcmd"

# 1e7a33f5-d982-482f-822d-dd288512324a - testing use of PLASTER predefined variables.
Import-Module $PSScriptRoot\..\$ModuleManifestName -Force

Describe "Module $ModuleName Manifest Tests" -Tags Manifest {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $PSScriptRoot\..\$ModuleManifestName
        $? | Should Be $true
    }
}

#Section mostly based on the blog post http://www.lazywinadmin.com/2016/05/using-pester-to-test-your-comment-based.html

Describe "Module $ModuleName functions helps" -Tags "Help" {
    
    $FunctionsList = (get-command -Module $ModuleName).Name
    
    ForEach ($Function in $FunctionsList)
    {
        # Retrieve the Help of the function
        $Help = Get-Help -Name $Function -Full
        
        $Notes = ($Help.alertSet.alert.text -split '\n')
		
		$Links = ($Help.relatedlinks.navigationlink.uri -split '\n')
        
        # Parse the function using AST
        $AST = [System.Management.Automation.Language.Parser]::ParseInput((Get-Content function:$Function), [ref]$null, [ref]$null)
		
        Context "$Function - Help"{
            
            It "Synopsis"{ $help.Synopsis | Should not BeNullOrEmpty }
            It "Description"{ $help.Description | Should not BeNullOrEmpty }
            #It "Notes - Author" { $Notes[0].trim() | Should Contain "Wojciech Sciesinski" }
            #It "Notes - Site" { $Notes[1].trim() | Should Be "Lazywinadmin.com" }
            #It "Notes - Twitter" { $Notes[2].trim() | Should Be "@lazywinadm" }
            #It "Notes - Github" { $Notes[3].trim() | Should Be "github.com/lazywinadmin" }
            
			It "Links - repository" { $Links[0].trim() | Should Be $RepositoryLink }
			It "Links - Author's LinkedIn profile" { $Links[1].trim() | Should Be "https://www.linkedin.com/in/sciesinskiwojciech" }
			
            # Get the parameters declared in the Comment Based Help
            $RiskMitigationParameters = 'Whatif', 'Confirm'
            [String[]]$HelpParameters = $help.parameters.parameter | Where-Object name -NotIn $RiskMitigationParameters
			
            # Get the parameters declared in the AST PARAM() Block
            [String[]]$ASTParameters = $AST.ParamBlock.Parameters.Name.variablepath.userpath
			            
            It "Parameter - Compare amount of parameters Help vs AST" {
                $HelpParameters.count -eq $ASTParameters.count | Should Be $true
            }
            
            # Parameter Description
            $help.parameters.parameter | ForEach-Object {
                It "Parameter $($_.Name) - Should contains description"{
                    $_.description | Should not BeNullOrEmpty
                }
            }
            
            # Examples
            it "Example - Count should be greater than 0"{
                $Help.examples.example.code.count | Should BeGreaterthan 0
            }
            
            # Examples - Remarks (small description that comes with the example)
            foreach ($Example in $Help.examples.example)
            {
                it "Example - Remarks on $($Example.Title)"{
                    $Example.remarks | Should not BeNullOrEmpty
                }
            }
        }
    }
}



Describe "Invoke-OffCATcmd" {
    
    It "Using OutlookScanType with other than Outlook OfficeProgram" {
        
        { Invoke-OffCATcmd -OfficeProgram "Access" -OutlookScanType "Full" } | Should Throw
        
    }
    
    
    
}

Describe "New-OffCATcmdPackage" {



}

Describe "Update-OffCATDefinitions" {



}