@echo off
set cdir=%cd%
pushd .
cd /d "C:\Program Files (x86)\Internet Explorer"
if "%~1" == "" start iexplore.exe "https://www.youtube.com/"&popd&goto :EOF
if "%~1" == "yt" notepad C:\Users\bichongl\OneDrive\app\yt.cmd&popd&goto :EOF
if "%~1" == "v" start iexplore.exe "https://www.youtube.com/watch?v=%~2"&popd&goto :EOF
if "%~1" == "b" start iexplore.exe "http://video.bing.com/search?q=url:https://www.youtube.com/watch?v=%~2&setmkt=en-US&setlang=en&uid=FA908932&FORM=NFTOUS"&popd&goto :EOF

if NOT "%~1" == "" start iexplore.exe "https://www.youtube.com/results?search_query=%*"&popd&goto :EOF
popd

:end
exit /B %ERRORLEVEL%s
