function Verify-Running-As-Admin {
    if (!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
        $Path = "-file " + (Get-Location).Path + "\setUp.ps1";
        Start-Process powershell -verb runas -ArgumentList $Path;
        EXIT
    }
}

function Write-Exit-Info {
    Write-Output ""
    Write-Output ""
    Write-Output ""
    Write-Output "Workstation configured - it should be rebooted now :)"
    Write-Output ""
    Write-Output ""
    Write-Output ""
}

Verify-Running-As-Admin
.\syncPowershellConfig.ps1 pull;
Write-Exit-Info

PAUSE