@echo off

set param=/release 
set faces=/all 

:options
if "%1" == "" goto ifconfig
if "%1" == "-a" goto all
if "%1" == "-h" goto help
goto iface
rem --- outlooped ---
shift
goto options

:all
set faces=/all 
shift
goto options
:iface
set faces=%1
shift
goto options

:ifconfig
ipconfig.exe %param% %faces%
goto end

:help
echo Unix-like NIC manager for Windows
echo ifdown[.bat] [interface ^| -a]
goto end

:end