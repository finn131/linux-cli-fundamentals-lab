#!/usr/bin/env bash
# system-info.sh — Kumpulkan info sistem dasar
# Environment: Arch Linux, zsh, user: nyxx

echo "=== SYSTEM INFO ==="
echo "Hostname : $(hostname)"
echo "OS       : $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"')"
echo "Kernel   : $(uname -r)"
echo "Shell    : $SHELL"
echo "User     : $(whoami)"
echo "Uptime   : $(uptime -p)"
echo ""
echo "=== CPU ==="
lscpu 2>/dev/null | grep -E '^Model name|^CPU\(s\):|^Socket|^Thread|^Core|^MHz'
echo ""
echo "=== MEMORY ==="
free -h
echo ""
echo "=== DISK ==="
df -h / 2>/dev/null
echo ""
echo "=== TOP 5 PROCESSES (CPU) ==="
ps aux --sort=-%cpu | head -6