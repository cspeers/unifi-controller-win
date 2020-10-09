# escape=`
ARG BASE_IMAGE=mcr.microsoft.com/windows/servercore:ltsc2016-amd64
FROM ${BASE_IMAGE}

ARG UNIFI_VERSION
ENV UNIFI_VERSION ${UNIFI_VERSION}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]
RUN md C:\EntryPoint
RUN [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12;iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
RUN choco install -y 7zip
RUN choco install -y jdk8

ADD https://dl.ubnt.com/unifi/${UNIFI_VERSION}/UniFi-installer.exe C:\UniFi-installer.exe
RUN 7z x C:\UniFi-installer.exe -oC:\Unifi\;

RUN Remove-Item C:\UniFi-Installer.exe -Force

VOLUME [ "C:/Unifi/data" ]

EXPOSE 8080/tcp 
EXPOSE 8081/tcp
EXPOSE 8443/tcp
EXPOSE 8843/tcp
EXPOSE 8880/tcp
EXPOSE 3478/tcp
EXPOSE 10001/tcp
EXPOSE 6789/tcp

#RUN Start-Process -FilePath java.exe -ArgumentList '-Xmx1024M','-jar','C:\Unifi\lib\ace.jar','installsvc' -NoNewWindow -Wait
#COPY Wait-Service.ps1 /EntryPoint/
#CMD C:\EntryPoint\Wait-Service.ps1 -ServiceName UniFi -AllowServiceRestart

COPY start-unifi.ps1 /EntryPoint/
COPY healthcheck.ps1 /EntryPoint/
CMD C:\EntryPoint\start-unifi.ps1

HEALTHCHECK --interval=60s --timeout=90s --start-period=120s --retries=3 CMD powershell -File .\EntryPoint\healthcheck.ps1