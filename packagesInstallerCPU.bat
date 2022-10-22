@echo off

set MINICONDAPATH=%USERPROFILE%\miniconda3

echo Installing python libraries...
call %MINICONDAPATH%\Scripts\activate base
call conda create --name env_pdi --file NonGPU-Installer\spec-file.txt python=3.8
call conda env update --name env_pdi --file NonGPU-Installer\environment.yml
call %MINICONDAPATH%\Scripts\activate env_pdi
pip install tensorflow

echo Python Libraries installed!

pause