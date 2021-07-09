@ECHO OFF 
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

ECHO Testing the extraction of the cabinet file.
MKDIR "%~dp0CompressedCabinetFiles\extractionTest"
expand "%~dp0CompressedCabinetFiles\output\cabinetFile.cab" -F:* "%~dp0CompressedCabinetFiles\extractionTest"

ECHO Leaving the folder.
POPD

ECHO Deleting temporary files.
DEL "%~dp0files.txt"

PAUSE