@echo off
setlocal enabledelayedexpansion

rem Get the directory of the batch file or the exe file
set "batch_dir=%~dp0"

rem Configuration file name
set "config_file=%batch_dir%config.txt"

rem Check if the configuration file exists
if exist "%config_file%" (
    rem Read the WinRAR location from the configuration file
    for /f "usebackq delims=" %%a in ("%config_file%") do (
        set "winrar=%%a"
        goto :skip_input
    )
)

rem If the configuration file does not exist or does not contain the WinRAR location, prompt the user to enter the WinRAR location
set /p "winrar=Please enter the WinRAR location (example: C:\Program Files\WinRAR\WinRAR.exe): "

rem Save the WinRAR location to the configuration file
echo %winrar% > "%config_file%"

:skip_input

:start
cls

echo "           ___    ____   ____  ____             ____   ____  ____   ___      ___  ____  
echo "          |   \  |    | /    ||    |           |    \ |    ||    \ |   \    /  _]|    \ 
echo "          |    \  |  | |   __| |  |  ________  |  o  ) |  | |  _  ||    \  /  [_ |  D  )
echo "          |  D  | |  | |  |  | |  | |        | |     | |  | |  |  ||  D  ||    _]|    / 
echo "          |     | |  | |  |_ | |  | |________| |  O  | |  | |  |  ||     ||   [_ |    \ 
echo "          |     | |  | |     | |  |            |     | |  | |  |  ||     ||     ||  .  \
echo "          |_____||____||___,_||____|           |_____||____||__|__||_____||_____||__|\_|    v0.1
echo "                                                                                                                                   

rem Request mode
echo What mode do you want to choose now?
echo 1. Compress multiple volumes
echo 2. Compress individual folders
echo 3. Convert rar/zip to cbr/cbz
set /p mode="Mode: "

rem Assign the selected mode

if "%mode%"=="1" goto :volumes
if "%mode%"=="2" goto :individual
if "%mode%"=="3" goto :converter

:volumes
cls

echo "           ___    ____   ____  ____             ____   ____  ____   ___      ___  ____  
echo "          |   \  |    | /    ||    |           |    \ |    ||    \ |   \    /  _]|    \ 
echo "          |    \  |  | |   __| |  |  ________  |  o  ) |  | |  _  ||    \  /  [_ |  D  )
echo "          |  D  | |  | |  |  | |  | |        | |     | |  | |  |  ||  D  ||    _]|    / 
echo "          |     | |  | |  |_ | |  | |________| |  O  | |  | |  |  ||     ||   [_ |    \ 
echo "          |     | |  | |     | |  |            |     | |  | |  |  ||     ||     ||  .  \
echo "          |_____||____||___,_||____|           |_____||____||__|__||_____||_____||__|\_|    v0.1
echo "                                                                                                                                                                                        

rem Request manga name
set /p manga="Please enter the manga name: "

cls

echo "           ___    ____   ____  ____             ____   ____  ____   ___      ___  ____  
echo "          |   \  |    | /    ||    |           |    \ |    ||    \ |   \    /  _]|    \ 
echo "          |    \  |  | |   __| |  |  ________  |  o  ) |  | |  _  ||    \  /  [_ |  D  )
echo "          |  D  | |  | |  |  | |  | |        | |     | |  | |  |  ||  D  ||    _]|    / 
echo "          |     | |  | |  |_ | |  | |________| |  O  | |  | |  |  ||     ||   [_ |    \ 
echo "          |     | |  | |     | |  |            |     | |  | |  |  ||     ||     ||  .  \
echo "          |_____||____||___,_||____|           |_____||____||__|__||_____||_____||__|\_|    v0.1
echo "                                                                   

rem Check if the manga name already exists
if exist "!manga! - * Chapters [*].cbz" (
    echo A manga with the name "!manga!" already exists.
    echo Please enter another name.
    goto :start
)

rem Request the number of chapters
set /p num_chapters="Please enter the number of chapters: "

cls

echo "           ___    ____   ____  ____             ____   ____  ____   ___      ___  ____  
echo "          |   \  |    | /    ||    |           |    \ |    ||    \ |   \    /  _]|    \ 
echo "          |    \  |  | |   __| |  |  ________  |  o  ) |  | |  _  ||    \  /  [_ |  D  )
echo "          |  D  | |  | |  |  | |  | |        | |     | |  | |  |  ||  D  ||    _]|    / 
echo "          |     | |  | |  |_ | |  | |________| |  O  | |  | |  |  ||     ||   [_ |    \ 
echo "          |     | |  | |     | |  |            |     | |  | |  |  ||     ||     ||  .  \
echo "          |_____||____||___,_||____|           |_____||____||__|__||_____||_____||__|\_|    v0.1
echo "                                                                   

rem Display language options and prompt for selection
echo Please select the language of the chapters:
echo 1. ENG (English)
echo 2. ESP (Spanish)
echo 3. JP (Japanese)
echo 4. OTHER (Other language)
set /p language="Option: "

rem Assign the selected language
if "%language%"=="1" set language=ENG
if "%language%"=="2" set language=ESP
if "%language%"=="3" set language=JP
if "%language%"=="4" set language=OTHER

rem Get the list of folders in the current directory
for /d %%i in (*) do (
    rem Check if the folder is not empty
    if exist "%%i\*" (
        rem Create the .cbz file
        echo Compressing folder: %%i
        rem Rename the files before compressing them
        set "chapter=1"
        for %%f in ("%%i\*") do (
            set "filename=%%~nf"
            set "extension=%%~xf"
            set "newname=!manga! - Chapter !chapter!%%~xf"
            ren "%%f" "!newname!"
            set /a chapter+=1
        )
        "%winrar%" a -afzip "!manga! (!num_chapters!) [!language!].cbz" "%%i\*"
        rem Delete the folder after compressing the files
        rmdir /s /q "%%i"
    ) else (
        echo Folder %%i is empty, compression will be skipped.
    )
)

rem Ask if they want to compress another manga or exit

cls

echo "           ___    ____   ____  ____             ____   ____  ____   ___      ___  ____  
echo "          |   \  |    | /    ||    |           |    \ |    ||    \ |   \    /  _]|    \ 
echo "          |    \  |  | |   __| |  |  ________  |  o  ) |  | |  _  ||    \  /  [_ |  D  )
echo "          |  D  | |  | |  |  | |  | |        | |     | |  | |  |  ||  D  ||    _]|    / 
echo "          |     | |  | |  |_ | |  | |________| |  O  | |  | |  |  ||     ||   [_ |    \ 
echo "          |     | |  | |     | |  |            |     | |  | |  |  ||     ||     ||  .  \
echo "          |_____||____||___,_||____|           |_____||____||__|__||_____||_____||__|\_|    v0.1
echo "                                                                   
echo " =====================================================================================================
echo "  ____                               __       _        ____                                        _             
echo " / ___| _   _  ___ ___ ___  ___ ___ / _|_   _| |      / ___|___  _ __ ___  _ __  _ __ ___  ___ ___(_) ___  _ __  
echo " \___ \| | | |/ __/ __/ _ \/ __/ __| |_| | | | |     | |   / _ \| '_ \` _ | '_ \| '__/ _ \/ __/ __| |/ _ \| '_ \
echo "  ___) | |_| | (_| (_|  __/\__ \__ \  _| |_| | |     | |__| (_) | | | | | | |_) | | |  __/\__ \__ \ | (_) | | | |
echo " |____/ \__,_|\___\___\___||___/___/_|  \__,_|_|      \____\___/|_| |_| |_| .__/|_|  \___||___/___/_|\___/|_| |_|
echo "                                                                          |_|                                                                                                                                                       
echo " =====================================================================================================
set /p continue="Do you want to compress another manga? (Y/N): "
if /i "%continue%"=="Y" goto :start
echo Exiting the script.
exit

:individual
cls

echo "           ___    ____   ____  ____             ____   ____  ____   ___      ___  ____  
echo "          |   \  |    | /    ||    |           |    \ |    ||    \ |   \    /  _]|    \ 
echo "          |    \  |  | |   __| |  |  ________  |  o  ) |  | |  _  ||    \  /  [_ |  D  )
echo "          |  D  | |  | |  |  | |  | |        | |     | |  | |  |  ||  D  ||    _]|    / 
echo "          |     | |  | |  |_ | |  | |________| |  O  | |  | |  |  ||     ||   [_ |    \ 
echo "          |     | |  | |     | |  |            |     | |  | |  |  ||     ||     ||  .  \
echo "          |_____||____||___,_||____|           |_____||____||__|__||_____||_____||__|\_|    v0.1
echo "                                                                                                                                                                                              

echo Do you really want to compress the folders?:
echo 1. Yes
echo 2. No
set /p method="Option: "

rem Assign the selected method
if "%method%"=="1" goto :individualconfirmed
if "%method%"=="2" goto :start

:individualconfirmed
cls

echo "           ___    ____   ____  ____             ____   ____  ____   ___      ___  ____  
echo "          |   \  |    | /    ||    |           |    \ |    ||    \ |   \    /  _]|    \ 
echo "          |    \  |  | |   __| |  |  ________  |  o  ) |  | |  _  ||    \  /  [_ |  D  )
echo "          |  D  | |  | |  |  | |  | |        | |     | |  | |  |  ||  D  ||    _]|    / 
echo "          |     | |  | |  |_ | |  | |________| |  O  | |  | |  |  ||     ||   [_ |    \ 
echo "          |     | |  | |     | |  |            |     | |  | |  |  ||     ||     ||  .  \
echo "          |_____||____||___,_||____|           |_____||____||__|__||_____||_____||__|\_|    v0.1
echo "                                                                                                                                                                                                  

rem Get the list of folders in the current directory
for /d %%i in (*) do (
    rem Check if the folder is not empty
    if exist "%%i\*" (
        rem Create the .cbz file
        echo Compressing folder: %%i
        "D:\Program Files\Winrar\WinRAR.exe" a -afzip "%%i.cbz" "%%i\*"
    ) else (
        echo Folder %%i is empty, compression will be skipped.
    )
)

echo " =====================================================================================================
echo "  ____                               __       _        ____                                        _             
echo " / ___| _   _  ___ ___ ___  ___ ___ / _|_   _| |      / ___|___  _ __ ___  _ __  _ __ ___  ___ ___(_) ___  _ __  
echo " \___ \| | | |/ __/ __/ _ \/ __/ __| |_| | | | |     | |   / _ \| '_ \` _ | '_ \| '__/ _ \/ __/ __| |/ _ \| '_ \
echo "  ___) | |_| | (_| (_|  __/\__ \__ \  _| |_| | |     | |__| (_) | | | | | | |_) | | |  __/\__ \__ \ | (_) | | | |
echo " |____/ \__,_|\___\___\___||___/___/_|  \__,_|_|      \____\___/|_| |_| |_| .__/|_|  \___||___/___/_|\___/|_| |_|
echo "                                                                          |_|                                                                                                                                                   
echo " =====================================================================================================
set /p continuar="Do you want to compress another manga? (Y/N): "
if /i "%continuar%"=="Y" goto :start
echo Exiting the script.
exit

:converter
cls

echo "           ___    ____   ____  ____             ____   ____  ____   ___      ___  ____  
echo "          |   \  |    | /    ||    |           |    \ |    ||    \ |   \    /  _]|    \ 
echo "          |    \  |  | |   __| |  |  ________  |  o  ) |  | |  _  ||    \  /  [_ |  D  )
echo "          |  D  | |  | |  |  | |  | |        | |     | |  | |  |  ||  D  ||    _]|    / 
echo "          |     | |  | |  |_ | |  | |________| |  O  | |  | |  |  ||     ||   [_ |    \ 
echo "          |     | |  | |     | |  |            |     | |  | |  |  ||     ||     ||  .  \
echo "          |_____||____||___,_||____|           |_____||____||__|__||_____||_____||__|\_|
echo "                                                                                                                                     

echo Please select the converter:
echo 1. RAR to CBR
echo 2. CBR to RAR
set /p metodo="Option: "

rem Assign the selected method
if "%metodo%"=="1" goto :rar
if "%metodo%"=="2" goto :cbr

:cbr
cls

echo "           ___    ____   ____  ____             ____   ____  ____   ___      ___  ____  
echo "          |   \  |    | /    ||    |           |    \ |    ||    \ |   \    /  _]|    \ 
echo "          |    \  |  | |   __| |  |  ________  |  o  ) |  | |  _  ||    \  /  [_ |  D  )
echo "          |  D  | |  | |  |  | |  | |        | |     | |  | |  |  ||  D  ||    _]|    / 
echo "          |     | |  | |  |_ | |  | |________| |  O  | |  | |  |  ||     ||   [_ |    \ 
echo "          |     | |  | |     | |  |            |     | |  | |  |  ||     ||     ||  .  \
echo "          |_____||____||___,_||____|           |_____||____||__|__||_____||_____||__|\_|
echo "                                                                                                                                     

set counter=0
for %%f in (*.cbz *.cbr) do (
    ren "%%f" "%%~nf.zip"
    set /a counter+=1
)
for %%f in (*.rar) do (
    ren "%%f" "%%~nf.cbr"
    set /a counter+=1
)
echo %counter% files renamed.
pause
goto :eof


:rar
cls

echo "           ___    ____   ____  ____             ____   ____  ____   ___      ___  ____  
echo "          |   \  |    | /    ||    |           |    \ |    ||    \ |   \    /  _]|    \ 
echo "          |    \  |  | |   __| |  |  ________  |  o  ) |  | |  _  ||    \  /  [_ |  D  )
echo "          |  D  | |  | |  |  | |  | |        | |     | |  | |  |  ||  D  ||    _]|    / 
echo "          |     | |  | |  |_ | |  | |________| |  O  | |  | |  |  ||     ||   [_ |    \ 
echo "          |     | |  | |     | |  |            |     | |  | |  |  ||     ||     ||  .  \
echo "          |_____||____||___,_||____|           |_____||____||__|__||_____||_____||__|\_|
echo "                                                                                                                                     

set counter=0
for %%f in (*.zip) do (
    ren "%%f" "%%~nf.cbz"
    set /a counter+=1
)
for %%f in (*.cbr) do (
    ren "%%f" "%%~nf.rar"
    set /a counter+=1
)
echo %counter% files renamed.
pause