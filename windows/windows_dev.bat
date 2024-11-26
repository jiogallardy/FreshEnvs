@echo off
echo Setting up your development environment...
echo =============================================

:: Install Windows Terminal (optional, but recommended)
echo Installing Windows Terminal...
winget install --id=Microsoft.WindowsTerminal -e --source=winget

:: Install PowerToys
echo Installing PowerToys...
winget install --id=Microsoft.PowerToys -e --source=winget

:: Install Git
echo Installing Git...
winget install --id=Git.Git -e --source=winget

:: Install Python 3.10
echo Installing Python 3.10...
winget install --id=Python.Python.3.10 -e --source=winget

:: Install Node.js (optional, but useful for web development or VS Code extensions)
echo Installing Node.js...
winget install --id=OpenJS.NodeJS.LTS -e --source=winget

:: Install Docker Desktop
echo Installing Docker Desktop...
winget install --id=Docker.DockerDesktop -e --source=winget

:: Enable WSL2
echo Enabling WSL2...
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

:: Install the WSL2 Kernel Update (required for WSL2 to function)
echo Downloading and Installing WSL2 Kernel Update...
curl -Lo wsl_update.msi https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
msiexec /i wsl_update.msi /quiet /norestart

:: Set WSL2 as the default version
echo Setting WSL2 as the default version...
wsl --set-default-version 2

:: Install Ubuntu for WSL
echo Installing Ubuntu for WSL...
wsl --install -d Ubuntu

:: Install Visual Studio Code (optional, but recommended)
echo Installing Visual Studio Code...
winget install --id=Microsoft.VisualStudioCode -e --source=winget

:: Enable Hyper-V (required for Docker)
echo Enabling Hyper-V...
dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V-All /all /norestart

:: Install PowerShell Core (optional, but useful)
echo Installing PowerShell Core...
winget install --id=Microsoft.Powershell -e --source=winget

:: Install Windows Package Manager CLI (winget) if not installed (for older systems)
echo Ensuring winget is installed...
if not exist "%ProgramFiles%\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\VFS\SystemX86\WindowsApps\Microsoft.DesktopAppInstaller" (
    echo Installing winget...
    powershell -Command "Start-Process ms-windows-store://pdp/?productid=9nblggh4nns1"
)

:: Restart the computer to apply changes
echo Setup complete. A restart is required to apply all changes.
shutdown /r /t 0
