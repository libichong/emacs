@echo off
set cdir=%cd%
pushd .
cd /d "C:\Program Files (x86)\Internet Explorer"
if "%~1" == "" start iexplore.exe&popd&goto :EOF
if "%~1" == "cf" start iexplore.exe "http://codeflow/dashboard"&popd&goto :EOF
if "%~1" == "wiki" start iexplore.exe "https://www.bingwiki.com/Main_Page"&popd&goto :EOF
if "%~1" == "gg" start iexplore.exe "https://www.google.com/?gfe_rd=cr&ei=l-3XVuTRCa_R8AeN5LyYCQ&gws_rd=cr&fg=1"&popd&goto :EOF
if "%~1" == "bing" start iexplore.exe "http://www.bing.com/?setmkt=en-US&setlang=en&uid=FA908932&FORM=NFTOUS"&popd&goto :EOF
if "%~1" == "yt" start iexplore.exe "https://www.youtube.com/"&popd&goto :EOF
if "%~1" == "yk" start iexplore.exe "http://www.youku.com/"&popd&goto :EOF
if "%~1" == "rd" start iexplore.exe "http://stcsrv-c92/MmrV2Reader/"&popd&goto :EOF
if "%~1" == "ie" start notepad C:\Users\bichongl\OneDrive\app\ie.cmd&popd&goto :EOF
if "%~1" == "vh" start iexplore.exe "http://mmsearchtools/videohistory/"&popd&goto :EOF
if "%~1" == "st" start iexplore.exe "http://stamp/"&popd&goto :EOF
if "%~1" == "wdp" start iexplore.exe "https://msasg.visualstudio.com/DefaultCollection/Bing_and_IPG/_git/WDP_Dev"&popd&goto :EOF
if "%~1" == "vig" start /d "C:\Program Files\Internet Explorer" iexplore.exe "https://msasg.visualstudio.com/DefaultCollection/Bing_UX/VideoIG%%20Team/_git/VideoIG"&popd&goto :EOF
if "%~1" == "ismerge" start iexplore.exe "http://ismerge/ReportServer?/ISMergeReport/CategoryReport&Category=MM Prod&rs:ParameterLanguage=&rc:Parameters=Collapsed&rc:Toolbar=False"&popd&goto :EOF
popd

:end
exit /B %ERRORLEVEL%s
