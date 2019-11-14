@echo off
title Selecciona una biblioteca
set biblioteca=.
set rutarel=.

:inicio
cls
echo "~~~~~~~~~~~~~~~~~~~~~"	
echo " C O N F I G U R A M E"
echo "~~~~~~~~~~~~~~~~~~~~~"
echo "Selecciona la biblioteca a la que va dirigida esta imagen"
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

set /p var=Seleccione una opcion [1-18]:
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
	set biblioteca="Rector Machado"
	set rutarel=/rectormachado
	echo. Has elegido la opcion %biblioteca%
	echo.
	::Aquí van las líneas de comando de tu opción
	goto aplicar

	:op2
	echo.
	set rutarel=/arquitectura
	set biblioteca="Arquitectura"
	echo. Has elegido la opcion %biblioteca%
	echo.
	::Aquí van las líneas de comando de tu opción
	goto aplicar

	:op3
	echo.
	set biblioteca="Rector Machado"
	set rutarel=/bellasartes
	echo. Has elegido la opcion %biblioteca%
	echo.
	::Aquí van las líneas de comando de tu opción
	goto aplicar
	:op4
	echo.
	echo. Has elegido la opcion No. 4
	echo.
	::Aquí van las líneas de comando de tu opción
	color 0B
	echo.
	pause
	goto inicio

	:op5
	echo.
	echo. Has elegido la opcion No. 5
	echo.
	::Aquí van las líneas de comando de tu opción
	color 0C
	echo.
	pause
	goto inicio


:aplicar


pause

:salir
@cls&exit