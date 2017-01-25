@echo off

SET PRJDIR=%1

REM Load Visual Studio's build tools
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\vsvars32.bat"

FORFILES /P %PRJDIR% /M *.sln /S /C "cmd /C msbuild /nologo @path /p:Configuration=Debug /V:q"

REM if errorlevel 1 goto buildError
REM mstest /nologo /noresults /testcontainer:%PRJDIR%\UnitTests\bin\Debug\UnitTests.dll

:buildError
pause
