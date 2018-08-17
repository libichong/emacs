{Dos2Clip - copyright 2005 Thornsoft Development, Inc.  All rights reserved.}
program Clip2Dos;

{$APPTYPE CONSOLE}

uses
  Clipbrd,
  ExceptionLog,
  SysUtils;

var
   p : Array[0..1024] of Char;
begin
  try
    WriteLn('Clip2DOS Copyright 2006 Thornsoft Development');
    Clipboard.GetTextBuf(p,1024);
    WriteLn(p);
  except
    //Handle error condition
    on E: Exception do
            begin
              beep;
              Writeln(SysUtils.format('Clip2DOS - Error: %s',[E.Message]));
              ExitCode := 1;    //Set ExitCode <> 0 to flag error condition (by convention)
            end;
  end
end.
