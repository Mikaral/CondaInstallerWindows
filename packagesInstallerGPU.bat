@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

set MINICONDAPATH=%USERPROFILE%\miniconda3
set CUDALINK=https://developer.download.nvidia.com/compute/cuda/11.2.2/network_installers/cuda_11.2.2_win10_network.exe
set CUDAEXE=%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%-cudainstall.exe

echo Downloading Cuda Installer...
powershell -Command "(New-Object Net.WebClient).DownloadFile('%CUDALINK%', '%CUDAEXE%')" >nul 2>nul

echo Installing Cuda Tool Kit, Don't close the terminal. This probably will take a while.
%CUDAEXE% -s -n
echo Cuda installtion Complete!
del "%CUDAEXE%"

echo Installing Cudnn...
md C:\tools
move GPU-Installer\cuda C:\tools
echo Instalation of Cudnn was successful!

echo Installing python libraries...
call %MINICONDAPATH%\Scripts\activate base
call conda create --name env_pdi --file GPU-Installer\spec-file.txt python=3.8
call conda env update --name env_pdi --file GPU-Installer\environment.yml
echo Python Libraries installed!

echo adding CUDA to PATH...

set ROOTEXTRA=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.2\extras\CUPTI\lib64
set ROOTINCLUDE=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.2\include
set ROOTCUDNN=C:\tools\cuda\bin
set ROOTBIN=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.2\bin

setx /M PATH "%PATH%;%ROOTCUDNN%;%ROOTINCLUDE%;%ROOTEXTRA%;%ROOTBIN%"

echo Installation complete!

pause