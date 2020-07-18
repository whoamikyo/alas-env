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
SET ALAS_ENV=https://github.com/whoamikyo/alas-env.git
SET ALAS_ENV_GITEE=https://gitee.com/lmeszinc/alas-env.git
:: -----------------------------------------------------------------------------
call :check_Permissions
:check_Permissions
    echo Administrative permissions required. Detecting permissions...
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
        pause >nul
        call :menu
    ) else (
        echo Failure: Current permissions inadequate.
    )
    pause >nul
:: -----------------------------------------------------------------------------
call :menu
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
	echo		Type 'start' to begin the installation using default Github repository
	echo	  	Type 'gitee' to begin the installation using Gitee repository (for CN users)
	echo.
	echo.
	echo  :: Type a option and press ENTER
	echo  :: Type 'exit' to quit
	echo.
	set /P menu=
		if %menu%==start call :start
	    if %menu%==gitee call :start_gitee
		if %menu%==exit call :EOF
		else (
		cls
	echo.
	echo  :: Incorrect Input Entered
	echo.
	echo     Please type a 'number' or 'exit'
	echo     Press any key to return to the menu...
	echo.
		pause > NUL
		call :menu
		)

:: -----------------------------------------------------------------------------
:: killing adb server
:killadb
	call %ADB_PATH% --version >nul
	if %errorlevel% == 0 (
	echo ADB Found! Proceeding..
	echo killing adb server..
	call %ADB_PATH% kill-server > nul 2>&1
	call :menu
	) else (
		echo  :: ADB not found, maybe there was an installation issue, try opening another CMD window and type choco install adb
		echo.
        pause > NUL
        call :menu
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
	echo ## adding LMESZINC/GITEE remote origin
	call %GIT% remote add lmeszincgitee %GITEE%
	call %PYTHON% --version >nul
	if %errorlevel% == 0 (
	echo Python Found! Proceeding..
	echo Updating toolkit..
	call cd toolkit
	echo ## initializing toolkit..
	call %GIT% init
	call %GIT% config --global core.autocrlf false
	echo ## Adding files
	echo ## This process may take a while
	call %GIT% add -A
	echo ## adding origin..
	call %GIT% remote add origin %ALAS_ENV%
	echo Fething...
	call %GIT% fetch origin master
	call %GIT% reset --hard origin/master
	echo Pulling...
	call %GIT% pull --ff-only origin master
	call cd ..
	echo The installation was successful
	echo Press any key to proceed
	pause > NUL
	call :menu
	) else (
		echo :: it was not possible to install uiautomator2
		echo :: make sure you have a folder "toolkit"
		echo :: inside AzurLaneAutoScript folder.
		echo.
        pause > NUL
        call :menu
	)
	echo The installation was successful
	echo Press any key to proceed
	pause > NUL
	call :menu
	) else (
		echo  :: Git not found, maybe there was an installation issue, try opening another CMD window and type choco install git
		echo.
        pause > NUL
        call :menu
	)
:: -----------------------------------------------------------------------------
rem :check_connection
rem cls
rem 	echo.
rem 	echo  :: Checking For Internet Connection to Github...
rem 	echo.
rem 	timeout /t 2 /nobreak > NUL

rem 	ping -n 1 google.com -w 20000 >nul

rem 	if %errorlevel% == 0 (
rem 	echo You have a good connection with Github! Proceeding...
rem 	echo press any to proceed
rem 	pause > NUL
rem 	call start
rem 	) else (
rem 		echo  :: You don't have a good connection out of China
rem 		echo  :: It might be better to update using Gitee
rem 		echo  :: Redirecting...
rem 		echo.
rem         echo     Press any key to continue...
rem         pause > NUL
rem         call start_gitee
rem 	)
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
	echo ## initializing..
	call %GIT% init
	echo ## adding origin..
	call %GIT% remote add origin %GITEE%
	echo ## pulling project...
	call %GIT% pull origin master
	echo ## setting default branch...
	call %GIT% branch --set-upstream-to=origin/master master
	echo ## adding whoamikyo remote origin
	call %GIT% remote add whoamikyo %WHOAMIKYO%
	echo ## adding LMESZINC remote origin
	call %GIT% remote add LMESZINC %LMESZINC%
	call %PYTHON% --version >nul
	if %errorlevel% == 0 (
	echo Python Found! Proceeding..
	echo Updating toolkit..
	call cd toolkit
	echo ## initializing toolkit..
	call %GIT% init
	call %GIT% config --global core.autocrlf false
	echo ## Adding files
	echo ## This process may take a while
	call %GIT% add -A
	echo ## adding origin..
	call %GIT% remote add origin %ALAS_ENV_GITEE%
	echo Fething...
	call %GIT% fetch origin master
	call %GIT% reset --hard origin/master
	echo Pulling...
	call %GIT% pull --ff-only origin master
	call cd ..
	echo The installation was successful
	echo Press any key to proceed
	pause > NUL
	call :menu
	) else (
		echo :: it was not possible to install uiautomator2
		echo :: make sure you have a folder "toolkit"
		echo :: inside AzurLaneAutoScript folder.
		echo.
        pause > NUL
        call :menu
	)
	echo The installation was successful
	echo Press any key to proceed
	pause > NUL
	call :menu
	) else (
		echo  :: Git not found, maybe there was an installation issue
		echo.
        pause > NUL
        call :menu
	)
:: -----------------------------------------------------------------------------

:EOF
exit
