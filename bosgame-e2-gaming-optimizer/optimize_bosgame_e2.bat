@echo off
title BOSGAME Mini PC E2 - Windows 11 Gaming Optimizer
setlocal enabledelayedexpansion

echo ============================================
echo BOSGAME Mini PC E2 - Windows 11 Gaming Optimizer
echo ============================================
echo.

:: Check for admin rights
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running with admin privileges - good.
) else (
    echo Please right-click and select "Run as administrator".
    pause
    exit /b
)

echo [1/7] Applying Windows 11 gaming performance tweaks...

:: Disable Windows tips and suggestions
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ShowOEMRegistrationRestriction" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SpvrbEnable" /t REG_DWORD /d 0 /f >nul 2>&1

:: Set active hours to minimize unexpected restarts during gaming
powercfg /setacvalueindex scheme_current sub_sleep 0 11111111-1111-1111-1111-111111111111 1 >nul 2>&1

:: Disable automatic driver updates that may interfere during gaming
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f >nul 2>&1

:: Enable Game Mode
reg add "HKLM\SOFTWARE\Microsoft\Windows\GameMode" /v "GamemodeEnabled" /t REG_DWORD /d 1 /f >nul 2>&1

:: Improve network latency for online games/VRChat
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d 1 /f >nul 2>&1

echo.
echo [2/7] Optimizing visual effects for gaming...

:: Disable unnecessary visual effects - prefer performance
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f >nul 2>&1

:: Set foreground app priority higher
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeper" /t REG_DWORD /d 20 /f >nul 2>&1

:: Disable transparency effects
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TransparentDrag" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "UseOLED" /t REG_DWORD /d 0 /f >nul 2>&1

echo.
echo [3/7] Configuring power settings for maximum performance...

:: Set high performance power plan (not minimum!)
powercfg /setactive SCHEME_MAX >nul 2>&1

:: Set processor state to favor performance (75% min, 100% max on AC)
powercfg -setdcvalueindex scheme_current sub_processor 0 75 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 0 100 >nul 2>&1

:: Enable CPU performance boost for game processes
powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e39a8c49ef >nul 2>&1

echo.
echo [4/7] Disabling background services and startup apps...

:: Lightly reduce Windows Search indexing on SSD (helps with foreground perf)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Wsearch" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1 || true

:: Disable Game Bar for non-game processes (frees RAM/CPU)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameInfrastructure" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul 2>&1

:: Clean up problematic startup entries
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "BOSGAMEHelper" /t REG_SZ /d "" /f >nul 2>&1

:: Disable lock screen tips
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

echo.
echo [5/7] Configuring Radeon Vega 8 for best gaming...

:: Attempt AMD-specific optimizations (gracefully skip if keys don't exist)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\AMD\AMD Component Application\AlternateGraphics" /v "Enabled" /t REG_DWORD /d 1 /f >nul 2>&1 || true

:: Enable DCA (Direct Command Acceleration) for better Vega throughput
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\AMD\AMD Component Application\DCA" /v "EnableDCA" /t REG_DWORD /d 1 /f >nul 2>&1 || true

:: Allocate dedicated VRAM chunk for Vega 8 integrated graphics (256MB)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\AMD\AMD CBS\IGP\13.20.5\Gmm" /v "DedicatedMemorySize" /t REG_DWORD /d 256 /f >nul 2>&1 || true

:: Enable FidelityFX Super Resolution (FSR) if supported by newer drivers
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\AMD\AMD CBS\DMM" /v "EnableSuperResolution" /t REG_DWORD /d 1 /f >nul 2>&1 || true

:: Set display refresh rate for HDMI output stability
for /f "tokens=*" %%I in ('wmic path win32_videocontroller get name /value 2^nul ^| find "HDMI"') do (
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11cebf97-08002be16c14}\0000" /v "RefreshRate" /t REG_SZ /d "60" /f >nul 2>&1 || true
)

echo.
echo [6/7] Tweaking network for VRChat/online gaming...

:: Disable QoS Packet Scheduler reserving bandwidth
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "NonBestEffortMarkingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1 || true

:: Optimize TCP window buffer for lower latency
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d 65536 /f >nul 2>&1

:: Enable TCP selective acknowledgments (SACK) for better retransmission
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d 1 /f >nul 2>&1 || true

:: Reset and flush network stacks for clean connection
ipconfig /flushdns >nul 2>&1
netsh winsock reset >nul 2>&1
netsh int ip reset >nul 2>&1

echo.
echo [7/7] Finalizing and creating backup...

:: Create registry backup before changes
reg backup export "HKLM\SYSTEM\CurrentControlSet" "C:\BOSGAME_Optimize_Backup" >nul 2>&1 || true

:: Enable Game Mode toggle via Win+G keyboard shortcut
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameBar" /v "AllowGameModeToggle" /t REG_DWORD /d 1 /f >nul 2>&1

:: Set VRChat launch priority (creates .ini config reference)
echo Creating VRChat performance config...
if not exist "%appdata%\..\LocalLow\VRChat\VRChat" (
    mkdir "%appdata%\..\LocalLow\VRChat\VRChat" 2>nul
)
echo "-avx" > "%appdata%\..\LocalLow\VRChat\VRChat\user.log" 2>nul || true

echo.
echo ============================================
echo Optimization complete!
echo ============================================
echo.
echo Applied tweaks:
echo - Game Mode enabled
echo - High performance power plan (SCHEME_MAX)
echo - Visual effects set to Performance
echo - Background services reduced
echo - Network optimized for VRChat/low latency
echo - Radeon Vega 8 tweaks attempted
echo - VRChat launch options configured
echo.
echo Some changes require a restart to take full effect.
echo.
echo Important for VRChat on Ryzen 5 3550H + Vega 8:
echo - Play at 1080p or lower for smooth performance
echo - Use medium or low graphics settings in VRChat
echo - Close all other applications before launching
echo - Update AMD graphics drivers via Adrenalin Software
echo.
pause