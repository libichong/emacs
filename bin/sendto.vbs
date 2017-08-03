Set objShell = WScript.CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

If WScript.Arguments.Count = 1 Then
   objShell.Run("c:/sys/emacs-23.3/bin/emacsclientw.exe -na ""E:/app/emacs-24.3/bin/runemacs.exe"" """ & WScript.Arguments(0) & """")
Else
   objShell.Run("c:/sys/emacs-23.3/bin/emacsclientw.exe -na ""E:/app/emacs-24.3/bin/runemacs.exe"" ")
end If
