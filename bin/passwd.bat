@echo off

set user=%USERNAME%
set scope=user
set param= 


:options
if "%1" == "" goto passwd
if "%1" == "-l" goto lock
if "%1" == "-u" goto unlock
if "%1" == "-d" goto delpass
if "%1" == "-S" goto status
if "%1" == "-n" goto min
if "%1" == "-x" goto max
if "%1" == "-h" goto help
set user=%1
goto options


:lock
set param=%param% /active:no
set scope=user
shift
goto options
:unlock
set param=%param% /active:yes
set scope=user
shift
goto options
:delpass
set param=%param% /passwordreq:no
set scope=user
shift
goto options
:status
set param= 
set scope=user
shift
goto options
:min
shift
set param=%param% /minpwage:%1
set scope=accounts
shift
goto options
:max
shift
set param=%param% /maxpwage:%1
set scope=accounts
shift
goto options

:passwd
if "%scope%" == "accounts" goto accounts
if "%param%" == " " set param=*
echo %user%:
net.exe user %user% %param%
goto end
:accounts
net.exe accounts %param%
goto end

:help
echo Unix-like password managment for Windows
echo passwd[.bat]  [[-l ^| -d ^| -S] [user]]  [[-n ^| -x] days]
echo    -l    lock an account
echo    -u    unlock an account
echo    -S    show the status of an account
echo  user independent policies
echo    -n    set the minimum days before password to be changed
echo    -x    set the maximum days before password must be changed
echo  default action: set password for user
goto end

:end
