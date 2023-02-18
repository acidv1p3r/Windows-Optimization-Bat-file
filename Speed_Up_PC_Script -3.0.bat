@echo off

echo Deleting temporary files...
del /q /f /s %temp%*.*
del /q /f /s c:\windows\temp*.*
rmdir /q /s c:\windows\temp
md c:\windows\temp
del /q /f /s C:\WINDOWS\Prefetch*.*
echo Done.

echo Clearing Pagefile...
echo 1 > /proc/sys/vm/drop_caches
echo Done.

echo Adjusting Virtual Memory...
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=false
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=2048,MaximumSize=4096
echo Done.

echo Adjusting Power Settings...
powercfg -setactive scheme_min
echo Done.

echo Disabling Windows visual effects...
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 90 12 03 80 10 00 00 00 /f
echo Done.

echo Adjusting Processor Scheduling...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 0x26 /f
echo Done.

echo Adjusting Network Settings...
netsh int tcp set global autotuning=disabled
netsh int tcp set global chimney=disabled
netsh int tcp set global rss=disabled
netsh int tcp set global congestionprovider=none
echo Done.

echo Adjusting Internet Explorer Settings...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v MaxConnectionsPerServer /t REG_DWORD /d 12 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v MaxConnectionsPer1_0Server /t REG_DWORD /d 12 /f
echo Done.

echo Adjusting Disk Caching Settings...
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f
echo Done.

echo Adjusting File System Settings...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsDisableLastAccessUpdate /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsMemoryUsage /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v DisableNTFSLastAccessUpdate /t REG_DWORD /d 1 /f
echo Done.

echo Adjusting Internet Settings...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v DisableCachingOfSSLPages /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v WarnOnPost /t REG_DWORD /d 0 /f
echo Done.

echo Adjusting Services...
sc config "Audiosrv" start= disabled
sc config "DPS" start= disabled
sc config "iphl
