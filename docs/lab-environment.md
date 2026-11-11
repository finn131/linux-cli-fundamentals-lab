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

## Tools
- `sudo` (password required, wheel group)
- `useradd` / `usermod` / `groupadd` / `passwd`
- `chmod` / `chown` / `chgrp` / `umask`
- `su` / `sudo -u`

## Notes
- Lab ini menggunakan user `nyxx` (uid 1000) untuk demonstrasi.
- Untuk testing akses, buat user tambahan dengan `sudo -u` atau `su`.
- Semua perintah dijalankan di `/home/nyxx` kecuali dinyatakan lain.