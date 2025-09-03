@echo off

setlocal enabledelayedexpansion

set "studiomdl=%~dp0/studiomdl.exe"
set "path=%~1"
set "args=%~2"

::echo %args%

"%studiomdl%" -nop4 -verbose %args% "%path%"

pause