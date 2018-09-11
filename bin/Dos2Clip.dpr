{Dos2Clip - copyright 2005 Thornsoft Development, Inc.  All rights reserved.}
program Dos2Clip;

{$APPTYPE CONSOLE}

uses
  Clipbrd,
  ExceptionLog,
  SysUtils;

var
   s : string;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  try
    WriteLn('Dos2Clip Copyright 2005 Thornsoft Development');
    ReadLn(s);
    Clipboard.SetTextBuf(PChar(s));
    WriteLn(SysUtils.Format('[%s] Copied to Clipboard',[s]));
  except
    //Handle error condition
    on E: Exception do
            begin
              beep;
              Writeln(SysUtils.format('Dos2Clip - Error: %s',[E.Message]));
              ExitCode := 1;    //Set ExitCode <> 0 to flag error condition (by convention)
            end;
  end
end.
