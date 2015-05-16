@setlocal
@setlocal enableextensions
@for %%i in (%0) do @set gs=%%~dpi
@if exist %gs%\vsd @goto gsok
@for %%i in (vsd.bat) do @set gs=%%~dp$PATH:i
@if exist %gs%\vsd @goto gsok
@echo Could not find vsd location
@verify other 2>nul
@goto done
:gsok
@%gs%\vsdwishWindows_NT %gs%\vsd %*
:done
