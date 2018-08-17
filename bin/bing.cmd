@echo off
set cdir=%cd%
pushd .
cd /d "C:\Program Files (x86)\Internet Explorer"
if "%~1" == "" start iexplore.exe "http://video.bing.com?setmkt=en-US&setlang=en&uid=FA908932&FORM=NFTOUS"&popd&goto :EOF
start iexplore.exe "http://video.bing.com/search?q=%1&setmkt=en-US&setlang=en&uid=FA908932&FORM=NFTOUS"&popd&goto :EOF
popd

http://www.bing.com/search?q=url%3Ahttp%3A%2F%2Fblogread.cn%2Fit%2Farticle%2F4261&qs=n&form=QBRE&pq=url%3Ahttp%3A%2F%2Fblogread.cn%2Fit%2Farticle%2F4261&sc=8-4&sp=-1&sk=&cvid=F99758E5FAAF472B8563641F90BD5579

:end
exit /B %ERRORLEVEL%s
