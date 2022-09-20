# Windows Workstation configuration manual

## Usage

To fully configure PC **run as Administrator**

```Powershell
cd <downloaded_directory>
.\setup\startSetUp.ps1
```

To use just Powershell profile and bundled Moudles. It will remove your current profile and copy those from repo **so be warned!**

```Powershell
cd <downloaded_directory>
.\syncPowershellConfig.ps1
```

## Configuration

On fresh system installation when new `dev` directory is created and `infra` repo cloned, user can setup workstation by going to `workstation` and run `setUp.ps1`.

### Debloat + important software installation

Veryusefull script I use always installing windows manually 😊

```Powershell
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://git.io/JJ8R4'))
```

src: [debloat windows chris titus tech](https://www.thiscodeworks.com/debloat-windows-10-in-2021-chris-titus-tech/60e685d93f7452001417d48d)
