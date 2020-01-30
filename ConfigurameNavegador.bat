@echo off
title Selecciona una BIBLIO
set BIBLIO=.
set RUTAREL=.
set rutaconfigurame=%~dp0\configurame
set rutaChromepin=C:\Users\usuario\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\
set rutaEdgeInicio=C:\ProgramData\Microsoft\Windows\Start Menu\Programs
set rutaEdgePin=C:\Users\usuario\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar
set rutaChromeInicio=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\
set rutaFirefox=C:\Users\usuario\AppData\Roaming\Mozilla\Firefox\Profiles\sl1g2dat.default-release\
:inicio
cls
echo "~~~~~~~~~~~~~~~~~~~~~"	
echo " C O N F I G U R A M E"
echo "~~~~~~~~~~~~~~~~~~~~~"
echo "Selecciona la BIBLIO a la que va dirigida esta imagen"
echo "~~~~~~~~~~~~~~~~~~~~~"
echo " 1. Rector Machado (Fondo Antiguo y Archivo)"
echo " 2. Arquitectura"
echo " 3. Bellas Artes"
echo " 4. Centros de la Salud"
echo " 5. Comunicacion"
echo " 6. CRAI Ulloa"
echo " 7. Derecho y trabajo"
echo " 8. Economicas"
echo " 9. Educacion"
echo "10. Filosofía y Psicología"
echo "11. Humanidades"
echo "12. Informática"
echo "13. Ingeniería"
echo "14. Ingeniería Agronómica"
echo "15. Matematicas"
echo "16. Politécnica"
echo "17. Turismo y Finanzas"

set /p var=Seleccione una opcion [1-17]:
if "%var%"=="1" goto op1
if "%var%"=="2" goto op2
if "%var%"=="3" goto op3
if "%var%"=="4" goto op4
if "%var%"=="5" goto op5
if "%var%"=="6" goto op6
if "%var%"=="7" goto op7
if "%var%"=="8" goto op8
if "%var%"=="9" goto op9
if "%var%"=="10" goto op10
if "%var%"=="11" goto op11
if "%var%"=="12" goto op12
if "%var%"=="13" goto op13
if "%var%"=="14" goto op14
if "%var%"=="15" goto op15
if "%var%"=="16" goto op16
if "%var%"=="17" goto op17

::Mensaje de error, validación cuando se selecciona una opción fuera de rango
echo. El numero "%var%" no es una opcion valida, por favor intente de nuevo.
echo.
pause
echo.
goto inicio

	:op1
		echo.
		set BIBLIO="Rector Machado"
		set RUTAREL=\rectormachado
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar

	:op2
		echo.
		set RUTAREL=\arquitectura
		set BIBLIO="Arquitectura"
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar

	:op3
		echo.
		set BIBLIO="Bellas Artes"
		set RUTAREL=\bellasartes
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar
	:op4
		echo.
		set RUTAREL=\centrossalud
		set	BIBLIO="Centros de la Salud"
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar

	:op5
		echo.
		set RUTAREL=\comunicacion
		set	BIBLIO="Comunicacion"
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar
	
	:op6
		echo.
		set RUTAREL=\ulloa
		set BIBLIO="CRAI Ulloa"
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar
	
	:op7
		echo.
		set RUTAREL=\derecho
		set BIBLIO="Derecho y Trabajo"
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar

	:op8
		echo.
		set RUTAREL=\economicas
		set BIBLIO="Economicas"
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar
	
	:op9
		echo.
		set RUTAREL=\educacion
		set BIBLIO="Educacion"
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar
	
	:op10
		echo.
		set RUTAREL=\filosofia
		set BIBLIO="Filosofia y Psicologia"
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar
	
	:op11
		echo.
		set RUTAREL=\humanidades
		set BIBLIO="Humanidades"
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar
	
	:op12
		echo.
		set RUTAREL=\informatica
		set BIBLIO="Informatica"
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar
	
	:op13
		echo.
		set RUTAREL=\ingenieria
		set BIBLIO="Ingeniería"
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar
	
	:op14
		echo.
		set RUTAREL=\agronomos
		set BIBLIO="Ingenieria Agronómica"
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar
	
	:op15
		echo.
		set RUTAREL=\matematicas
		set BIBLIO="Matemáticas"
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar
	
	:op16
		echo.
		set RUTAREL=\politecnica
		set BIBLIO="Politécnica"
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar
	
	:op17
		echo.
		set RUTAREL=\turismo
		set BIBLIO="Turismo y Finanzas"
		echo. Has elegido la opcion %BIBLIO%
		echo.
		goto aplicar
	
	
:aplicar
		
copy "%rutaconfigurame%%RUTAREL%\Google Chrome.lnk" "%rutaChromepin%"
copy "%rutaconfigurame%%RUTAREL%\Google Chrome.lnk" "%rutaChromeInicio%"
copy "%rutaconfigurame%%RUTAREL%\prefs.js" "%rutaFirefox%"
copy "%rutaconfigurame%%RUTAREL%\Microsoft Edge.lnk" "%rutaEdgeInicio%"
copy "%rutaconfigurame%%RUTAREL%\Microsoft Edge.lnk" "%rutaEdgePin%"

pause
goto salir
:salir
@cls&exit