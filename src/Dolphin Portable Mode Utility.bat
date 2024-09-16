@echo off

:cechoCheck
if exist "%~dp0bin\cecho.exe" set cecho="%~dp0bin\cecho.exe" & goto :DolphinCheck
title Error! & cls & color 0c
echo.
echo .\bin\cecho.exe not found! Re-extract, then press any key to proceed...
pause > nul
goto :cechoCheck

:DolphinCheck
if exist "%~dp0Dolphin.exe" goto :PortableCheck
title Error! & cls
echo.
%cecho% {07}.\Dolphin.exe {0c}not found! Place this script in your Dolphin Emulator directory.{\n}
pause > nul & exit /b

:PortableCheck
title Exception!
if not exist ".\portable.txt" goto :PathCheck else
echo.
%cecho% {0c}
set /p choice="Portable mode is already enabled, proceed anyway? (y/n): "
if /i "%choice%" equ "Y" goto :PathCheck
if /i "%choice%" equ "N" exit /b
echo.
%cecho% {0c}You must enter 'y' or 'n' to proceed...{\n} & pause > nul
goto :main

:PathCheck
if exist "%appdata%\Dolphin Emulator" set DataPath="%appdata%\Dolphin Emulator" & goto :main
if exist "%userprofile%\Documents\Dolphin Emulator" set DataPath="%userprofile%\Documents\Dolphin Emulator" & goto :main
cls
%cecho% {0c}No existing Dolphin userdata located in:{\n}
echo.
%cecho% {\t}{07}%appdata%\Dolphin Emulator\{\n}
%cecho% {\t}{07}%userprofile%\Documents\Dolphin Emulator\{\n}
echo.
%cecho% {0c}Exiting...{\n}
pause > nul & exit /b

:main
title Dolphin Portable Mode Utility & cls
echo.
%cecho% {0e}
set /p choice="Dolphin will be closed if it is running. Enable portable mode? (y/n): "
if /i "%choice%" equ "Y" goto :TransferData
if /i "%choice%" equ "N" exit /b
echo.
%cecho% {0c}You must enter 'y' or 'n' to proceed...{\n} & pause > nul
goto :main

:TransferData
echo.
taskkill /im Dolphin.exe /f > nul 2>&1
%cecho% {0e}Transferring userdata from {07}%DataPath%{0e}...{\n}
echo > "%~dp0portable.txt"
xcopy %DataPath% "%~dp0User\" /E /Y
cls
echo.
%cecho% {0a}Userdata transfer completed.{\n}
echo.
%cecho% {0e}It is recommended to check {0c}all {0e}paths in:{\n}
%cecho% {\t}{07}Config ^> Paths{\n}
%cecho% {\t}{07}Config ^> GameCube{\n}
%cecho% {\t}{07}Config ^> Wii{\n}
echo.
%cecho% {0e}All instances of {07}%DataPath%{0e}should be replaced with {07}.\User{0e}.{\n}
echo.
%cecho% {0e}Press any key to run Dolphin.{\n}
pause > nul
start "" "Dolphin.exe" & exit /b
