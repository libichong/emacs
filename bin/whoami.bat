@echo off

:whoami
echo %USERDOMAIN%\%USERNAME%
goto end

:help
echo Unix-like whoami for Windows
echo whoami[.bat]
goto end

:end
