# Lab Environment

## System
- OS: Arch Linux
- Kernel: 7.2.11-arch1-1
- Shell: zsh
- Architecture: x86_64

## User
- Username: nyxx
- UID: 1000
- Groups: nyxx, docker, wheel

## Hardware
- RAM: 7.7 GB
- Disk: 118 GB (18 GB available)
- Load average: ~1.2

## Package Management
- Official repo: `pacman` (Arch official repository)
- AUR helper: `yay`, `paru` (Arch User Repository)
- Sync database: `pacman -Sy`
- Install: `pacman -S`, upgrade: `pacman -Syu`, remove: `pacman -R`

## Init System
- Init: systemd 262
- Service control: `systemctl`
- Timers: `systemd timers` (native, replaces cron)
- Logs: `journalctl`
- Note: Environment has no cron installed — use systemd timers

## Process Management
- Process list: `ps`, `top`, `htop`
- Process control: `kill`, `killall`, `renice`, `pgrep`, `pidof`
- Background jobs: `&`, `jobs`, `fg`, `bg`
- Analysis: `systemd-analyze`

## Task Scheduling
- Native: `systemd timers` (`systemctl enable --now`, `systemd-run --on-calendar`)
- Alternative: `cronie` (install via `pacman -S cronie`, then `systemctl enable --now cronie`)

## Tools
- `sudo` (password required, wheel group)
- `useradd` / `usermod` / `groupadd` / `passwd`
- `chmod` / `chown` / `chgrp` / `umask`
- `su` / `sudo -u`
- `pacman` / `yay` / `paru`
- `systemctl` / `journalctl`
- `ps` / `top` / `kill` / `renice`
- `systemd-run` / `systemd-analyze`

## Notes
- Lab ini menggunakan user `nyxx` (uid 1000) untuk demonstrasi.
- Untuk testing akses, buat user tambahan dengan `sudo -u` atau `su`.
- Semua perintah dijalankan di `/home/nyxx` kecuali dinyatakan lain.
- Untuk service/systemd timer, butuh `sudo` (wheel group).