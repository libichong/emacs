@echo off

set force=0
set ia=0
set newd= 
set newf= 
set target= 
set ln=1
set lnmode=hardlink

:options
if "%1" == "" goto ln
if "%1" == "-s" goto symlink
if "%1" == "-d" goto junction
if "%1" == "-F" goto junction
if "%1" == "-f" goto force
if "%1" == "-i" goto ia
if "%1" == "-t" goto targetdir
if "%1" == "-h" goto help
goto target
rem --- outlooped ---
shift
goto options

:target
if not "%target%" == " " set newf=%1
if "%target%" == " " set target=%1
shift
goto options
:symlink
set lnmode=softlink
shift
goto options
:junction
set lnmode=junction
shift
goto options
:force
set force=1
shift
goto options
:ia
set ia=1
shift
goto options

:targetdir
shift
set newd=%1
set ln=2
:ln2
shift
set target=%1
if "%target%" == "" goto end
set newf=%target%
goto ln
goto end

:ln
if "%target%" == " " goto help
if "%newf%" == " " set newf=link_%target%
if not "%newd%" == " " set newf=%newd%\%newf%
:isitafolder
rem Is it a folder?
if EXIST "%newf%\" goto dir
if EXIST "%newf%" goto exist
:continue
if "%lnmode%" == "hardlink" fsutil.exe hardlink create "%newf%" "%target%"
if "%lnmode%" == "softlink" linkd.exe "%newf%" "%target%"
if "%lnmode%" == "junction" junction.exe "%newf%" "%target%"
:noforce
if "%ln%" == "2" goto ln2
goto end

:exist
echo ln: %newf%: already exist.
if "%force%" == "0" goto noforce
rem --- determine object type
fsutil.exe reparsepoint query "%newf%" > NUL:
if ERRORLEVEL 1 goto del
if ERRORLEVEL 0 goto unlink
echo ln: %newf%: object type not determined, bypass.
goto noforce
:del
if "%ia%" == "1" DEL /P /F "%newf%"
if not "%ia%" == "1" DEL /F "%newf%"
goto continue
:unlink
attrib.exe -r "%newf%"
linkd.exe "%newf%" /D
goto continue

:dir
rem FIXME: here, %newf% can be real directory or reparsepoint to whatever.
rem   programm fails, when its a reparsepoint not points to directory
set newf=%newf%\%target%
goto isitafolder

:help
echo Unix-like link manager for Windows
echo ln[.bat] [-s ^| -d ^| -f ^| -i] target [new_object ^| directory]
echo ln[.bat] [-s ^| -d ^| -f ^| -i] -t directory  target(s)
echo    -s      creates symbolic links
echo    -d      creates directory junctions
echo    -f      dont bypass existing files
echo    -i      ask user for rewrite existing files interactively (not works on reparsepoints)
echo    object  be a hardlink or a reparsepoint
echo    target  file or directory, new_object points to here (reparsepoints cant be hardlinked)
echo    -t dir  a directory, at which new objects will be created for each targets
goto end

:end
