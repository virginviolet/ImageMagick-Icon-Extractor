@echo off
setlocal enabledelayedexpansion

rem Check if ImageMagick is installed
magick -version >nul 2>&1
if errorlevel 1 (
    echo ImageMagick is not installed. Please install ImageMagick and try again.
    exit /b 1
)

echo Usage: extract_icons {input_file} [outfiles_format]

rem Input ICO file path
set "inputfilepath=%~f1"

rem Input ICO file, without file extension
set "inputfile=%~n1"

rem Input ICO file extension, which should be ICO, but just in case
set "inputext=%~x1"

rem Directory to extract icons to
set "outdir=!inputfile!_extracted"

echo.
echo Input file information:
magick identify "!inputfilepath!"
echo.

rem Output file format for each icon to icons.log 
magick identify -format "%%m\n" "!inputfilepath!" >icons.log

echo Extracting icons.

rem Create the output directory
mkdir "!outdir!"

rem Line number when parsing icons.log
set "lineNumber=-1"

rem Extract icon for each line in icons.log
for /f "tokens=*" %%a in (icons.log) do (
    set /a lineNumber+=1
    
    rem Convert to format from command line parameter if provided, else preserve format
    if "%2" neq "" (
        set "outformat=%2"
    ) else (
        set "outformat=%%a"
    )

    magick "!inputfilepath!"[!lineNumber!] "!inputfile!-!lineNumber!.!outformat!"
    if !errorlevel! equ 0 (
        move "!inputfile!-!lineNumber!.!outformat!" "!outdir!\!inputfile!-!lineNumber!.!outformat!" >nul
        echo Extracted !inputfile!-!lineNumber!.!outformat!.
    )
)

rem Remove the new diretory if it is empty (i.e. failed to extract) 
rd /q !outdir! 2>nul

del icons.log
echo Extraction complete.
