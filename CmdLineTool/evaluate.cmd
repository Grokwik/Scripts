echo @off
set CURRENTDIR=C:\Dev\CmdLineTool\
set QUALIFDIR=C:\Dev\Qualif
set VSTESTPATH="C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\CommonExtensions\Microsoft\TestWindow"
set TRX2HTML=%0\TrxerConsole.exe

set PATH=%PATH%;%VSTESTPATH%

REM ###################################################

REM Load Visual Studio's build tools
REM call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\vsvars32.bat"

REM	Building the projects
REM FORFILES /P %QUALIFDIR% /M *.sln /S /C "cmd /C msbuild /nologo @path /p:Configuration=Debug /V:q"

REM	Cleaning the TRX files
del %CURRENTDIR%*.html
del %CURRENTDIR%*.trx
FORFILES /P %QUALIFDIR% /M *.trx /S /C "cmd /C del @path"

REM	Generating brand new TRX files
FORFILES /P %QUALIFDIR% /M *Tests.dll /S /C "cmd /C vstest.console.exe @path /Logger:trx"

REM	Copying the TRX files locally
FORFILES /P %QUALIFDIR% /M *.trx /S /C "cmd /C copy @path %CURRENTDIR%"

REM	Generating the HTML files with the TRX
FORFILES /P %CURRENTDIR% /M *.trx /S /C "cmd /C TrxerConsole.exe @path"

del %CURRENTDIR%*.trx
pause

