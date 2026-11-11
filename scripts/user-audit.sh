#!/usr/bin/env bash
# user-audit.sh — Lapor semua pengguna, group, dan file permission
# Environment: Arch Linux, zsh, user: nyxx

echo "=== USER AUDIT REPORT ==="
echo "Generated: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

echo "=== ALL USERS (UID >= 1000) ==="
awk -F: '$3 >= 1000 {printf "%-15s UID=%-6s GID=%-6s Home=%s\n", $1, $3, $4, $6}' /etc/passwd
echo ""

echo "=== ALL GROUPS ==="
awk -F: 'NR > 1 {printf "%-15s GID=%-6s\n", $1, $3}' /etc/group
echo ""

echo "=== CURRENT USER ==="
echo "Username: $(whoami)"
id
echo ""

echo "=== LAST 5 LOGINS ==="
last -5 2>/dev/null || echo "(last command not available)"
echo ""

echo "=== USERS WITH LOGIN SHELL ==="
awk -F: '$7 ~ /\/(bash|zsh|sh)$/ {printf "%-15s Shell=%s\n", $1, $7}' /etc/passwd
echo ""

echo "=== WORLD-WRITABLE FILES IN /home/nyxx ==="
find /home/nyxx -type f -perm -002 -ls 2>/dev/null | head -10
echo ""

echo "=== USERS WITHOUT LOGIN (nologin) ==="
awk -F: '$7 == "/usr/sbin/nologin" || $7 == "/bin/false" {printf "%-15s\n", $1}' /etc/passwd | head -10