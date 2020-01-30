@echo off
title POSCONFIGURACION
echo "~~~~~~~~~~~~~~~~~~~~~"	
echo "POSTCONFIGURACION"
echo "~~~~~~~~~~~~~~~~~~~~~"
echo "Sincronizando hora"
	PowerShell w32tm /resync /force
echo "Desactivando servicios"

	PowerShell Set-ItemProperty -Path  HKLM:\SYSTEM\CurrentControlSet\Services\UsoSvc -Name Start -Value 4 
	PowerShell Set-ItemProperty -Path  HKLM:\SYSTEM\CurrentControlSet\Services\wuauserv -Name Start -Value 4 
	PowerShell Set-ItemProperty -Path  HKLM:\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc -Name Start -Value 4 
	PowerShell Set-ItemProperty -Path  HKLM:\SYSTEM\CurrentControlSet\Services\OGAgent -Name Start -Value 4 

set /p var=Introduce el nombre de Hostname que quieres introducir en esta máquina: 

	wmic computersystem where name="%COMPUTERNAME%" call rename name="%var%"
	
	start ConfigurameNavegador.bat