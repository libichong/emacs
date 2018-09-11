@echo off
call init.cmd
if "%~1"=="" goto :help
if "%~1"=="sg" goto :sg
if "%~1"=="sglab" goto :sglab
if "%~1"=="mm" goto :mm
if "%~1"=="mmig" goto :mmig
if "%~1"=="live" goto :live
if "%~1"=="kwd03" goto :kwd03
if "%~1"=="mmlab" goto :mmlab
if "%~1"=="kwd" goto :kwd
if "%~1"=="kwdlab" goto :kwdlab
if "%~1"=="vs" goto :vs
if "%~1"=="vn" goto :vn
if "%~1"=="vnlab" goto :vnlab
if "%~1"=="da" goto :da
if "%~1"=="dalab" goto :dalab
if "%~1"=="mbin" goto :mbin
if "%~1"=="mbout" goto :mbout
if "%~1"=="mpin" goto :mpin
if "%~1"=="clean" goto :clean
if "%~1"=="cmd" goto :cmd
if "%~1"=="db" goto :db
if "%~1"=="dk" goto :dk
if "%~1"=="mmcb" goto :mmcb
if "%~1"=="mmcblab" goto :mmcblab
if "%~1"=="bn1" goto :bn1
if "%~1"=="co3" goto :co3
if "%~1"=="bj1" goto :bj1
if "%~1"=="multimedia" goto :multimedia
if "%~1"=="bw" goto :bw
if "%~1"=="mediacrawler" goto :mediacrawler
if "%~1"=="startmb" goto :startmb
if "%~1"=="log" goto :log
if "%~1"=="mb" goto :mb
if "%~1"=="bjs" goto :bjs
if "%~1"=="jpn" goto :jpn
if "%~1"=="proxy" goto :proxy
if "%~1"=="noproxy" goto :noproxy
if "%~1"=="itg" goto :itg
if "%~1"=="hk" goto :hk
if "%~1"=="ew" goto :ew
if "%~1"=="`" goto :`
if "%~1"=="word" goto :word
if "%~1"=="xls" goto :xls
if "%~1"=="cosmos" goto :cosmos
if "%~1"=="init.el" goto :init.el
if "%~1"=="legacy" goto :legacy
if "%~1"=="mmda" goto :mmda
if "%~1"=="vcppe" goto :vcppe
if "%~1"=="vcprod" goto :vcprod
if "%~1"=="64" goto :64
if "%~1"=="rar" goto :rar
if "%~1"=="get" goto :get
if "%~1"=="dapack" goto :dapack
if "%~1"=="ps" goto :ps
if "%~1"=="putty" goto :putty
if "%~1"=="config" goto :config
if "%~1"=="." goto :cur
if "%~1"=="xts" goto :xts
if "%~1"=="ie" goto :ie
if "%~1"=="mp" goto :mp
if "%~1"=="mmrv2" goto :mmrv2
if "%~1"=="cc" goto :cc
if "%~1"=="tm" goto :tm
if "%~1"=="ob" goto :ob
if "%~1"=="06" goto :06
if "%~1"=="92" goto :92
if "%~1"=="fd" goto :fd
if "%~1"=="flv" goto :flv
if "%~1"=="sm" goto :sm
if "%~1"=="ag" goto :ag
if "%~1"=="tps" goto :tps
if "%~1"=="12" goto :12
echo Invalid paramter %~1
goto :EOF
:flv
wget -O D:\1.flv %~2
goto :EOF
:dapack
title dapack "%~2"
pushd .
cd /d D:/da
DAPack.exe -pack my.zip -mbset Success 100 "%~2"
unzip -o my.zip -d my
mv ./my/data/msnbot/input/mb.crawl "%~2".crawl
rmdir /S /Q my
goto :EOF
:06
start mstsc C:\Users\bichongl\OneDrive\app\lsstchost06.rdp /noConsentPrompt
goto :EOF
:92
start mstsc C:\Users\bichongl\OneDrive\app\stcsrv-c92.rdp /noConsentPrompt
goto :EOF
:12
cd /d Z:\Data\APGold\autopilotservice\Global\VirtualEnvironments\Cosmos
goto :EOF
:cc
echo %cd%|clip
goto :EOF
:cur
start .
goto :EOF
:tm
start taskmgr
goto :EOF
:ob
runas /savecred /profile /user:administrator "D:\onebox\onebox.bat"
goto :EOF
:ie
start iexplore
goto :EOF
:xts
start D:\app\XTS\xts.exe
goto :EOF
:putty
title connect thirty.cloudapp.net
start D:\app\putty\putty.exe -l libicong00 -load thirty -pw bc@MS2012
goto :EOF
:rar
title unrar "%~2"
copy "%~2" \\msrasia\Share\Rar2zip\in
ping 127.0.0.2 -n 1 -w 100000 > nul
robocopy \\msrasia\Share\Rar2zip\out D:\tmp\unrar\
goto :EOF
:get
title wget "%~2"
wget -O temp.html --save-headers "%~2"
n temp.html
goto :EOF
:ps
title Powershell
powershell
goto :EOF
:sg
title corext searchgold bsdsearchgold 7727
cd /d Z:\Data\SearchGold
set inetroot=Z:\Data\SearchGold&set corextbranch=searchgold&Z:\Data\SearchGold\tools\path1st\myenv.cmd
cd /d Z:\Data\SearchGold\deploy\builds\data\latest\MMCB\
goto :EOF
:ag
title corext apgold sdapgold 1251
cd /d Z:\Data\APGold\autopilotservice\Co3\VideoCrawl-Prod-Co3
set inetroot=Z:\Data\APGold&set corextbranch=apgold&Z:\Data\APGold\tools\path1st\myenv.cmd
cd /d Z:\Data\APGold\autopilotservice\Co3\VideoCrawl-Prod-Co3
goto :EOF
:sglab
title STCSRV-C92 corext searchgold bsdsearchgold 7727
cd /d F:\Code\SearchGold\
set inetroot=f:\code\searchgold&set corextbranch=searchgold&f:\code\searchgold\tools\path1st\myenv.cmd
cd /d f:\Code\SearchGold\deploy\builds\data\latest\MMCB\
goto :EOF
:vs
title Microsoft Visual Studio 11.0
"C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Tools\VsDevCmd.bat"
goto :EOF
:64
title build -cC -amd64
build -cC -amd64
goto :EOF
:kwd
title corext kirin_web_dev bgit-sdsearch 7763
set inetroot=z:\code\kirin_web_dev&set corextbranch=kirin_web_dev&z:\code\kirin_web_dev\tools\path1st\myenv.cmd
cd /d z:\code\kirin_web_dev\
goto :EOF
:kwdlab
title STCSRV-C92 corext kirin_web_dev bgit-sdsearch 7763
set inetroot=f:\code\kirin_web_dev&set corextbranch=kirin_web_dev&f:\code\kirin_web_dev\tools\path1st\myenv.cmd
cd /d f:\code\kirin_web_dev\
goto :EOF
:mm
title corext kirin_web_dev_mm bgit-sdsearch 7763
set inetroot=z:\code\kirin_web_dev_mm&set corextbranch=kirin_web_dev_mm&z:\code\kirin_web_dev_mm\tools\path1st\myenv.cmd
cd /d z:\code\kirin_web_dev_mm\
goto :EOF
:mmig
title corext multimediaig bgit-sdsearch 7763
set inetroot=z:\code\multimediaig&set corextbranch=multimediaig&z:\code\multimediaig\tools\path1st\myenv.cmd
cd /d z:\code\multimediaig\
goto :EOF
:live
title corext kirin_web_dev_mm_live bgit-sdsearch 7763
set inetroot=z:\code\kirin_web_dev_mm_live&set corextbranch=kirin_web_dev_mm_live&z:\code\kirin_web_dev_mm_live\tools\path1st\myenv.cmd
cd /d z:\code\kirin_web_dev_mm_live\
goto :EOF
:kwd03
title corext kirin_web_dev_03 bgit-sdsearch 7763
set inetroot=z:\code\kirin_web_dev_03&set corextbranch=kirin_web_dev_03&z:\code\kirin_web_dev_03\tools\path1st\myenv.cmd
cd /d z:\code\kirin_web_dev_03\
:mmlab
title STCSRV-C92 corext kirin_web_dev_mm bgit-sdsearch 7763
set inetroot=f:\code\kirin_web_dev_mm&set corextbranch=kirin_web_dev_mm&f:\code\kirin_web_dev_mm\tools\path1st\myenv.cmd
cd /d f:\Code\kirin_web_dev_mm\
goto :EOF
:vn
title corext kirin_web_dev_mm_vnext bgit-sdsearch 7763
set inetroot=z:\code\kirin_web_dev_mm_vnext&set corextbranch=kirin_web_dev_mm_vnext&z:\code\kirin_web_dev_mm_vnext\tools\path1st\myenv.cmd
cd /d z:\code\kirin_web_dev_mm_vnext\
goto :EOF
:vnlab
title STCSRV-C92 corext kirin_web_dev_mm_vnext bgit-sdsearch 7763
set inetroot=f:\code\kirin_web_dev_mm_vnext&set corextbranch=kirin_web_dev_mm_vnext&f:\code\kirin_web_dev_mm_vnext\tools\path1st\myenv.cmd
cd /d f:\Code\kirin_web_dev_mm_vnext\
goto :EOF
:cmd
title Console2
start D:\app\Consolez\Console.exe
goto :EOF
:da
title DA
pushd .
cd /d D:\DA
goto :EOF
:dalab
title STCSRV-C92 DA
pushd .
cd /d f:\DA
goto :EOF
:legacy
title private\indexgen\multimedia\legacy\msnbot\deploy\Crawler
pushd .
cd /d %inetroot%\private\indexgen\multimedia\legacy\msnbot\deploy\Crawler
goto :EOF
:mmda
title private\indexgen\multimedia\MMDocumentAnalysis
pushd .
cd /d %inetroot%\private\indexgen\multimedia\MMDocumentAnalysis
goto :EOF
:bw
title private\indexgen\multimedia\BlueWhale
pushd .
cd /d %inetroot%\private\indexgen\multimedia\BlueWhale
goto :EOF
:mediacrawler
title private\indexgen\multimedia\mediacrawler
pushd .
cd /d %inetroot%\private\indexgen\multimedia\mediacrawler
goto :EOF
:mediaprocessor
title private\indexgen\multimedia\mediaprocessor
pushd .
cd /d %inetroot%\private\indexgen\multimedia\mediaprocessor
goto :EOF
:cosmos
title Local cosmos data
pushd .
cd /d Z:\Data\COSMOSData\
goto :EOF
:db
title Dropbox
pushd .
cd /d C:\Users\bichongl\Dropbox
goto :EOF
:word
start winword
goto :EOF
:xls
start EXCEL.EXE
goto :EOF
:ew
title emacs-24.3
pushd .
cd /d %HOME%
goto :EOF
:`
title edit `.cmd
pushd .
start n C:\Users\bichongl\OneDrive\app\`.cmd
goto :EOF
:tps
title start TPSUtilGui.exe
pushd .
start D:\app\tpsutil\TPSUtilGui.exe
goto :EOF
:init.el
title init.el
pushd .
runemacs %HOME%\.emacs.d\init.el
goto :EOF
:sm
title Z:\Data\SearchGold\deploy\builds\data\Sangam_Partners\sangam-prod2\BlueWhale
pushd .
cd /d Z:\Data\SearchGold\deploy\builds\data\Sangam_Partners\sangam-prod2\BlueWhale
goto :EOF
:bn1
title Z:\Data\APGold\AutopilotService\Bn1\VideoCrawl-PPE-Bn1
pushd .
cd /d Z:\Data\APGold\AutopilotService\Bn1\VideoCrawl-PPE-Bn1
goto :EOF
:co3
title Z:\Data\APGold\AutopilotService\Co3\VideoCrawl-Prod-Co3
pushd .
cd /d Z:\Data\APGold\AutopilotService\Co3\VideoCrawl-Prod-Co3
goto :EOF
:bj1
title Z:\Data\APGold\AutopilotService\BJ1\videocrawl-prod-bj1
pushd .
cd /d Z:\Data\APGold\AutopilotService\BJ1\videocrawl-prod-bj1
goto :EOF
:multimedia
title %INETROOT%\private\indexgen\multimedia
pushd .
cd /d %INETROOT%\private\indexgen\multimedia
goto :EOF
:dk
title Desktop
pushd .
cd /d C:\Users\bichongl\Desktop\
dir
goto :EOF
:mmcb
title Z:\Data\SearchGold\deploy\builds\data\latest\MMCB\
pushd .
cd /d Z:\Data\SearchGold\deploy\builds\data\latest\MMCB\
dir
goto :EOF
:vcppe
title Z:\Data\SearchGold\deploy\builds\data\latest\MMCB\mmrv1\ppe\video\
pushd .
cd /d Z:\Data\SearchGold\deploy\builds\data\latest\MMCB\mmrv1\ppe\video\
goto :EOF
:vcprod
title Z:\Data\SearchGold\deploy\builds\data\latest\MMCB\mmrv1\prod\video\
pushd .
cd /d Z:\Data\SearchGold\deploy\builds\data\latest\MMCB\mmrv1\prod\video\
dir
goto :EOF
:mmrv2
title Z:\Data\SearchGold\deploy\builds\data\latest\MMCB\mmrv2\prodco3c\video
pushd .
cd /d Z:\Data\SearchGold\deploy\builds\data\latest\MMCB\mmrv2\prodco3c\video
dir
goto :EOF
:mmcblab
title STCSRV-C92 Z:\Data\SearchGold\deploy\builds\data\latest\MMCB\
pushd .
cd /d f:\Code\SearchGold\deploy\builds\data\latest\MMCB\
goto :EOF
:mpin
title D:\onebox\data\mediaprocessor
pushd .
cd /d D:\onebox\data\mediaprocessor
goto :EOF
:log
title D:\onebox\data\Logs\local
pushd .
cd /d D:\onebox\data\Logs\local
goto :EOF
:fd
pushd .
cd /d Z:\Data\SearchGold\deploy\builds\data\latest\mmfeeds
dir
goto :EOF
:mbout
title D:\onebox\data\msnbot\output
pushd .
cd /d D:\onebox\data\msnbot\output
goto :EOF
:clean
del /q D:\onebox\data\Msnbot\Push\Temp\*
del /q D:\onebox\data\Msnbot\Push\Cache\*
del /q D:\onebox\data\Msnbot\TempOutput\*.hdc
del /q D:\onebox\data\Msnbot\Frontier\*
del /q D:\onebox\data\Msnbot\UrlSeen\*
del /q D:\onebox\data\Msnbot\MetadataStore\*
del /q D:\onebox\data\msnbot\inputtracker\*
del /q /s D:\onebox\data\MediaProcessor\input\*
del /q /s D:\onebox\data\MediabotTemp
del /q /s D:\onebox\data\MMRepo\push\*
del /q /s D:\onebox\data\MMRepo\service\*
del /q /s D:\onebox\data\msnbot\output\*
rd /q /s D:\onebox\data\PlayListDump
del /q D:\onebox\data\msnbot\tempoutput\*.hdc
del /q D:\onebox\data\msnbot\frontier\*.temp
del /q D:\onebox\data\Logs\local\*.log
goto :EOF
:startmb
title kirin_web_dev_mm debug mbcrawler msnbotsvc -debug mediabot
cd /d z:\code\kirin_web_dev_mm\target\distrib\debug\amd64\app\mbcrawler
msnbotsvc -debug mediabot
goto :EOF
:config
title kirin_web_dev_mm debug config.ini
pushd .
gvim %INETROOT%\target\distrib\debug\amd64\app\mbcrawler\config.ini
goto :EOF
:mb
title kirin_web_dev_mm debug mbcrawler
pushd .
cd /d %INETROOT%\target\distrib\debug\amd64\app\mbcrawler
goto :EOF
:mp
title kirin_web_dev_mm debug mediaprocessor
pushd .
cd /d %INETROOT%\target\distrib\debug\amd64\app\mediaprocessor
goto :EOF
:proxy
title show proxy
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer
goto :EOF
:noproxy
title  reset proxy
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "" /f
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer
goto :EOF
:bjs
title bjsproxy:80
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "bjsproxy:80" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "" /f
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer
goto :EOF
:itg
title "itgproxy:80"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "itgproxy:80" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "" /f
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer
goto :EOF
:jpn
title jpnproxy:80
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "jpnproxy:80" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "" /f
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer
goto :EOF
:hk
title netsh winhttp set proxy "hkproxy:80"
REM http://itweb/v7/Information/Pages/Proxy/RegionalProxyList.aspx
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "hkproxy:80" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "" /f
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer
goto :EOF


:help
@echo off
rem doskey /macros
start .
goto :EOF
