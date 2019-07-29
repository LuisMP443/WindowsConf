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
	set servregistro[17]=WSearch*
	set servregistro[18]=WMPNetworkSvc
	set servregistro[19]=WaaSMedicSvc
	set servregistro[20]=XboxGipSvc
	set servregistro[21]=FDResPub
	set servregistro[22]=wuauserv
	set servregistro[23]=RpcLocator
	set servregistro[24]=EFS
	set servregistro[25]=TermService
	set servregistro[26]=WerSvc
	set servregistro[27]=MSiSCSI
	set servregistro[28]=WMPNetworkSvc
	set servregistro[29]=ALG
	set servregistro[30]=TabletInputService
	set servregistro[31]=hidserv
	set servregistro[32]=bthserv
	set servregistro[33]=BDESVC
	set servregistro[34]=WbioSrvc
	set servregistro[35]=RemoteRegistry
	set servregistro[36]=UmRdpService
	set servregistro[37]=WPCSvc
	set servregistro[38]=Netlogon
	set servregistro[39]=Fax
	set servregistro[40]=SessionEnv
	set servregistro[41]=SNMPTRAP
	set servregistro[42]=TrkWks
	set servregistro[43]=SensrSvc
	set servregistro[44]=PeerDistSvc
	set servregistro[45]=CscService
	set servregistro[46]=iphlpsvc
	set servregistro[47]=WinRM




	set "x=0"

	:SymLoop
	if not defined servregistro[%x%] goto :endLoop
	call set VAL=%%servregistro[%x%]%%
	echo %VAL%
	PowerShell Set-ItemProperty -Path  HKLM:\SYSTEM\CurrentControlSet\Services\%VAL% -Name Start -Value 4 
	SET /a "x+=1"
	GOTO :SymLoop
	:endLoop
										
	rem # Eliminar telemetría y recolección de datos
	@echo Eliminando telemetría ...
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
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 2 /f
	REM *** Disable MRU lists (jump lists) of XAML apps in Start Menu ***
	reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f
	REM *** Set Windows Explorer to start on This PC instead of Quick Access ***
	REM 1 = This PC, 2 = Quick access
	reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f
	
	schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /disable
	schtasks /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /disable
	schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
	schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable
	schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /disable
	schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /disable
	schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable
	schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /disable
	schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
	schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable
	schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable
	schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
	schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable
	schtasks /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /disable
	schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /disable
	schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /disable
	schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /disable
	schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable
	schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /disable
	schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /disable
	schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyUpload" /disable
	schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable
	schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /disable
	schtasks /Change /TN "Microsoft\Windows\License Manager\TempSignedLicenseExchange" /disable
	schtasks /Change /TN "Microsoft\Windows\Clip\License Validation" /disable
	schtasks /Change /TN "\Microsoft\Windows\ApplicationData\DsSvcCleanup" /disable
	schtasks /Change /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable
	schtasks /Change /TN "\Microsoft\Windows\PushToInstall\LoginCheck" /disable
	schtasks /Change /TN "\Microsoft\Windows\PushToInstall\Registration" /disable
	schtasks /Change /TN "\Microsoft\Windows\Shell\FamilySafetyMonitor" /disable
	schtasks /Change /TN "\Microsoft\Windows\Shell\FamilySafetyMonitorToastTask" /disable
	schtasks /Change /TN "\Microsoft\Windows\Shell\FamilySafetyRefreshTask" /disable
	schtasks /Change /TN "\Microsoft\Windows\Subscription\EnableLicenseAcquisition" /disable
	schtasks /Change /TN "\Microsoft\Windows\Subscription\LicenseAcquisition" /disable
	schtasks /Change /TN "\Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner" /disable
	schtasks /Change /TN "\Microsoft\Windows\Diagnosis\Scheduled" /disable
	schtasks /Change /TN "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /disable
	del /F /Q "C:\Windows\System32\Tasks\Microsoft\Windows\SettingSync\*" 


	rem # %~dp0\ para poner ruta completa del script y poder ejecutar programas de forma relativa.
	%~dp0\Programas\OOSU10.exe %~dp0\Programas\ConfigPortatiles2019.cfg /quiet
	START /WAIT %~dp0\Programas\Office_2016_Plus_X64\setup.exe
	msiexec /i