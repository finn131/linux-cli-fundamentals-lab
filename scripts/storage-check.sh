#!/usr/bin/env bash
# storage-check.sh — Cek status storage, filesystem, dan mount
# Environment: Arch Linux, zsh, user: nyxx

echo "=== STORAGE CHECK ==="
echo "Generated: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

echo "=== BLOCK DEVICES ==="
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT
echo ""

echo "=== FILESYSTEM USAGE ==="
df -hT
echo ""

echo "=== INODE USAGE ==="
df -i | head -10
echo ""

echo "=== LARGEST DIRECTORIES (/ top level) ==="
du -xh --max-depth=1 / 2>/dev/null | sort -rh | head -10
echo ""

echo "=== LARGE FILES (>100M) ==="
find / -xdev -type f -size +100M 2>/dev/null | head -10
echo ""

echo "=== MOUNTED FILESYSTEMS ==="
mount | grep -v 'proc\|sys\|cgroup\|devpts\|tmpfs'
echo ""

echo "=== FSTAB ==="
grep -v '^#\|^$' /etc/fstab
echo ""

echo "=== JOURNAL SIZE ==="
journalctl --disk-usage