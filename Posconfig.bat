@echo off
title POSCONFIGURACION
echo ~~~~~~~~~~~~~~~~~~~~~
echo POSTCONFIGURACION
echo ~~~~~~~~~~~~~~~~~~~~~


	FOR /F "tokens=4 delims= " %%i in ('route print ^| find " 0.0.0.0"') do set localIp=%%i

	echo IP del equipo:%localIP%
	echo Desactivando servicios

	PowerShell Set-ItemProperty -Path  HKLM:\SYSTEM\CurrentControlSet\Services\UsoSvc -Name Start -Value 4 
	PowerShell Set-ItemProperty -Path  HKLM:\SYSTEM\CurrentControlSet\Services\wuauserv -Name Start -Value 4 
	PowerShell Set-ItemProperty -Path  HKLM:\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc -Name Start -Value 4 
	PowerShell Set-ItemProperty -Path  HKLM:\SYSTEM\CurrentControlSet\Services\OGAgent -Name Start -Value 4 

	echo Cambiando nombre del equipo con el proporcionado por el DHCP
	FOR /F "tokens=* USEBACKQ" %%F IN (`powershell.exe -noninteractive -command [System.Net.Dns]::GetHostByAddress^($env:localIp^).HostName`) DO (
    SET Hostname=%%F
)
	echo Hostname actual: %COMPUTERNAME% Hostname por DHCP: %Hostname%
	wmic computersystem where name="%COMPUTERNAME%" call rename name="%Hostname%"
	
	echo Sincronizando hora
	sc config W32Time start=auto
	sc start W32Time

	PowerShell w32tm /resync /force
	start %~dp0\ConfigurameNavegador.bat