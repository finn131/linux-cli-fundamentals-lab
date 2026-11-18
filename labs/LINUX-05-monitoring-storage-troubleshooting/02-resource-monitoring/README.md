# Lab 02: Resource Monitoring

## Objective
Memantau CPU, RAM, dan storage untuk menemukan bottleneck.

## Environment
- OS: Arch Linux
- Kernel: 7.2.11-arch1-1
- CPU: Intel Core i7-7500U @ 2.70GHz (2 core, 4 thread)
- RAM: 7.7 GiB
- Disk: 120G ext4 (`/dev/nvme0n1p2`)
- Tools: top, htop, vmstat, free, df, du
- User: nyxx (uid 1000)

## Practical Implementation
```bash
# 1. Monitor CPU real-time
top
# Di top: 1 = per-CPU, c = sort column, q = keluar
htop
# Di htop: F2 = setup, sort by %CPU, q = keluar

# 2. Snapshot statistik CPU dan memori
vmstat 1 5              # tiap detik, 5x
# Kolom: r (runnable), b (blocked), si/so (swap), us/sy/id (user/system/idle)

# 3. Cek penggunaan memori
free -h
# available = free + buff/cache yang bisa direclaim
free -m | awk '/Mem/ {printf "used: %.1f%%\n", $3/$2*100}'

# 4. Proses yang paling boros CPU
ps aux --sort=-%cpu | head -5
# dan memori
ps aux --sort=-%mem | head -5

# 5. Cek load average
uptime
cat /proc/loadavg
# Load < jumlah CPU (4) = sehat, > 4 = overload

# 6. Monitor storage
df -h                   # kapasitas filesystem
df -hT                  # dengan tipe filesystem
du -sh /var/log /home/nyxx/Documents   # ukuran folder
du -sh /home/nyxx/* | sort -rh | head -10

# 7. Temukan file besar
find / -xdev -type f -size +100M 2>/dev/null | head -10
du -xh --max-depth=1 / | sort -rh | head -10

# 8. Cek journal (penggunaan disk oleh log)
journalctl --disk-usage
# Jika besar, batasi:
# sudo journalctl --vacuum-size=200M

# 9. Snapshot ke file (bukti)
free -h > evidence/01-mem.txt
df -h > evidence/02-disk.txt
ps aux --sort=-%cpu | head -5 > evidence/03-cpu-top.txt
uptime > evidence/04-loadavg.txt
```

## Expected Result
- `top`/`htop` menampilkan utilisasi CPU per core dan proses aktif real-time.
- `vmstat 1 5` menunjukkan idle tinggi saat idle — `us/sy/id` stabil.
- `free -h` menampilkan total/used/available RAM (±7.7 Gi total).
- `df -h` menunjukkan `/` menggunakan ±86% dari 120G.
- `du -sh /var/log` menunjukkan ukuran folder log.

## Analysis
- **CPU**: `top`/`htop` untuk real-time, `vmstat` untuk statistik periodik. Kolom `id` tinggi = idle sehat.
- **Load average** (1/5/15 menit): bandingkan dengan jumlah CPU. Load 1.2 pada 4 CPU = sangat sehat.
- **RAM**: `available` lebih penting daripada `free` — Linux memakai memori kosong untuk cache.
- **Disk**: `df` = kapasitas filesystem, `du` = ukuran pemakaian. Bedanya: `df` termasuk file terhapus tapi masih di-reference.
- `find -xdev -size +100M` cari file besar tanpa menyeberang filesystem.
- Journal membesar normal — `--vacuum-size` untuk membatasi.

## Evidence
Screenshot praktik aslinya sudah tersimpan di folder `evidence/`:
- ![EVIDENCE 1](evidence/evidence-1.png)
- ![EVIDENCE 2](evidence/evidence-2.png)
- ![EVIDENCE 3](evidence/evidence-3.png)
- ![EVIDENCE 4](evidence/evidence-4.png)

## Conclusion
Praktik successfully menunjukkan pemantauan CPU (`top`, `vmstat`), RAM (`free`, `ps --sort=-%mem`), dan storage (`df`, `du`, `find`) untuk mengidentifikasi bottleneck resource.