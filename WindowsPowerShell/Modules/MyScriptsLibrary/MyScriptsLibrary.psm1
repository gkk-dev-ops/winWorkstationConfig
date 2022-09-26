function Get-Am-I-Admin{
    [Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544'
}

Export-ModuleMember -Function  Get-Am-I-Admin
