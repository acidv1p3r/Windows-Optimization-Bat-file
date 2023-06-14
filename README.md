[discord-badge]: https://discord.com/api/guilds/897156326776520736/widget.png?style=shield
[discord-link]: https://discord.gg/RgZGCqKxAb

<div align="center">

#   🖥️ Windows-Optimization-Bat-file🖱
This is a bat file optimization script that incorporates optimizations from ChatGPT. It performs a range of optimizations to improve system performance and free up disk space.

[![Discord Server][discord-badge]][discord-link]  

</div>  

This script performs various optimizations and tweaks to enhance system performance. Here's a description of what it does:

Deletes temporary files: It clears temporary files from the system, including the Windows temp folder, Prefetch folder, and %temp% folder, freeing up disk space.

Adjusts virtual memory: It modifies the virtual memory settings by disabling automatic management of the pagefile and setting a specific initial and maximum size for the pagefile.sys file.

Disables Windows visual effects: It disables visual effects in Windows, which can consume system resources, thus improving overall performance.

Adjusts processor scheduling: It modifies the processor scheduling settings to optimize the allocation of system resources, prioritizing background services.

Applies network optimizations: It applies various network optimizations, including disabling network throttling, Nagle's algorithm, increasing TCP receive and send buffer size, and disabling unnecessary network protocols.

Disables LLMNR and NetBIOS over TCP/IP: It disables LLMNR (Link-Local Multicast Name Resolution) and NetBIOS over TCP/IP, which can improve network security and performance.

Disables IPv6 (optional): It disables IPv6 if it's not used in the network configuration.

Disables iphlpsvc: It disables the IP Helper service (iphlpsvc) if IPv6 is not used, further optimizing network performance.

Applies additional performance and latency tweaks: It applies additional registry tweaks related to memory management, task offload, and TCP data retransmissions to enhance performance and reduce latency.

Resets network settings: It resets various network settings using netsh commands, including IP configuration, firewall settings, and DNS cache.

Restarts the system: It initiates a system restart to apply the changes made by the script.

It's important to note that running this script will modify system settings, and a system restart is required. It's recommended to backup your data and exercise caution when making such changes to your system.
