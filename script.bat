@echo Configurador de portátiles de prestamo (Pre - clonacion)
rem # ######################################

rem # FALTA COMANDO PARA POSPONER ACTUALIZACIONES
rem # net user Usuario /add
rem # net Biblioteca %CONTRASEÑA%
rem # FeatureUpdatesDeferralInDays 0x0000016d (365) DeferFeatureUpdates, DeferQualityUpdates,ExcludeWUDrivers,IsDferalIsActive 0x00000001 PolicySources 0x00000002
rem # START /WAIT ejecutable


	
	rem # Comando para posponer actualizaciones de calidad y características 365 días
 	PowerShell Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings -Name DeferQualityUpdatesPeriodInDays -Value 365

	rem # Comando para poner las horas activas de inicio y fin
	PowerShell Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings -Name ActiveHoursEnd -Value 21
	PowerShell Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings -Name ActiveHoursStart -Value 7

	rem # Elimina las aplicaciones preinstaladas de Windows 10
	@echo Eliminando aplicaciones preinstaladas ...
	PowerShell -Command "Get-AppxPackage *3DBuilder* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Cortana* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Getstarted* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *WindowsAlarms* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *WindowsCamera* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *bing* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *MicrosoftOfficeHub* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *OneNote* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *people* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *WindowsPhone* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *photos* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *SkypeApp* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *solit* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *WindowsSoundRecorder* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *xbox* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *zune* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *WindowsCalculator* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *WindowsMaps* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Sway* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *CommsPhone* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *ConnectivityStore* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *ContentDeliveryManager* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.WindowsStore* | Remove-AppxPackage"


	rem # Deshabilitar servicios
	@echo Deshabilitando servicios ...
	sc stop DiagTrack
	sc stop diagnosticshub.standardcollector.service
	sc stop dmwappushservice
	rem sc stop dmwappushsvc ::comprobar
	sc stop WMPNetworkSvc
	sc stop WSearch
	rem # Deshabilitamos los servicios
	sc config DiagTrack start= disabled
	sc config diagnosticshub.standardcollector.service start= disabled
	sc config dmwappushservice start= disabled
	rem sc config dmwappusvc start= disabled ::comprobar
	REM sc config RemoteRegistry start= disabled
	REM sc config TrkWks start= disabled
	sc config WMPNetworkSvc start= disabled
	sc config WSearch start= disabled
	
	rem # Deshabilitar servicios de registro
	
set servregistro[0]=BCastDVRUserService*
set servregistro[1]=CaptureService*
set servregistro[2]=CDPSvc
set servregistro[3]=CDPUserSvc*
set servregistro[4]=ConsentUxUserSvc*
set servregistro[5]=DeviceFlowUserSvc*
set servregistro[6]=DevicePickerUserSvc*
set servregistro[7]=MessagingService*
set servregistro[8]=OneSyncSvc*
set servregistro[9]=PimIndexMaintenanceSvc*
set servregistro[10]=PrintWorkflowUserSvc*
set servregistro[11]=UnistoreSvc*
set servregistro[12]=UserDataSvc*
set servregistro[13]=WpnUserService*
set servregistro[14]=Xbox*
set servregistro[15]=AarSvc*
set servregistro[16]=Xbl*

	PowerShell Set-ItemProperty -Path  HKLM:\SYSTEM\CurrentControlSet\Services\AarSvc* -Name Start -Value 4
										BCastDVRUserService*
										CaptureService*
										CDPSvc
										CDPUserSvc*
										ConsentUxUserSvc*
										DeviceFlowUserSvc*
										DevicePickerUserSvc*
										MessagingService*
										OneSyncSvc*
										PimIndexMaintenanceSvc*
										PrintWorkflowUserSvc*
										UnistoreSvc*
										UserDataSvc*
										WpnUserService*
										Xbgm*
	rem # Eliminar telemetría y recolección de datos
	@echo Eliminando telemetría ...
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f
	
	
	@REM Settings -> Privacy -> General -> Let apps use my advertising ID...
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
	REM - SmartScreen Filter for Store Apps: Disable
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f
	REM - Let websites provide locally...
	reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f
	@REM WiFi Sense: HotSpot Sharing: Disable
	reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /f
	@REM WiFi Sense: Shared HotSpot Auto-Connect: Disable
	reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /f
	@REM Change Windows Updates to "Notify to schedule restart"
	reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v UxOption /t REG_DWORD /d 1 /f
	@REM Disable P2P Update downlods outside of local network
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f
	@REM *** Disable Cortana & Telemetry ***
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0
	REM *** Hide the search box from taskbar. You can still search by pressing the Win key and start typing what you're looking for ***
	REM 0 = hide completely, 1 = show only icon, 2 = show long search box
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
	REM *** Disable MRU lists (jump lists) of XAML apps in Start Menu ***
	reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f
	REM *** Set Windows Explorer to start on This PC instead of Quick Access ***
	REM 1 = This PC, 2 = Quick access
	REM reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f