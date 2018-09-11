@echo off
set cdir=%cd%
pushd .
cd /d "C:\Users\bichongl\OneDrive\app\Vim\vim74"
set file=%*
set cfile="%cdir%\%*"
if [%file%]==[] start gvim.exe&popd&goto :EOF
if [%file:~1,1%]==[:] (start gvim.exe %file%)&popd&goto :EOF

if exist %cfile% (
    start gvim.exe "%cdir%\%*"
) else (
    echo %cfile% doesn't exist
    popd
    goto :end
)

popd

:end
exit /B %ERRORLEVEL%s
