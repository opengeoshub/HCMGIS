@echo off
@REM call "C:\OSGeo4W64\bin\o4w_env.bat"
@REM call "C:\OSGeo4W64\bin\qt5_env.bat"
@REM call "C:\OSGeo4W64\bin\py3_env.bat"
rem pyrcc6 -o resources.py resources.qrc
rem pyuic6 -x %%i -o ui_%%~ni.py
@echo on
rem pyuic6 -o resources.py resources.qrc
for %%i in (*.ui) do (
	python -m PyQt6.uic.pyuic -x %%i -o %%~ni.py

)
pause 