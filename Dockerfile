FROM mcr.microsoft.com/windows/servercore:ltsc2019

MAINTAINER Marinus Pfund

RUN powershell -Command Add-WindowsFeature Web-Server

# clear default website
RUN powershell -NoProfile -Command Remove-Item -Recurse C:\inetpub\wwwroot\*
WORKDIR c:\\workdir

COPY ./start.ps1 start.ps1

CMD powershell start.ps1
