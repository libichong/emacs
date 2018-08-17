@echo off

set mountpoint=*
set device= 
set user= 
set param0=/PERSISTENT:NO

rem --- zero parameters ---
if "%1" == "" goto mount0

:options
if "%1" == "" goto cases
if "%1" == "-u" goto user
if "%1" == "-h" goto help
goto params
rem --- outlooped ---
shift
goto options

:user
shift
set user=%1
shift
goto options
:params
if not "%device%" == " " set mountpoint=%1
if "%device%" == " " set device=%1
shift
goto options

:mount0
net.exe use | find.exe "\"
subst.exe | find.exe "\"
mountvol.exe | findstr.exe "\\ :\"
goto end

:cases
if "%device%" == " " goto help
rem --- mountvol:
rem ^\\?\Volume...
echo %device% | findstr.exe /B "\\\\\?\\" > NUL:
if ERRORLEVEL 0 goto mountvol
rem --- net use:
rem network_share starts with double backslash
echo %device% | findstr.exe /B "\\\\" > NUL:
if ERRORLEVEL 0 goto netuse
rem --- mountvol: 
rem regexp first dot for drive letter, second dot for line feed
echo %device% | findstr.exe /R "^.:.$" > NUL:
if ERRORLEVEL 0 goto resolve
rem --- subst:
goto subst
rem else
goto help
goto end
goto unwantedexception :]

:netuse
if not "%user%" == " " set user=* /USER:%user%
rem *** network share -> drive letter
net.exe use %mountpoint% %device% %user% %param0%
goto end

:subst
if "%mountpoint%" == "*" goto help2
rem *** path -> drive letter
subst.exe %mountpoint% %device%
goto end

:resolve
rem --- resolve volume's ClassID
for /F "tokens=1*" %%v in ('mountvol.exe %device% /L') do set device=%%v
:mountvol
if "%mountpoint%" == "*" goto help2
if not exist "%mountpoint%" echo mount: %mountpoint%: not exists
rem *** volume -> ntfs directory
mountvol.exe %mountpoint% %device%
goto end

:help
echo Unix-like mount for Windows
echo mount[.bat] source [target] [-u user]
echo   source    a network share (\\computer\share) for map as network drive, 
echo             a local path (C:\directory) for substitution, 
echo             or a physical volume (letter or ClassID) for mount volumes
echo   target    a local device: disk drive letter (F:), 
echo                             printer (LPT2:),
echo             or a local empty directory on NTFS volume
echo Examples
echo  mount \\server\docs D:
echo  mount C:\this\is\a\very\deep\folder\ F:
echo  mount .\relative\path\ F:
echo  mount \\?\Volume{0f1f2372-8127-11de-a9d2-806d6172696f}\ C:\mnt\fd0\
echo  mount A: C:\mnt\fd0\
goto end
:help2
echo mount: Must specify target.
goto end

:end
