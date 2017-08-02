@echo off
pushd C:\app\emacs\
git pull
git add *
git commit -a -m "Auto commit from emacs"
git push
