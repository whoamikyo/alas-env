@echo off
pushd "%~dp0"
:: VARIABLES INSTALL
SET RENAME="toolkit"
if exist %RENAME% (
  rename %RENAME% toolkit
)
SET CMD=%SystemRoot%\system32\cmd.exe
SET LMESZINC=https://github.com/LmeSzinc/AzurLaneAutoScript.git
SET GITEE=https://gitee.com/lmeszinc/AzurLaneAutoScript.git
SET WHOAMIKYO=https://github.com/whoamikyo/AzurLaneAutoScript.git
SET ENV=https://github.com/whoamikyo/alas-env.git
:: -----------------------------------------------------------------------------
goto check_Permissions
:check_Permissions
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
        pause >nul
        goto menu
    ) else (
        echo Failure: Current permissions inadequate.
    )

    pause >nul
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
		if %menu%==start GOTO check_connection
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
SET PYTHON=%AZURLANESCRIPT%\toolkit\python.exe
SET GIT_PATH=%AZURLANESCRIPT%\toolkit\Git\cmd
SET GIT=%GIT_PATH%\git.exe
	call %GIT% --version >nul
	if %errorlevel% == 0 (
	echo Cloning repository
	echo GIT Found! Proceeding..
	echo Cloning repository...
	cd %AZURLANESCRIPT%
rem 	echo Deleting folder unused files
rem 	for /D %%D in ("*") do (
rem     if /I not "%%~nxD"=="toolkit" rd /S /Q "%%~D"
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
	call cd toolkit
	echo ## initializing toolkit..
	call %GIT% init
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
		echo :: make sure you have a folder "toolkit"
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
        goto menu
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
	rem 	echo :: make sure you have a folder "toolkit"
	rem 	echo :: inside AzurLaneAutoScript folder.
	rem 	echo.
 rem        pause > NUL
 rem        goto menu
	rem )
:: -----------------------------------------------------------------------------
:check_connection
cls
	echo.
	echo  :: Checking For Internet Connection to Github...
	echo.
	timeout /t 2 /nobreak > NUL

	ping -n 1 google.com -w 20000 >nul

	if %errorlevel% == 0 (
	echo You have a good connection with Github! Proceeding...
	echo press any to proceed
	pause > NUL
	goto start
	) else (
		echo  :: You don't have a good connection out of China
		echo  :: It might be better to update using Gitee
		echo  :: Redirecting...
		echo.
        echo     Press any key to continue...
        pause > NUL
        goto start_gitee
	)
:: -----------------------------------------------------------------------------
:start_gitee
SET AZURLANESCRIPT=%~dp0
SET PYTHON=%AZURLANESCRIPT%\toolkit\python.exe
SET GIT_PATH=%AZURLANESCRIPT%\toolkit\Git\cmd
SET GIT=%GIT_PATH%\git.exe
	call %GIT% --version >nul
	if %errorlevel% == 0 (
	echo Cloning repository
	echo GIT Found! Proceeding..
	echo Cloning repository...
	cd %AZURLANESCRIPT%
rem 	echo Deleting folder unused files
rem 	for /D %%D in ("*") do (
rem     if /I not "%%~nxD"=="toolkit" rd /S /Q "%%~D"
rem 	)
rem for %%F in ("*") do (
rem     del "%%~F"
rem 	)
	echo ## initializing..
	call %GIT% init
	echo ## adding origin..
	call %GIT% remote add origin %GITEE%
	echo ## pulling project...
	call %GIT% pull origin master
	echo ## setting default branch...
	call %GIT% branch --set-upstream-to=origin/master master
	echo ## adding LMESZINC remote origin
	call %GIT% remote add LMESZINC %LMESZINC%
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
		echo :: make sure you have a folder "toolkit"
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
		echo  :: Git not found, maybe there was an installation issue
		echo.
        pause > NUL
        goto menu
	)
:: -----------------------------------------------------------------------------
:EOF
exit
