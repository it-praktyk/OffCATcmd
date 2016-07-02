$ModuleManifestName = 'OffCATcmd.psd1'
# 1e7a33f5-d982-482f-822d-dd288512324a - testing use of PLASTER predefined variables.
Import-Module $PSScriptRoot\..\$ModuleManifestName

Describe 'Module Manifest Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $PSScriptRoot\..\$ModuleManifestName
        $? | Should Be $true
    }
}

