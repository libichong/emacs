@echo off
call init.cmd
if "%~1"=="" goto :help
if "%~1"=="open" goto :open
if "%~1"=="view" goto :view
if "%~1"=="list" goto :list
if "%~1"=="grep" goto :grep
if "%~1"=="user" goto :user
if "%~1"=="job" goto :job
if "%~1"=="last" goto :last
if "%~1"=="id" goto :id
if "%~1"=="mmd" goto :mmd
if "%~1"=="get" goto :get
goto :EOF
:open
set url=%~2
set root=https://cosmos08.osdinfra.net/cosmos/MMDiscovery
if "%~2" == "" start %root%/
if [%url:~0,4%]==[http] (
	start %url%
) else (
	if [%url:~0,1%]==[/] (
		start %root%%url%/
	) else (
		start %root%/%url%/
	)
)
goto :EOF
:view
set url=%~2
set root=https://cosmos08.osdinfra.net/cosmos/MMDiscovery
if "%~2" == "" start %root%/
if [%url:~0,4%]==[http] (
	start %url%?property=info
) else (
	if [%url:~0,1%]==[/] (
		start %root%%url%?property=info
	) else (
		start %root%/%url%?property=info
	)
)
goto :EOF
:get
set url=%~2
set root=https://cosmos08.osdinfra.net/cosmos/MMDiscovery
if "%~2" == "" start %root%/
if [%url:~0,4%]==[http] (
	start %url%
) else (
	set "file=%root%%url%"
	echo %file%
	Set "newfile=%~nx2"
	scope copy %file% %newfile% -overwrite
)
goto :EOF
:list
scope joblist -vc https://cosmos08.osdinfra.net/cosmos/MMDiscovery -submittedby phx\bichongl
goto :EOF
:grep
((scope joblist -vc https://cosmos08.osdinfra.net/cosmos/MMDiscovery -submittedby PHX\CO3SCH010100612$)|grep -B 2 -A 3 %~2)
goto :EOF
:last
if "%~2" == "" ((scope joblist -vc https://cosmos08.osdinfra.net/cosmos/MMDiscovery -submittedby PHX\bichongl)|grep -A 6 -m 1 "Job ID:") else (scope joblist -vc https://cosmos08.osdinfra.net/cosmos/MMDiscovery -submittedby PHX\CO3SCH010100612$)|grep -B 2 -A 3 -m 1 %~2
goto :EOF
:user
scope joblist -vc https://cosmos08.osdinfra.net/cosmos/MMDiscovery -submittedby PHX\%~2
goto :EOF
:job
scope jobstatus %~2 -vc https://cosmos08.osdinfra.net/cosmos/MMDiscovery
goto :EOF
:id
start https://cosmos08.osdinfra.net/cosmos/MMDiscovery/_Jobs/%~2
goto :EOF
:mmd
n2 C:\Users\bichongl\OneDrive\app\mmd.cmd
goto :EOF
:help
scope help
goto :EOF