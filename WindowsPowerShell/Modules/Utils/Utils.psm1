function AmIAdmin{
    [Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544'
}

function GetDirectorySize{
    [CmdletBinding()]
    Param(
      [Parameter(Mandatory=$true, Position=0)]
      [string]$dirToCountSize,
      [Parameter(Mandatory=$false, Position=1)]
      [string]$isInMB
    )
  
    if ( $isInMB -ne 'MB')
    {
        Get-ChildItem $dirToCountSize -Recurse | Measure-Object -Property Length -Sum
    }
  
    if ( $isInMB -eq 'MB')
    {
        (Get-ChildItem $dirToCountSize -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
    }
  }

# Exported functions
Export-ModuleMember -Function AmIAdmin
Export-ModuleMember -Function GetDirectorySize