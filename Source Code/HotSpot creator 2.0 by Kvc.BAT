@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=D:\kvc\my_Work\Kvc_products_\Hotspot Creator\Ver.2.0\Hotspot Creator.exe
REM BFCPEICON=D:\kamal\icons\Goomba_2.ico
REM BFCPEICONINDEX=-1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=1
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=2.0.0.0
REM BFCPEVERPRODUCT=Hotspot creator ver.2.0 by kvc
REM BFCPEVERDESC=Turns your Pc into Wifi Hotspot
REM BFCPEVERCOMPANY=Kvc Products
REM BFCPEVERCOPYRIGHT=Copyrights (c) 2015
REM BFCPEEMBED=D:\kvc\my_Work\Kvc_products_\Hotspot Creator\Ver.2.0\11215281_425156484276248_463666276_o.jpg
REM BFCPEEMBED=D:\kvc\my_Work\Kvc_products_\Hotspot Creator\Ver.2.0\batbox.exe
REM BFCPEEMBED=D:\kvc\my_Work\Kvc_products_\Hotspot Creator\Ver.2.0\Button.bat
REM BFCPEEMBED=D:\kvc\my_Work\Kvc_products_\Hotspot Creator\Ver.2.0\getlen.exe
REM BFCPEOPTIONEND
@ECHO ON
@echo off
CD files
:top
cls
Title HotSpot creator ver.2.0 by Kvc
echo.&echo.
color 0a
mode 80,25
set Lines=25
set Columns=80
set dir=%systemdrive%\system\Hotspot_Creator
setlocal enabledelayedexpansion
set path=%cd%;%path%;%myfiles%

if not exist "%dir%" (
	:first_run
	md "%dir%" 2>nul
	rem Setting up all buttons...and saving them to files...as it will be faster to load next time... 
	call Button.bat "Start Hotspot" 0c Invalid_start N 2 "Start HotSpot" 0a Valid_start N 2 "Stop Hotspot" 0c Invalid_stop N 2 "Stop HotSpot" 0a valid_stop N 2 "Exit" a0 Exit N 1 "Help" a0 Help N 1 "Apply Older Settings" 0c Invalid_old N 3 "Apply Older Settings" 0a valid_old N 3 "Add Newer Settings" 0c Invalid_new N 3 "Add Newer Settings" 0a valid_new N 3 "Back" a0 Back N 1 "Ok" 0a Ok N 2 "Reset" 0a Reset N 2 "Already Started" 0c Already_started N 2 "Not Allowed ..." 0c not_allowed N 2
	for %%a in (Invalid_start Invalid_stop Invalid_new Invalid_old Valid_start valid_new valid_old valid_stop Back Exit Help OK Reset Already_started not_allowed) do (
		echo.!%%a!>"!dir!\%%a.button"
		)
	goto :next
	)
set rebuilt=N
for %%a in (Invalid_start Invalid_stop Invalid_new Invalid_old Valid_start valid_new valid_old valid_stop Back Exit Help OK Reset Already_started not_allowed) do (
	if exist "!dir!\%%a.button" (Set /p %%a=<"!dir!\%%a.button") else (title Some files are missing from data base...rebuilding them && set rebuilt=Y)
	)
if /i "%rebuilt%" == "Y" (goto :first_run)

:next
batbox.exe /o 70 1 %exit% /o 60 1 %help%

rem checking Hotspot validity on your system...
netsh wlan show drivers | find "Hosted network supported">"%dir%\info.tmp"
for /f "delims=: tokens=2" %%A in (!dir!\info.tmp) do (set chance=%%A)
if /i "!chance: =!" neq "Yes" (
	batbox.exe /o 12 12 /d "The Hosted network cannot be started ...as Imp. Drivers are not Available !!"
	call :no_chance
	)
if /i "!chance: =!" == "Yes" (
	rem checking hotspot is activated or not...
	netsh wlan show hostednetwork | find "Status">"%dir%\info_.tmp"
	for /f "delims=: tokens=2" %%a in (%dir%\info_.tmp) do (set Status=%%a)
	if /i "!Status: =!" == "Started" (
		Set "start=%Invalid_start%"
		Set "Stop=%valid_stop%"
		) else (
		set "start=%Valid_start%"
		Set "Stop=%Invalid_stop%"
		)
	)
if exist "!dir!\last.settings" (Set "Old=%valid_old%") else (Set "old=%Invalid_old%")

:menu_top
cls
batbox.exe /o 15 11 %start% /o 45 11 %stop% /o 70 1 %exit% /o 60 1 %help%

:menu

for /f "delims=: tokens=1,2,3" %%a in ('batbox.exe /m') do (
	set button=%%c
	set x=%%a
	set y=%%b
	)
if /i "%button%" == "1" (
	if %x% geq 60 if %x% leq 68 if %y% geq 1 if %y% leq 3 (goto :help)
	if %x% geq 70 if %x% leq 78 if %y% geq 1 if %y% leq 3 (goto :end)
	if %x% geq 15 if %x% leq 32 if %y% geq 11 if %y% leq 13 (
		if /i "!status: =!" neq "Started" (goto :Start_it) else (goto top)
		)
	)
	if %x% geq 45 if %x% leq 61 if %y% geq 11 if %y% leq 13 (
		if /i "!status: =!" == "Started" (goto :stop_it) else (goto top)
	)
)	
goto :menu

:start_it
cls
batbox.exe /o 10 11 %old% /o 39 11 %valid_new% /o 50 1 %back% /o 70 1 %exit% /o 60 1 %help%

:start_it_top

for /f "delims=: tokens=1,2,3" %%a in ('batbox.exe /m') do (
	set button=%%c
	set x=%%a
	set y=%%b
	)
if /i "%button%" == "1" (
	if %x% geq 60 if %x% leq 68 if %y% geq 1 if %y% leq 3 (goto :help)
	if %x% geq 70 if %x% leq 78 if %y% geq 1 if %y% leq 3 (goto :end)
	if %x% geq 50 if %x% leq 58 if %y% geq 1 if %y% leq 3 (goto :top)
	if %x% geq 10 if %x% leq 33 if %y% geq 11 if %y% leq 13 (
		goto :chk_old_settings
	)
	if %x% geq 36 if %x% leq 62 if %y% geq 11 if %y% leq 13 (
		goto :new
		)
	)
)	
goto :start_it_top


:new
cls
echo.
echo.
set /p "ssid=Enter Name of Your Network : "
if not defined ssid goto new
:2
echo.
set /p "key=Enter Password of This Network : [Min. 8 char.] "
if not defined key goto 2
getlen.exe "%key%"
set size=%errorlevel%
if %size% lss 8 (
set key=
echo. The Password Should be atleast 8 Characters long....
goto 2
)
cls
goto 3

:3
cls
batbox.exe /o 70 1 %back%
echo.&echo.
echo. Please Wait !! Creating Hotspot ...
echo.%ssid%>"%dir%\last.settings"
netsh wlan set hostednetwork mode=allow ssid=%ssid% key=%key%
echo.&echo.
echo. Starting Hotspot ...
echo.%key%>>"%dir%\last.settings"
netsh wlan start hostednetwork
echo.&echo. All Commands Applied !!!
:4
for /f "delims=: tokens=1,2,3" %%a in ('batbox.exe /m') do (
	set button=%%c
	set x=%%a
	set y=%%b
	)
if /i "%button%" == "1" (
	if %x% geq 70 if %x% leq 78 if %y% geq 1 if %y% leq 3 (goto :top)
	)
goto :4

:stop_it
cls
batbox.exe /o 70 1 %back%
echo.
echo. Trying to Stop Hotspot ...
echo. Applying Commands ...
netsh wlan stop hostednetwork
echo. Command Applied ...!!!
:n_
for /f "delims=: tokens=1,2,3" %%a in ('batbox.exe /m') do (
	set button=%%c
	set x=%%a
	set y=%%b
	)
if /i "%button%" == "1" (
	if %x% geq 70 if %x% leq 78 if %y% geq 1 if %y% leq 3 (goto :top)
	)
goto :n_

:chk_old_settings
if not exist "%dir%\last.settings" (echo.&echo. No Settings are Saved about your last Hotspot... && goto start_it)
echo.&echo.
echo. Please Wait ... Applying Older Settings ...
set count=1
for /f "tokens=*" %%a in (%dir%\last.settings) do set "line_!count!=%%a"&&set /a count+=1
echo. Network Name : !line_1!
echo. Network key : !line_2!
set ssid=%line_1%
set key=%line_2%
goto 3


:no_chance
cls
batbox.exe /o 70 1 %back%
echo.&echo.
echo. Your System donot have Sufficient Drivers to Create Hotspot... !!!
echo. 
echo. Please Update Your Drivers...or Update Windows ...
echo.&echo.&echo.
echo. OR Your Wireless Adapter May Be Switched Off... TroubleShoot this Problem First !!!
echo.&echo. #kvc
echo. &echo. Press any key to exit... !!
:no_
for /f "delims=: tokens=1,2,3" %%a in ('batbox.exe /m') do (
	set button=%%c
	set x=%%a
	set y=%%b
	)
if /i "%button%" == "1" (
	if %x% geq 70 if %x% leq 78 if %y% geq 1 if %y% leq 3 (goto :top)
	)
goto :no_

:help
cls
batbox.exe /o 70 1 %back%
echo.
echo.
echo. The red colored option / Button shows that it is unavailable...
echo. and the green color button shows the Available options...tat can be clicked...
echo. How ever...some red colored buttons can also be clicked ..but it has no change
echo. to the current situation...
echo.
echo. this version of Hotspot creator is 55%% faster and is easy to use...than ver.1.0
echo. Created by #kvc
:help_
for /f "delims=: tokens=1,2,3" %%a in ('batbox.exe /m') do (
	set button=%%c
	set x=%%a
	set y=%%b
	)
if /i "%button%" == "1" (
	if %x% geq 70 if %x% leq 78 if %y% geq 1 if %y% leq 3 (goto :top)
	)
goto :help_


:end
exit /b