$cwd = [System.Environment]::CurrentDirectory
Set-Location $cwd 

function Write-Prompt {
    Write-Output "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    Write-Output "                      _          _ __             "
    Write-Output "             ___ ___ | |_  _  _ | '_ \            "
    Write-Output "            (_-// -_)|  _|| || || .__/            "
    Write-Output "            /__/\___| \__| \_._||_|               "
    Write-Output ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    Write-Output "Running basic setup and configuration..."
}

function Initialize-Git {
    Write-Output "Configuring git..."
    $username = Read-Host "Please enter your username..."
    $email = Read-Host "Please enter your email used by git..."
    git config --global user.name $username
    git config --global user.email $email
}

function Initialize-Registry {
    Write-Output "Configuring registry..."
    REG DELETE "HKCU\SOFTWARE\Microsoft\Windows Script Host\Settings" /v Enabled /f # Allow running vbs scripts src: https://www.winhelponline.com/blog/windows-script-host-disabled-machine-contact-administator/
    REG DELETE "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v Enabled /f # Allow running vbs scripts src: https://www.winhelponline.com/blog/windows-script-host-disabled-machine-contact-administator/
    REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f # Prompt for password when elevating privilidges user->admin
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 1 # del + add = edit
    REG DELETE "HKEY_CLASSES_ROOT\ms-msdt" /f # Remote ms office exploit fix src: https://msrc-blog.microsoft.com/2022/05/30/guidance-for-cve-2022-30190-microsoft-support-diagnostic-tool-vulnerability/
    # https://github.com/WazeHell/vulnerable-AD
    # https://www.youtube.com/watch?v=59VqS6wMn6w (AD episodes)
}

function Install-WSL {
    Write-Output "Configuring WSL..."
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux # enable WSL
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart # also needed for wsl2 according to https://docs.microsoft.com/pl-pl/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package
    wsl --install
    Invoke-WebRequest -Uri "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -OutFile "wsl_update_x64.msi"
    Write-Output "==============================================="
    Write-Output "==============================================="
    Write-Output "YOU NEED TO INSTALL WSL2 UPDATE BEFORE CONTINUING"
    Write-Output "It has been downloaded to the directory you've runned script from. (unless you have ARM, then follwo the instructions https://learn.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package)."
    Write-Output "==============================================="
    Write-Output "==============================================="
    Read-Host "PRESS ENTER TO CONTINUE..."
    wsl --install -d Ubuntu
    wsl --set-version Ubuntu 2
    Initialize-Subsystems
}

function Initialize-Subsystems {
    wsl bash wsl/setUp.sh
}

function Install-Third_Parties {
    Write-Output "Installing third parties..."
    Invoke-WebRequest -Uri "https://the.earth.li/~sgtatham/putty/latest/w64/pscp.exe" -OutFile "pscp.exe" # Install pscp
    Move-Item .\pscp.exe C:\Windows\System32\pscp.exe
}

function get-usefull-software-packages() {
    $downloadPath = "$home\Downloads\"
    Invoke-WebRequest -Uri "https://www.7-zip.org/a/7z2200-x64.exe" -OutFile ($downloadPath + "7zip.exe")
    Invoke-WebRequest -Uri "https://vault.bitwarden.com/download/?app=desktop&platform=windows" -OutFile ($downloadPath + "bitwarden.exe")
    Invoke-WebRequest -Uri "https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x86" -OutFile ($downloadPath + "discord.exe")
    Invoke-WebRequest -Uri "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe" -OutFile ($downloadPath + "docker.exe")
    Invoke-WebRequest -Uri "https://www.figma.com/download/desktop/win" -OutFile ($downloadPath + "figma.exe")
    Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/download/v2.37.0.windows.1/Git-2.37.0-64-bit.exe" -OutFile ($downloadPath + "git.exe")
    Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.10.5/python-3.10.5-amd64.exe" -OutFile ($downloadPath + "python.exe")
    Invoke-WebRequest -Uri "https://go.dev/dl/go1.18.3.windows-amd64.msi" -OutFile ($downloadPath + "go.msi")
    Invoke-WebRequest -Uri "https://dl.google.com/drive-file-stream/GoogleDriveSetup.exe" -OutFile ($downloadPath + "googleDrive.exe")
    Invoke-WebRequest -Uri "https://download.instalki.org/programy/Windows/Narzedzia/testowanie_i_diagnostyka/hwi_726.exe" -OutFile ($downloadPath + "hwi.exe")
    Invoke-WebRequest -Uri "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user" -OutFile ($downloadPath + "vsc.exe")
    Invoke-WebRequest -Uri "https://download.mozilla.org/?product=firefox-stub&os=win&lang=en-US&attribution_code=c291cmNlPXd3dy5nb29nbGUuY29tJm1lZGl1bT1yZWZlcnJhbCZjYW1wYWlnbj0obm90IHNldCkmY29udGVudD0obm90IHNldCkmZXhwZXJpbWVudD0obm90IHNldCkmdmFyaWF0aW9uPShub3Qgc2V0KSZ1YT1jaHJvbWUmdmlzaXRfaWQ9KG5vdCBzZXQp&attribution_sig=3466763a646381f4d23891a79de5b2c5da57cff9698bd5c185e938b48ed303e6" -OutFile ($downloadPath + "firefox.exe")
    Invoke-WebRequest -Uri "https://net.geo.opera.com/opera_crypto/developer/windows" -OutFile ($downloadPath + "operaCrypto.exe")
    Invoke-WebRequest -Uri "https://nodejs.org/dist/v16.16.0/node-v16.16.0-x64.msi" -OutFile ($downloadPath + "node.msi")
    Invoke-WebRequest -Uri "https://github.com/obsidianmd/obsidian-releases/releases/download/v0.14.15/Obsidian.0.14.15.exe" -OutFile ($downloadPath + "obsidian.exe")
    Invoke-WebRequest -Uri "https://1.na.dl.wireshark.org/win64/Wireshark-win64-3.6.6.exe" -OutFile ($downloadPath + "wireshark.exe")
    Invoke-WebRequest -Uri "https://pl.download.nvidia.com/Windows/342.01/342.01-desktop-win10-64bit-international.exe" -OutFile ($downloadPath + "nvdia.exe")
    Invoke-WebRequest -Uri "https://openvpn.net/downloads/openvpn-connect-v3-windows.msi" -OutFile ($downloadPath + "openvpn.msi")
    Invoke-WebRequest -Uri "https://github.com/NickeManarin/ScreenToGif/releases/download/2.37/ScreenToGif.2.37.Setup.x64.msi" -OutFile ($downloadPath + "s2g.msi")
    Invoke-WebRequest -Uri "https://protonvpn.com/download/ProtonVPN_win_v2.0.1.exe" -OutFile ($downloadPath + "protonvpn.exe")
    Invoke-WebRequest -Uri "https://downloads.raspberrypi.org/imager/imager_latest.exe" -OutFile ($downloadPath + "raspberry.exe")
    Invoke-WebRequest -Uri "https://github.com/pbatard/rufus/releases/download/v3.19/rufus-3.19.exe" -OutFile ($downloadPath + "rufus.exe")
    Invoke-WebRequest -Uri "https://updates.signal.org/desktop/signal-desktop-win-5.48.0.exe" -OutFile ($downloadPath + "signal.exe")
    Invoke-WebRequest -Uri "https://download.scdn.co/SpotifySetup.exe" -OutFile ($downloadPath + "spotify.exe")
    Invoke-WebRequest -Uri "https://download.sublimetext.com/sublime_text_build_4126_x64_setup.exe" -OutFile ($downloadPath + "sublime.exe")
    Invoke-WebRequest -Uri "https://telegram.org/dl/desktop/win64" -OutFile ($downloadPath + "telegram.exe")
    Invoke-WebRequest -Uri "https://downloads.realvnc.com/download/file/viewer.files/VNC-Viewer-6.22.515-Windows.exe" -OutFile ($downloadPath + "vnc.exe")
    Invoke-WebRequest -Uri "https://zoom.us/client/5.11.1.6602/ZoomInstallerFull.exe?archType=x64" -OutFile ($downloadPath + "zoom.exe")
    Invoke-WebRequest -Uri "https://download.wireguard.com/windows-client/wireguard-installer.exe" -OutFile ($downloadPath + "wg.exe")
}

Write-Prompt
Initialize-Registry
Install-WSL
get-usefull-software-packages
Install-Third_Parties
Initialize-Git
Add-Custom-Aliases

EXIT
