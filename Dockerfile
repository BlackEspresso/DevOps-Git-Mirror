FROM mcr.microsoft.com/windows/servercore:ltsc2019

MAINTAINER Marinus Pfund

RUN powershell -Command Add-WindowsFeature Web-Server

# Install chocolatey
RUN powershell -Command Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
RUN powershell -Command choco feature enable --name=allowGlobalConfirmation

# Install Git
RUN powershell -Command choco install git.install

# clear default website
RUN powershell -NoProfile -Command Remove-Item -Recurse C:\inetpub\wwwroot\*
WORKDIR c:\\workdir

COPY ./start.ps1 start.ps1

CMD powershell start.ps1
