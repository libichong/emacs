@echo off

:kill
if "%1" == "" goto end
taskkill.exe /f /pid %1
shift
goto kill

:end
