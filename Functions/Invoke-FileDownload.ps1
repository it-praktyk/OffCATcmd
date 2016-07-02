    <#
    .SYNOPSIS
        Function intended to download file from internet
    
    .DESCRIPTION
        A detailed description of the Invoke-FileDownload function.
    
    .PARAMETER Url
        A description of the Url parameter.
    
    .PARAMETER Destination
        A description of the Destination parameter.
    
    .EXAMPLE
    
    PS C:\> Invoke-FileDownload -Url $value1 -Destination $value2
    
    .LINK
    https://github.com/it-praktyk/OffCAT
    
    .LINK
    https://www.linkedin.com/in/sciesinskiwojciech
    
    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
    KEYWORDS: PowerShell, <SOMETHING>
    
    VERSIONS HISTORY
    - 0.1.0 - 2016-xx-xx
    
    TODO
    
    LICENSE  
    Copyright (c) 2016 Wojciech Sciesinski  
    This function is licensed under The MIT License (MIT)  
    Full license text: https://opensource.org/licenses/MIT  
    
    #>
#>
function Invoke-FileDownload
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [uri]$Url,
        [System.IO.FileInfo]$Destination
    )
    
    #TODO: Place script here
}


