@echo off
set cdir=%cd%
pushd .
cd /d "C:\Program Files (x86)\Mozilla Firefox"
if "%~1" == "" start firefox.exe&popd&goto :EOF
start firefox.exe "https://www.google.com/search?q=%*"
popd

:end
exit /B %ERRORLEVEL%s
