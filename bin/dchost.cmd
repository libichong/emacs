@echo off
set cdir=%cd%
pushd .
start D:\app\dchost\dchost.exe %*
:end
exit /B %ERRORLEVEL%s
