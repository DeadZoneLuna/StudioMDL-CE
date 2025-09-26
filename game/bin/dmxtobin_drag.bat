@echo off

cd /D %~dp0
echo workingDir = %cd%

IF "%~1"=="" (
    echo File required.
    pause
    exit /b
)

SET input_file=%~1
SET output_file=%~dpn1_bin.dmx

"%cd%\dmxconvert.exe" -i "%input_file%" -o "%output_file%" -oe binary

echo File processed into "%output_file%".
pause