# Lab 05: System Troubleshooting

## Objective
Menyelesaikan masalah sistem secara sistematis — dari identifikasi sampai resolusi.

## Environment
- OS: Arch Linux
- Kernel: 7.2.11-arch1-1
- CPU: Intel Core i7-7500U (2 core, 4 thread)
- RAM: 7.7 GiB
- Tools: journalctl, dmesg, systemd-analyze, systemctl, df, du, strace
- User: nyxx (uid 1000, wheel group)

## Practical Implementation
```bash
# ===== LANGKAH 1: Identifikasi Masalah =====
# 1a. Cek log kernel (hardware/driver)
dmesg -T | tail -30
dmesg -T | grep -iE 'error|fail|warning|crash' | tail -10

# 1b. Cek log sistem (aplikasi/service)
journalctl -p err --since "1 hour ago" --no-pager | head -20
journalctl -b -p err --no-pager | head -20

# 1c. Cek status service yang bermasalah
systemctl list-units --state=failed --no-pager
systemctl is-active NetworkManager

# ===== LANGKAH 2: Kumpulkan Data =====
# 2a. Resource check
uptime
free -h
df -h
ps aux --sort=-%cpu | head -5
ps aux --sort=-%mem | head -5

# 2b. Network check
ping -c 2 google.com
ss -tuln | grep LISTEN

# 2c. Boot analysis
systemd-analyze
systemd-analyze blame | head -10
systemd-analyze critical-chain

# ===== LANGKAH 3: Diagnosis =====
# 3a. Log spesifik service yang error
journalctl -u NetworkManager --no-pager -n 50
journalctl -u systemd-timesyncd --no-pager -n 30

# 3b. Cari pola masalah
journalctl -b | grep -iE 'error|fail|timeout|segfault' | wc -l
dmesg -T | grep -iE 'out of memory|oom|kill' | tail -5

# 3c. Cek file besar yang boros storage
du -xh --max-depth=1 / | sort -rh | head -10
find / -xdev -type f -size +500M 2>/dev/null | head -10

# ===== LANGKAH 4: Tindakan Perbaikan =====
# 4a. Restart service bermasalah
sudo systemctl restart NetworkManager

# 4b. Bersihkan log yang boros (jika journal terlalu besar)
journalctl --disk-usage
# sudo journalctl --vacuum-size=200M

# 4c. Restart system (last resort)
# sudo reboot

# ===== LANGKAH 5: Verifikasi Hasil =====
# 5a. Pastikan service OK
systemctl is-active NetworkManager
journalctl -u NetworkManager --since "1 minute ago" --no-pager

# 5b. Resource stabil
free -h
uptime

# 5c. Snapshot hasil
echo "=== Final Status ==="
uptime > evidence/01-uptime.txt
free -h > evidence/02-mem-final.txt
df -h > evidence/03-disk-final.txt
systemctl list-units --state=failed --no-pager > evidence/04-failed-services.txt
journalctl -b -p err --no-pager -n 20 > evidence/05-error-summary.txt
```

## Expected Result
- `dmesg -T | tail` menampilkan log kernel terakhir.
- `journalctl -p err -b` menampilkan baris error sejak boot.
- `systemctl list-units --state=failed` menampilkan service yang gagal (jika ada).
- `systemd-analyze` menunjukkan durasi boot.
- `systemd-analyze blame` menunjukkan service paling lambat boot.
- Setelah restart service, `systemctl is-active` mengembalikan `active`.

## Analysis
- **Metodologi troubleshooting 5 langkah**: Identifikasi → Kumpulkan Data → Diagnosis → Tindakan → Verifikasi.
- **Prioritas log**: `dmesg` (kernel/hardware) → `journalctl -p err` (sistem) → `journalctl -u service` (spesifik).
- `systemd-analyze blame` = bottleneck boot, `critical-chain` = ketergantungan service yang memperlambat.
- `journalctl --vacuum-size` = cara resmi membatasi log systemd (aman, tidak hapus file manual).
- OOM (Out of Memory): `dmesg | grep -i 'oom|kill'` cek jika kernel membunuh proses karena RAM habis.
- Storage boros: `du -xh --max-depth=1 / | sort -rh` cepat identifikasi folder termbesar.
- **Prinsip**: selalu verifikasi setelah perbaikan — restart service → cek status → cek log.

## Evidence
Screenshot praktik aslinya sudah tersimpan di folder `evidence/`:
- ![EVIDENCE 1](evidence/evidence-1.png)
- ![EVIDENCE 2](evidence/evidence-2.png)
- ![EVIDENCE 3](evidence/evidence-3.png)
- ![EVIDENCE 4](evidence/evidence-4.png)
- ![EVIDENCE 5](evidence/evidence-5.png)

## Conclusion
Praktik successfully menunjukkan troubleshooting sistem secara sistematis (5 langkah) — identifikasi masalah via log (`journalctl`, `dmesg`), analisis resource dan service, tindakan perbaikan (`systemctl restart`, `vacuum`), dan verifikasi hasil.