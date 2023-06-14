@echo off

REM Clear temporary files
echo Deleting temporary files...
del /q /f /s %temp%\*.*
del /q /f /s C:\Windows\Temp\*.*
del /q /f /s C:\Windows\Prefetch\*.*
echo Temporary files deleted.

REM Adjust virtual memory
echo Adjusting virtual memory...
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=false
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=2048,MaximumSize=4096
echo Virtual memory adjusted.

REM Disable Windows visual effects
echo Disabling Windows visual effects...
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 90 12 03 80 10 00 00 00 /f
echo Windows visual effects disabled.

REM Adjust processor scheduling
echo Adjusting processor scheduling...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 0x26 /f
echo Processor scheduling adjusted.

REM Apply network optimizations
echo Applying network optimizations...
REM Disable Network Throttling
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoMaximize" /v "UseDesktopIniCache" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\Defrag" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\ProcessPriorityClass" /v "Priority" /t REG_DWORD /d 26 /f

REM Disable Nagle's algorithm
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpAckFrequency" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TCPNoDelay" /t REG_DWORD /d 1 /f

REM Increase TCP receive and send buffer size
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d 65535 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d 65535 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d 3 /f

REM Disable LLMNR and NetBIOS over TCP/IP
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "LmhostsEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "NodeType" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "DnsCacheEnabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "UseNewLookup" /t REG_DWORD /d 0 /f

REM Disable IPv6 (optional, if not used)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v "DisabledComponents" /t REG_DWORD /d 0xffffffff /f

REM Disable iphlpsvc if IPv6 is not used
reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v "DisabledComponents" | find "0xffffffff" > nul
if %errorlevel% equ 0 (
    sc config "iphlpsvc" start= disabled
) else (
    sc config "iphlpsvc" start= auto
)

REM Additional performance and latency tweaks
echo Applying additional performance and latency tweaks...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DisableTaskOffload /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TCPMaxDataRetransmissions /t REG_DWORD /d 5 /f
echo Additional performance and latency tweaks applied.

REM Reset network settings
echo Resetting network settings...
netsh int ip reset
netsh advfirewall reset
netsh winsock reset
ipconfig /flushdns
ipconfig /release
ipconfig /renew
echo Network settings reset.

echo Restarting system...
shutdown /r /t 0
