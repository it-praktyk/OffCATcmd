#PSM file structure copied from Format-Pester.psm1 
#Author: Erwan Quélin, https://github.com/equelin
#The MIT License (MIT)
#Copyright (c) 2016 Erwan Quélin and the community
	
#Get public and private function definition files
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Functions\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Functions\Private\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
Foreach($import in @($Public + $Private))
{
    Try
    {
        Write-Verbose "Import file: $($import.fullname)"
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import file $($import.fullname): $_"
    }
}

# Export public functions
Export-ModuleMember -Function $Public.Basename