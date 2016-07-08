    <#
    .SYNOPSIS
	Function intended to download file from internet
    
    .DESCRIPTION
	Function intended to download file from internet, compatible with PowerShell 2.0.
    
    .PARAMETER Url
	Specifies the Uniform Resource Identifier (URI) of the Internet resource to which the web request is sent.
	Enter a URI. This parameter supports HTTP, HTTPS, FTP, and FILE values.
    
    .PARAMETER Destination
	Specifies the path to the location where downloaded file need to be saved. If value contains folder name what not exist the structure will be created.

    .PARAMETER PassThru
    Returns an object representing the downloaded file. By default, this cmdlet returns numeric exit codes.
	
    .EXAMPLE
    
    PS C:\> Invoke-FileDownload -Url http:\\internetlocaion.pl\file.txt -Destination C:\Downloaded\file2.txt
    
    .LINK
    https://github.com/it-praktyk/OffCATcmd
    
    .LINK
    https://www.linkedin.com/in/sciesinskiwojciech
    
    .NOTES
    AUTHOR: Wojciech Sciesinski, wojciech[at]sciesinski[dot]net
    KEYWORDS: PowerShell, download
    
    VERSIONS HISTORY
    - 0.1.0 - 2016-07-02 - The first version
    - 0.2.0 - 2016-07-03 - The first working version
    - 0.2.1 - 2016-07-03 - Doubled conditional check corrected
	- 0.2.2 - 2016-07-08 - Help updated

    TODO
    - implement download with credentials (?)
    
    LICENSE  
    Copyright (c) 2016 Wojciech Sciesinski  
    This function is licensed under The MIT License (MIT)  
    Full license text: https://opensource.org/licenses/MIT  
    
    #>

function Invoke-FileDownload
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true, ParameterSetName = 'Normal')]
        [uri]$Url,
        [Parameter(Mandatory = $false, ParameterSetName = 'Normal')]
        [String]$Destination,
        [Parameter(Mandatory = $false, ParameterSetName = 'PassThru')]
        [switch]$PassThru
    )
    
    process
    {
        
        Try
        {
            If ([String]::IsNullOrEmpty($Destination))
            {
                
                $CurrentLocation = Get-Location
                
                If ($($CurrentLocation.Provider).Name -ne 'FileSystem')
                {
                    
                    [String]$MessageText = "Download to {0} is not possible. You can use only location supported by the FileSystem PSProvider." -f $CurrentLocation.Path
                    
                    Write-Error -Message $MessageText
                    
                }
                Else
                {
                    
                    $AbsolutePath = $(Get-Location).ProviderPath
                    
                    $FileName = select-Object -InputObject $Url -ExpandProperty segments | Select-Object -Last 1
                    
                }
                
            }
            Else
            {
                
                $AbsolutePath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Destination)
                
                if (Test-Path -Path $AbsolutePath -PathType Container)
                {
                    
                    $FileName = select-Object -InputObject $Url -ExpandProperty segments | Select-Object -Last 1
                    
                }
                Else
                {
                    
                    [System.IO.FileInfo]$AbsolutePath = $AbsolutePath
                    
                    New-Item -Path $AbsolutePath.DirectoryName -ItemType Directory -Force -ErrorAction Continue
                    
                    $FileName = $AbsolutePath.Name
                    
                    $AbsolutePath = $AbsolutePath.DirectoryName
                    
                }
                
            }
            
            [String]$Output = "{0}\{1}" -f $AbsolutePath, $FileName
            
            [String]$MessageText = "Downloading from {0} , saving to {1} ." -f $Url, $Output
            
            Write-Verbose $MessageText
            
            (New-Object System.Net.WebClient).DownloadFile($Url, $output)
            
            If (Test-Path -Path $Output -PathType Leaf)
            {
                
                $Success = $true
                
                [String]$MessageText = "File {0} , downloaded successfully and stored to {1} ." -f $Url, $Output
                
                Write-Verbose -Message $MessageText
                
            }
            
        }
        Catch
        {
            
            Write-Error $Error[0]
            
            $Success = $false
            
        }
        
    }
    
    end
    {
        
        If ($Success -and $PsCmdlet.ParameterSetName -eq 'Normal')
        {
            
            Return 0
            
        }
        elseif ($Success -and $PsCmdlet.ParameterSetName -eq 'PassThru')
        {
            
            $DownloadedFile = Get-Item -Path $Output
            
            Return = $DownloadedFile
            
        }
        Else
        {
            
            Return 1
            
        }
        
    }
}


