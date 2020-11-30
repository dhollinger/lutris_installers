@echo off
FOR /F "tokens=*" %%g IN ('RadioButtonBox.exe "Launch;Configure" "Select to Launch" "X-Wing Alliance Launcher"') do (SET VAR=%%g)

if %VAR%==Configure (TotalConverter\BabuFriksConfigurator.exe) else (XWINGALLIANCE.EXE)
