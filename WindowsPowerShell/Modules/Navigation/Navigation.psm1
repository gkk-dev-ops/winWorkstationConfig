# to-location -> navigation to different locations
# common user diectories
function to-dev {
    Set-location $DEV_DIR
}
function to-home {
    Set-location $HOME
}
function to-infra {
    Set-location $INFRA_DEV
}

function to-ssh {
    Set-location $SSH_DIR
}

function to-desktop {
    Set-location $DESKTOP_DIR
}

function to-documents {
    Set-location $DOCUMENTS_DIR
}

function to-downloads {
    Set-location $DOWNLOADS_DIR
}

function to-pictures {
    Set-location $PICTURES_DIR
}

function to-tmp {
    Set-location $TMP_DIR
}

function to-virtualbox-vms {
    Set-location $VIRTUALBOX_VMS_DIR
}

# Exported functions
# common user diectories
Export-ModuleMember -Function to-dev
Export-ModuleMember -Function to-ssh
Export-ModuleMember -Function to-desktop
Export-ModuleMember -Function to-documents
Export-ModuleMember -Function to-downloads
Export-ModuleMember -Function to-pictures
Export-ModuleMember -Function to-tmp
Export-ModuleMember -Function to-virtualbox-vms