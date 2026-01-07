@echo off

setlocal enabledelayedexpansion

set "studiomdl=%~dp0cestudiomdl.exe"
set "path=%~1"
set "args=%~2"

::echo %args%

"%studiomdl%" -nop4 -verbose -fastbuild %args% "%path%"

pause