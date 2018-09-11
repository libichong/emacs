@rem !!! Do not change this file in-place, change its copy instead !!!
@rem !!!  Otherwise you will lose your settings after next update  !!!

@echo off
doskey ll = ls -l
doskey l = dir
doskey dkh = doskey /history
doskey dkm = doskey /macros
doskey dkc = doskey /reinstall
doskey cc = echo %cd% $g$g dos2clip
doskey ..=cd ..
doskey .=start .
doskey code=pushd D:\code
doskey np="C:\Program Files (x86)\Notepad++\notepad++.exe" $*
doskey ls=dir /ONE $*
doskey cd=cd /d $*
doskey python=python -ic ""
doskey ps=tasklist $*
doskey alias=if ".$*." == ".." ( doskey /MACROS ) else ( doskey $* )
doskey kill=taskkill /IM $*
doskey mc=mkdir $1$tcd $1
doskey fb=build -cC -amd64$Tbuild -cC -amd64 retail
doskey b64=build -cC -amd64
doskey b64r=build -cC -amd64 retail
doskey vh = pushd C:\VIM
doskey eh = pushd D:\app\emacs-24.3/
doskey c = pushd C:
doskey d = pushd D:
doskey pd = pushd $*
doskey pp = popd

