@echo off

for /f %%g IN ('RadioButtonBox.exe "Launch;Configure" "Select to Launch" "X-Wing Alliance Launcher"') do set launch=%%g

if /i "%launch%"=="Configure" goto :StartConfig
if /i "%launch%"=="Launch" goto :LaunchGame

goto commonexit

:StartConfig
TotalConverter\BabuFriksConfigurator.exe
goto commonexit

:LaunchGame
XWINGALLIANCE.EXE
goto commonexit

:commonexit
exit /B 0
