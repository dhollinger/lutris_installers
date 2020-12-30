@echo off

for /f %%g IN ('RadioButtonBox.exe "X-Wing Alliance;Babu Frik's Configurator;Palpatine Total Converter" "Select to Launch" "X-Wing Alliance Launcher"') do set launch=%%g

if /i "%launch%"=="Babu" goto :StartConfig
if /i "%launch%"=="Palpatine" goto :StartConverter
if /i "%launch%"=="X-Wing" goto :LaunchGame

goto commonexit

:StartConfig
TotalConverter\BabuFriksConfigurator.exe
goto commonexit

:StartConverter
TotalConverter\PalpatineTotalConverter.exe
goto commonexit

:LaunchGame
XWINGALLIANCE.EXE
goto commonexit

:commonexit
exit /B 0
