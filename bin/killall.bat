@echo off

:kill
if "%1" == "" goto end
taskkill.exe /f /im "%1"
shift
goto kill

:end
