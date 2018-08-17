@echo off

set filter= 
set filter2=/FI "USERNAME ne NT AUTHORITY\SYSTEM"

:options
if "%1" == "" goto ps
if "%1" == "-r" goto optr
if "%1" == "-u" goto optu
if "%1" == "-e" goto opta
if "%1" == "-a" goto opta
if "%1" == "-A" goto opta
if "%1" == "-w" goto optw
if "%1" == "-h" goto help
shift
goto options


:optu
set filter=%filter% /FI "USERNAME eq %USERNAME%"
shift
goto options
:optr
set filter=%filter% /FI "STATUS eq RUNNING"
shift
goto options
:optw
set filter=%filter% /V
shift
goto options
:opta
set filter2= 
shift
goto options

:ps
tasklist.exe %filter% %filter2%
goto end

:help
echo Unix-like process lister for Windows
echo ps[.bat] [-A ^| -r ^| -u user ^| -w]
echo    -A    all processes (include system users)
echo    -r    only running processes
echo    -u    only specified user's processes
echo    -w    wide output
goto end

:end
