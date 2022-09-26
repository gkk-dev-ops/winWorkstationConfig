$cwd = [System.Environment]::CurrentDirectory

if ($args -eq 'push') {
    Write-Output "Push new config to repo"
    Remove-Item -Recurse -Force $cwd\WindowsPowerShell
    mkdir $cwd\WindowsPowerShell
    Copy-Item -Recurse -Force -Path $env:USERPROFILE\Documents\WindowsPowerShell $cwd\WindowsPowerShell
}
elseif ($args -eq 'pull') {
    Write-Output "Pull config onto maschine"
    Remove-Item -Recurse -Force $env:USERPROFILE\Documents\WindowsPowerShell
    mkdir $env:USERPROFILE\Documents\WindowsPowerShell
    Copy-Item -Recurse -Force -Path $cwd\WindowsPowerShell\ $env:USERPROFILE\Documents\
}
else {
    Write-Output "Please enter sync direction
                  Push - push your current PS config into winWorkstationConfig repository
                       : Documents/WindowsPowershell -> winWorkstationConfig.git 
                  Pull - to pull config from winWorkstationConfig repository
                       : winWorkstationConfig.git -> Documents/WindowsPowershell"
}