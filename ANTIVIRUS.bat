@echo off


setlocal enabledelayedexpansion
set "ESC="
set "RESET=%ESC%[0m"

chcp 65001 >nul

:Booting
echo ⚠️ This is NOT a real antivirus.
It uses built-in Windows tools and simple batch logic.
For real malware removal, always use trusted security software.
pause
cls
echo %ESC%[38;2;0;255;255mNeed protection?%RESET%
title Yeah!
timeout /t 2 >nul
echo %ESC%[38;2;0;224;255mTired of endless fake untrustable anti-viruses?%RESET%
title Yea...
timeout /t 2 >nul
echo %ESC%[38;2;0;192;255mEven those that are legit but still suck?%RESET%
title Those suck!
timeout /t 3 >nul
echo %ESC%[38;2;0;160;255mWell say no more with ANTI-VIRUS.BAT%RESET%
title heck yeah
timeout /t 2 >nul
title ANTI-VIRUS!
goto Home

:Home
cls
echo.
echo.
echo %ESC%[38;2;0;0;255m █████╗ ███╗   ██╗████████╗██╗      ██╗   ██╗██╗██████╗ ██╗   ██╗███████╗%RESET%
echo %ESC%[38;2;0;32;255m██╔══██╗████╗  ██║╚══██╔══╝██║      ██║   ██║██║██╔══██╗██║   ██║██╔════╝%RESET%
echo %ESC%[38;2;0;64;255m███████║██╔██╗ ██║   ██║   ██║█████╗██║   ██║██║██████╔╝██║   ██║███████╗%RESET%
echo %ESC%[38;2;0;96;255m██╔══██║██║╚██╗██║   ██║   ██║╚════╝╚██╗ ██╔╝██║██╔══██╗██║   ██║╚════██║%RESET%
echo %ESC%[38;2;0;128;255m██║  ██║██║ ╚████║   ██║   ██║       ╚████╔╝ ██║██║  ██║╚██████╔╝███████║%RESET%
echo %ESC%[38;2;0;160;255m╠═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝        ╚═╦═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝%RESET%
echo %ESC%[38;2;0;192;255m║                                       ║%RESET%
echo %ESC%[38;2;0;224;255m║                                      ╔╝%RESET%
echo %ESC%[38;2;0;255;255m║                                      ╚Type "help" to view a list of available commands%RESET%
echo %ESC%[38;2;0;255;255m╠═Gotta keep ya protected 🛡️%RESET%
echo %ESC%[38;2;0;255;255m║
:UserInputPart
set userinput=
set /p userinput="%ESC%[38;2;0;255;255m╚═%USERNAME%>>"

if /i "%userinput%"=="help" goto Help
if /i "%userinput%"=="malwareremover" goto MalwareRemover
if /i "%userinput%"=="scansfc" goto scansfc
if /i "%userinput%"=="clear" goto Home
if /i "%userinput%"=="cls" goto Home
if /i "%userinput%"=="blockstun" goto blockstun
if /i "%userinput%"=="quit" exit
if /i "%userinput%"=="unblockstun" goto unblockstun
if /i "%userinput%"=="exit" exit
if /i "%userinput%"=="viewfirewallrules" goto viewfirewallrules

:Invalid
echo.
echo ╔═[ERROR] Invalid Command.
echo ╠═"%userinput%" is not recognised as a command/action
goto UserInputPart

:Help
echo.
echo ╔═Help - Shows a list of available commands
echo ╠═malwareremover - Preform a scan that removes infected system files and viruses.
echo ╠═scansfc - repairs corrupted or missing files using cached copies stored on your PC.
echo ╠═clear/cls - clears everything on screen and restarts the title.
echo ╠═blockstun - blocks stun protocols that hackers may use to get your IP address.
echo ╠═quit/exit - exit/quit
echo ╠═unblockstun - unblock stun protocols [NOT RECOMMENDED]
echo ╠═viewfirewallrules - open wf.msc/wd with advanced security
goto UserInputPart

:MalwareRemover
echo.
echo ╔═[INFO] This will open the official mrt tool for windows.
echo ╠═Launching.
start mrt
goto UserInputPart

:scansfc
echo.
echo ╔═[INFO] Admin-level command.
echo ╠═Scanning...
net session >nul 2>&1
if %errorlevel% neq 0 (
echo ╠═[ERROR] Not admin.
goto UserInputPart
) else (
echo ╚═This may take a while, closing the window will leave partially repaired files.
echo.
sfc /scannow >nul
if %errorlevel% equ 0 (
echo ╔═Success!
) else if %errorlevel% equ 1 (
    echo ╔═[ERROR] Failed to run.
)
goto UserInputPart
)

:blockstun
echo.
set "found="
echo ╔═[INFO] Admin-level command.
net session >nul 2>&1
if %errorlevel% neq 0 (
echo ╠═[ERROR] Not admin.
goto UserInputPart
) else (
echo ╠═Creating wf.msc rule.
for /f "delims=" %%A in ('netsh advfirewall firewall show rule name^="stun block" ^| find "stun block"') do set found=1

if defined found (
    echo ╠═Stun protocols are already blocked!
) else (
netsh advfirewall firewall add rule name="stun block" dir=out action=block protocol=UDP remoteport=3478 >nul
if %errorlevel% equ 0 (
echo ╠═Success!
) else if %errorlevel% equ 2 (
echo ╠═[ERROR] System-level failure occured.
) else (
echo ╠═[ERROR] Not admin.
)
)
goto UserInputPart
)

:unblockstun
echo.
echo ╔═[INFO] Admin-level command.
net session >nul 2>&1
if %errorlevel% neq 0 (
echo ╠═[ERROR] Not Admin!
goto UserInputPart
) else (
echo ╠═Deleting stun protection rules.
netsh advfirewall firewall delete rule name="stun block" dir=out >nul
if %errorlevel% equ 0 (
echo ╠═Success!
) else if %errorlevel% equ 2 (
echo ╠═[ERROR] System-level failure occured.
) else (
echo ╠═[ERROR] Not admin.
)
goto UserInputPart
)

:viewfirewallrules
echo.
echo ╔═[INFO] Starting wf.msc
echo ╠═[INFO] Stunblock can be found here if you blocked stun.
echo ╠═Launching
start wf.msc
goto UserInputPart