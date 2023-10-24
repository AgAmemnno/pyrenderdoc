@echo off
setlocal EnableDelayedExpansion
set CURR_DIR=%cd%
set PYRENDERDOC_LIB=%cd%\pyrenderdoc\lib
set PYRENDERDOC_DATA=%cd%\pyrenderdoc\data
set mode="%1"


CALL :get_python36
IF %ERRORLEVEL% NEQ 0 goto end
ECHO found python36 %py%\python.exe
CALL :flush_resource


If %mode% == "install" (
    CALL :install_resource
    chdir %CURR_DIR%
    cd ..
    call %py%\python.exe -m pip install ./pyrenderdoc
    goto end
)

if %mode% == "uninstall" (
    call %py%\python.exe -m pip uninstall pyrenderdoc
    goto end
)

echo please specify setup.bat [install/uninstall]
goto end


:get_python36
set ret=0
chdir C:\
set py=""
FOR /F "delims=" %%i IN  ('dir /s /b python36') DO IF EXIST %%i\python.exe (set py=%%i)
IF %py% EQU "" ( 
    ECHO Not Found Python36.
    set ret=1
)
exit /b ret

:flush_resource
IF EXIST %py%\Tools\pyrenderdoc (echo Y |RD /S %py%\Tools\pyrenderdoc > nul)
IF EXIST %py%\libs\renderdoc.dll (echo Y |DEL %py%\libs\renderdoc.dll > nul)
IF EXIST %py%\libs\d3dcompiler_47.dll (echo Y |DEL %py%\libs\d3dcompiler_47.dll > nul)
IF EXIST %py%\libs\renderdoc.pyd (echo Y |DEL %py%\libs\renderdoc.pyd > nul)
IF EXIST %py%\libs\dbghelp.dll (echo Y |DEL %py%\libs\dbghelp.dll > nul)
IF EXIST %py%\libs\symsrv.dll (echo Y |DEL %py%\libs\symsrv.dll > nul)
exit /b 0

:install_resource
mkdir %py%\Tools\pyrenderdoc
mkdir %py%\Tools\pyrenderdoc\vk
FORFILES /P %PYRENDERDOC_DATA%\vk /M *.rdc /C "cmd /c copy @path %py%\Tools\pyrenderdoc\vk\@file > nul"
mkdir %py%\Tools\pyrenderdoc\gl
FORFILES /P %PYRENDERDOC_DATA%\gl /M *.rdc /C "cmd /c copy @path %py%\Tools\pyrenderdoc\gl\@file > nul"
COPY %PYRENDERDOC_LIB%\renderdoc.dll %py%\libs\renderdoc.dll > nul
COPY %PYRENDERDOC_LIB%\d3dcompiler_47.dll %py%\libs\d3dcompiler_47.dll > nul
COPY %PYRENDERDOC_LIB%\renderdoc.pyd %py%\libs\renderdoc.pyd > nul
COPY %PYRENDERDOC_LIB%\dbghelp.dll %py%\libs\dbghelp.dll > nul
COPY %PYRENDERDOC_LIB%\symsrv.dll %py%\libs\symsrv.dll > nul
exit /b 0

:end