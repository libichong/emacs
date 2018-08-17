@echo off
@echo off
call init.cmd
if "%~1"=="" goto :help
if "%~1"=="open" goto :open
if "%~1"=="list" goto :list
if "%~1"=="grep" goto :grep
if "%~1"=="user" goto :user
if "%~1"=="job" goto :job
if "%~1"=="last" goto :last
if "%~1"=="id" goto :id
goto :EOF
:open
set url=%~2
set root=https://cosmos08.osdinfra.net/cosmos/MMRepository.prod
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
:list
scope joblist -vc https://cosmos08.osdinfra.net/cosmos/MMRepository.prod -submittedby phx\bichongl
goto :EOF
:grep
((scope joblist -vc https://cosmos08.osdinfra.net/cosmos/MMRepository.prod -submittedby PHX\CO3SCH010100612$)|grep -B 2 -A 2 %~2)
goto :EOF
:last
if "%~2" == "" ((scope joblist -vc https://cosmos08.osdinfra.net/cosmos/MMRepository.prod -submittedby PHX\bichongl)|grep -A 6 -m 1 "Job ID:") else (scope joblist -vc https://cosmos08.osdinfra.net/cosmos/MMRepository.prod -submittedby PHX\CO3SCH010100612$)|grep -B 2 -A 3 -m 1 %~2
goto :EOF
:user
scope joblist -vc https://cosmos08.osdinfra.net/cosmos/MMRepository.prod -submittedby PHX\%~2
goto :EOF
:job
scope jobstatus %~2 -vc https://cosmos08.osdinfra.net/cosmos/MMRepository.prod
goto :EOF
:id
start https://cosmos08.osdinfra.net/cosmos/MMRepository.prod/_Jobs/%~2
goto :EOF
:help
scope help
goto :EOF