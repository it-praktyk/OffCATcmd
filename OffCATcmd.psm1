	#Dot source all functions 

    Get-ChildItem -Path $PSScriptRoot\Functions\*.ps1 |
    ForEach-Object {
        . $_.FullName
    }