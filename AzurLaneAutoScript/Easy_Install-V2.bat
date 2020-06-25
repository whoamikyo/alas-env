@echo off
rem pushd "%~dp0"
:: VARIABLES INSTALL

SET CMD=%SystemRoot%\system32\cmd.exe
SET LMESZINC=https://github.com/LmeSzinc/AzurLaneAutoScript.git
SET WHOAMIKYO=https://github.com/whoamikyo/AzurLaneAutoScript.git

:: -----------------------------------------------------------------------------
goto menu
:menu
	cls
	echo.
	echo  :: Easy install for ALAS
	echo. 
	echo  This script will install Python 3.7.6 + requirements.txt + ADB + GIT
	echo  and Download the latest version from LmeSzinc repository
	echo.
	echo.
	echo Before starting the installation you must already have your emulator installed
	echo. 
	echo		Type 'start' to begin the installation
	echo.	
	echo. 
	echo  :: Type a 'start' and press ENTER
	echo  :: Type 'exit' to quit
	echo.
	set /P menu=
		if %menu%==start GOTO start
		if %menu%==exit GOTO EOF
		
		else (
		cls
	echo.
	echo  :: Incorrect Input Entered
	echo.
	echo     Please type a 'number' or 'exit'
	echo     Press any key to return to the menu...
	echo.
		pause > NUL
		goto menu
		)

:: -----------------------------------------------------------------------------
:: killing adb server
:killadb
	call %ADB_PATH% --version >nul
	if %errorlevel% == 0 (
	echo ADB Found! Proceeding..
	echo killing adb server..
	call %ADB_PATH% kill-server > nul 2>&1
	goto menu
	) else (
		echo  :: ADB not found, maybe there was an installation issue, try opening another CMD window and type choco install adb
		echo.
        pause > NUL
        goto menu
	)
:: -----------------------------------------------------------------------------
:start
SET AZURLANESCRIPT=%~dp0
SET PYTHON=%AZURLANESCRIPT%\python-3.7.6.amd64\python.exe
SET GIT_PATH=%AZURLANESCRIPT%\python-3.7.6.amd64\Git\cmd
SET GIT=%GIT_PATH%\git.exe
	call %GIT% --version >nul
	if %errorlevel% == 0 (
	echo Cloning repository
	echo GIT Found! Proceeding..
	echo Cloning repository...
	cd %AZURLANESCRIPT%
rem 	echo Deleting folder unused files
rem 	for /D %%D in ("*") do (
rem     if /I not "%%~nxD"=="python-3.7.6.amd64" rd /S /Q "%%~D"
rem 	)
rem for %%F in ("*") do (
rem     del "%%~F"
rem 	)
	echo ## initializing..
	call %GIT% init
	echo ## adding origin..
	call %GIT% remote add origin %LMESZINC%
	echo ## pulling project...
	call %GIT% pull origin master
	echo ## setting default branch...
	call %GIT% branch --set-upstream-to=origin/master master
	echo ## adding whoamikyo remote origin
	call %GIT% remote add whoamikyo %WHOAMIKYO%
	call %PYTHON% --version >nul
	if %errorlevel% == 0 (
	echo Python Found! Proceeding..
	echo initializing uiautomator2..
	call %PYTHON% -m uiautomator2 init
	echo The installation was successful
	echo Press any key to proceed
	pause > NUL
	goto menu
	) else (
		echo :: it was not possible to install uiautomator2
		echo :: make sure you have a folder "python-3.7.6.amd64"
		echo :: inside AzurLaneAutoScript folder.
		echo.
        pause > NUL
        goto menu
	)
	echo The installation was successful
	echo Press any key to proceed
	pause > NUL
	goto menu
	) else (
		echo  :: Git not found, maybe there was an installation issue, try opening another CMD window and type choco install git
		echo.
        pause > NUL
	)
:: -----------------------------------------------------------------------------
	rem call %PYTHON% --version >nul
	rem if %errorlevel% == 0 (
	rem echo Python Found! Proceeding..
	rem echo initializing uiautomator2..
	rem call %PYTHON% -m uiautomator2 init
	rem echo The installation was successful
	rem echo Press any key to proceed
	rem pause > NUL
	rem goto menu
	rem ) else (
	rem 	echo :: it was not possible to install uiautomator2
	rem 	echo :: make sure you have a folder "python-3.7.6.amd64"
	rem 	echo :: inside AzurLaneAutoScript folder.
	rem 	echo.
 rem        pause > NUL
 rem        goto menu
	rem )
:: -----------------------------------------------------------------------------
:EOF
exit
