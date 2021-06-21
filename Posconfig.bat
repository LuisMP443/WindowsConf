@echo off
title POSCONFIGURACION
echo ~~~~~~~~~~~~~~~~~~~~~
echo POSTCONFIGURACION
echo ~~~~~~~~~~~~~~~~~~~~~
	for /f "delims== tokens=1,2" %%G in (%~dp0/config.txt) do set %%G=%%H


	echo Sincronizando hora
	sc config W32Time start=auto
	sc start W32Time
	PowerShell Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers -Name 0 -Value %serverhora%
	PowerShell Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\services\W32Time\Parameters -Name "NtpServer" -Value %serverhora%
	PowerShell w32tm /resync /force

	FOR /F "tokens=4 delims= " %%i in ('route print ^| find " 0.0.0.0"') do set localIp=%%i

	echo IP del equipo:%localIP%
	echo Desactivando servicios

	PowerShell Set-ItemProperty -Path  HKLM:\SYSTEM\CurrentControlSet\Services\UsoSvc -Name Start -Value 4 
	PowerShell Set-ItemProperty -Path  HKLM:\SYSTEM\CurrentControlSet\Services\wuauserv -Name Start -Value 4 
	PowerShell Set-ItemProperty -Path  HKLM:\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc -Name Start -Value 4 
	PowerShell Set-ItemProperty -Path  HKLM:\SYSTEM\CurrentControlSet\Services\OGAgent -Name Start -Value 4 

	rem # echo Cambiando nombre del equipo con el proporcionado por el DHCP
	rem # FOR /F "tokens=* USEBACKQ" %%F IN (`powershell.exe -noninteractive -command [System.Net.Dns]::GetHostByAddress^($env:localIp^).HostName`) DO (
	rem #  SET Hostname=%%F
	rem #	)
	rem # echo Hostname actual: %COMPUTERNAME% Hostname por DHCP: %Hostname%
	rem # wmic computersystem where name="%COMPUTERNAME%" call rename name="%Hostname%"
	
	set /p Hostname=Indique el nombre del equipo: 
	echo Nombre actual: %COMPUTERNAME% Hostname tras reinicio: %Hostname%
	wmic computersystem where name="%COMPUTERNAME%" call rename name="%Hostname%"

	echo Preparando RDPWrap
	if not exist "%ProgramFiles%\RDP Wrapper" mkdir "%ProgramFiles%\RDP Wrapper"
	xcopy "%~dp0\..\RDPWrap\*" "%ProgramFiles%\RDP Wrapper" /s /y
	"%ProgramFiles%\RDP Wrapper\helper\autoupdate__enable_autorun_on_startup.bat"
	PowerShell Add-MpPreference -ExclusionPath '%ProgramFiles%\RDP Wrapper'

	echo "Activando Windows y Office"
	net start "Conexiones de red"
	net start "Cliente dhcp"
	cscript %windir%\system32\slmgr.vbs /upk
	cscript %windir%\system32\slmgr.vbs /ipk %clavewindows%
	cscript %windir%\system32\slmgr.vbs /skms %serverwindows%
	cscript %windir%\system32\slmgr.vbs /ato

	start cscript.exe "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /sethst:%serveroffice%
	start cscript.exe "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /act

	
	start "%~dp0\ConfigurameNavegador.bat"