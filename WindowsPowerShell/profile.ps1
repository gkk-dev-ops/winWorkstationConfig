################################################################################
#                           DEFINITION PART                                    #
#            Part where all comands and functions are defined                  #
################################################################################

$WarningPreference = 'SilentlyContinue'

function nvim {
    wsl nvim @args
}

function c {
    cargo @args
}

function rmf {
    Remove-Item -Force -Recurse @args
}

function ex {
    explorer.exe .
}

function vs {
    code .
}

function edit-profile {
    code "$home\Documents\WindowsPowerShell\"
}

function opera {
    Push-Location "$home\AppData\Local\Programs\Opera Crypto developer"
    .\launcher.exe @args
    Pop-Location    
}

# Function that let you change ssh keys currently stored in .ssh
# (id_rsa and id_rsa.pub) with those stored in some .ssh subfolder.
# When directories are orginized like bellow it let's you change keys profile
# in one command:
# change-ssh-keys subfolderName
# e.g.
# C:\USERS\USERNAME\.SSH
# ├───github
# ├───gitlab
# └───homelab 
function change-ssh-keys {
    if ($args) {
        Push-Location $SSH_DIR
        Copy-Item ./$args/* .
        Pop-Location
    }
    else {
        Write-Output "Please enter set of keys to change"
    }
}

function la {
    wsl ls -la
}

################################################################################
#                           EXECUTION PART                                     #
#  Part where all comands are invoked to configure and innitialize powershell  #
################################################################################

# Global variables and environment variables
Set-Variable -Name "SSH_DIR" -Value "$home\.ssh" -Option constant -Scope global
Set-Variable -Name "DEV_DIR" -Value "$home\dev" -Option constant -Scope global
Set-Variable -Name "INFRA_DEV" -Value "$home\dev\infra" -Option constant -Scope global

# import modules:
# backing up, verifing and downloading files from NAS server
import-module -Name BackingUp
# general shell utils
import-module -Name Utils
# navigating in file system and in LAN commands, like: 
# to-*, ssh-to*, send-to-*
import-module -Name Navigation
# git utils and aliases, CLI shortcuts
import-module -Name gitCmds
# provided having glyphs (e.g. https://www.nerdfonts.com/font-downloads) we can
# add terminal icons
# provided we've installed them https://github.com/devblackops/Terminal-Icons
# (just run as Admin: Install-Module -Name Terminal-Icons -Repository PSGallery)
Import-Module -Name Terminal-Icons

# Shows navigable menu of all options when hitting Tab
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Commands aliases
Set-Alias -Name l -Value Get-ChildItem
Set-Alias -Name lsa -Value la
Set-Alias -Name python3 -Value py.exe
Set-Alias -Name python -Value py.exe
## Vim aliases
Set-Alias -Name vi -Value nvim
Set-Alias -Name nvi -Value nvim
Set-Alias -Name neovi -Value nvim
Set-Alias -Name neovim -Value nvim
## VS Code aliases
Set-Alias -Name vsc -Value vs

# Editing path
$env:Path += ';C:\webdriver' # webdriver folder for selenium scripts

$WarningPreference = 'Continue'
