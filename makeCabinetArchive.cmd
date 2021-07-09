@ECHO OFF 
ECHO In this example, "tar" folder is being compressed that exists in %~dp0 (at the same directory as this .cmd file when executed).
ECHO.

ECHO  Folder to compress: %~dp0tar
ECHO  Cabinet file output: %~dp0output\cabinetFile.cab

ECHO Listing paths of files that will be archived, and saving them into a File
DIR "%~dp0tar" /s /b /a-d > "%~dp0files.txt"

ECHO Creating a new folder.
MKDIR "%~dp0CompressedCabinetFiles"

ECHO Temporary moving inside a new folder.
PUSHD "%~dp0CompressedCabinetFiles"

ECHO Archiving files listed in "%~dp0files.txt" into a .cab file: "%~dp0output\cabinetFile.cab"
makecab /d "CabinetName1=cabinetFile.cab" /D "DiskDirectoryTemplate=%cd%\output" /f "%~dp0files.txt"

ECHO Create self-extracting .exe executable file.
COPY /b "%windir%\system32\extrac32.exe"+"%~dp0CompressedCabinetFiles\output\cabinetFile.cab" "%~dp0CompressedCabinetFiles\output\cabinetFile.exe"

ECHO 1. Testing the extraction of the cabinet file.
MKDIR "%~dp0CompressedCabinetFiles\extractionTestUsingExpand"
expand "%~dp0CompressedCabinetFiles\output\cabinetFile.cab" -F:* "%~dp0CompressedCabinetFiles\extractionTestUsingExpand"

ECHO 2. Testing the extraction of the cabinet file.
MKDIR "%~dp0CompressedCabinetFiles\extractionTestUsingExtrac32"
extrac32 "%~dp0CompressedCabinetFiles\output\cabinetFile.cab" /L "%~dp0CompressedCabinetFiles\extractionTestUsingExtrac32\"
ECHO Note: seems to not produce even for me in Windows 10

ECHO Leaving the folder.
POPD

ECHO Deleting temporary files.
DEL "%~dp0files.txt"

PAUSE