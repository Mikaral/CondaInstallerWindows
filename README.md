# Miniconda Installer for Windows

A series of sripts that automatically download and installs miniconda with several image processing libraries.
 
## Installation

1. Execute windowsInstaller.bat (as a non-admin)
2. Installing Packages
    1. Execute packagesInstallerGPU.bat (as a non-admin) if you have a NVidia GPU.
    2. Execute packagesInstallerCPU.bat (as a non-admin) if otherwise.
3. We're done!

Now you should have an enviroment called env_pdi with Numpy, Matplotlib, Scikit-image, Open CV, SKlearn and Tensorflow with GPU support.
