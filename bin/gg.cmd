@echo off
set cdir=%cd%
pushd .
cd /d "C:\Program Files (x86)\Google\Chrome\Application\"
if "%~1" == "" start chrome.exe "https://www.google.com/?gfe_rd=cr&ei=l-3XVuTRCa_R8AeN5LyYCQ&gws_rd=cr&fg=1"&popd&goto :EOF
if NOT "%~1" == "" start chrome.exe "https://www.google.com/?gfe_rd=cr&ei=l-3XVuTRCa_R8AeN5LyYCQ&gws_rd=cr&fg=1#q=%*"&popd&goto :EOF

popd

:end
exit /B %ERRORLEVEL%s
