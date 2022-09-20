
# git commands
function ghelp {
    Write-Output "Current git aliases
                 ---------------------
                 gs  -> git status
                 ga  -> git add @args
                 gmm -> git commit -m @args
                 gfx -> git commit --fixup=HEAD
                 gsh -> git show
                 gd  -> git diff
                 gb  -> git branch
                 gll -> git log --oneline -n [5|@args]
                 gck -> git checkout [master|@args
                 gpl -> git pull
                 gsu -> git submodule update"  
}
function gs {
    git status
}
function ga {
    if ($args) {
        git add @args
    }
    else {
        git add .
    }
}
function gmm {
    git commit -m @args
}
function gfx {
    git commit --fixup=HEAD
}
function gsh {
    git show
}
function gd {
    git diff
}
function gb {
    git branch
}
function gll {
    if ($args) {
        git log --oneline -n @args
    }
    else {
        git log --oneline -n 5
    }
}
function gck {
    if ($args) {
        git checkout @args
    }
    else {
        git checkout master
    }
}
function gpl {
    if ($args) {
        git pull @args
    }
    else {
        git pull
    }
}
function gpu {
    if ($args) {
        git push @args
    }
    else {
        git push
    }
}
function gsu {
    git submodule update
}
function gini {
    param (
        [bool]$readme,
        [bool]$r,
        [string]$ignore,
        [string]$i,
        [string]$repo
    )
    if ($r) {
        $readme = $True
    }
    if ($i) {
        $ignore = $i
    }

    if ($repo) {
        mkdir $repo
        Set-Location $repo
    }
    if ($readme) {
        Write-Output 'Please enter README bellow:';
        Write-Output '(CTR+C in newline to finish)';
        Write-Output '----------------------------';
        # wsl cat is used becouse Get-Content does not take control over std stream
        wsl cat > README.md
    }

    switch ($ignore) {
        ('c') {
            Write-Output 'Added C gitignore';
            (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/github/gitignore/main/C.gitignore').content | wsl cat > .gitignore;
            Break
        }
        ('rust') {
            Write-Output 'Added Rust gitignore';
            (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/github/gitignore/main/Rust.gitignore').content | wsl cat > .gitignore;
            Break
        }
        ('py') {
            Write-Output 'Added Python gitignore';
            (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore').content | wsl cat > .gitignore;
            Break
        }
        ('python') {
            Write-Output 'Added Python gitignore';
            (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore').content | wsl cat > .gitignore;
            Break
        }
        ('c++') {
            Write-Output 'Added C++ gitignore';
            (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/github/gitignore/main/C%2B%2B.gitignore').content | wsl cat > .gitignore;
            Break
        }
        ('cpp') {
            Write-Output 'Added C++ gitignore';
            (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/github/gitignore/main/C%2B%2B.gitignore').content | wsl cat > .gitignore;
            Break
        }
        ('go') {
            Write-Output 'Added GO gitignore';
            (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/github/gitignore/main/Go.gitignore').content | wsl cat > .gitignore;
            Break
        }
        ('golang') {
            Write-Output 'Added GO gitignore';
            (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/github/gitignore/main/Go.gitignore').content | wsl cat > .gitignore;
            Break
        }
        Default {
            "[gitignore]: Not supported language";
            Break
        }
    }
    git init;
    git add .
    git commit -m 'init';
}

# Exported functions
Export-ModuleMember -Function ghelp
Export-ModuleMember -Function gs
Export-ModuleMember -Function ga
Export-ModuleMember -Function gmm
Export-ModuleMember -Function gfx
Export-ModuleMember -Function gsh
Export-ModuleMember -Function gd
Export-ModuleMember -Function gb
Export-ModuleMember -Function gll
Export-ModuleMember -Function gck
Export-ModuleMember -Function gpl
Export-ModuleMember -Function gpu
Export-ModuleMember -Function gsu
Export-ModuleMember -Function gini
