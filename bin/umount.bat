@echo off

set mountpoint= 

:options
if "%1" == "" goto umount
if "%1" == "-h" goto help
goto params
rem --- outlooped ---
shift
goto options

:params
set mountpoint=%1
shift
goto options

:umount
if "%mountpoint%" == " " goto help
rem --- mountvol:
echo %mountpoint% | findstr.exe /B "\\\\\?\\" > NUL:
if ERRORLEVEL 0 goto umountvol
rem --- mountvol:
mountvol.exe "%mountpoint%" /L > NUL:
if ERRORLEVEL 0 goto umountvol
rem --- subst:
subst.exe | findstr.exe /R /I /B "%mountpoint%" > NUL:
if ERRORLEVEL 0 goto subst
rem --- net use:
net.exe use "%mountpoint%" /DELETE
goto end

:umountvol
mountvol "%mountpoint%" /D
goto end

:subst
subst.exe "%mountpoint%" /D
goto end

:help
echo Unix-like umount for Windows
echo umount[.bat] [device: ^| reparsepoint]
goto end

:end
