# Lab 01: Log Analysis

## Objective
Menganalisis log sistem dan layanan untuk menemukan masalah.

## Environment
- OS: Arch Linux
- Kernel: 7.2.11-arch1-1
- Shell: zsh
- Log system: systemd-journald (persisten di `/var/log/journal`)
- Disk usage journal: 1.7G
- Tools: journalctl, dmesg, last, lastb
- User: nyxx (uid 1000, wheel group)

## Practical Implementation
```bash
# 1. Cek status dan penggunaan log
journalctl --disk-usage
journalctl --boot        # log sejak boot terakhir
journalctl -b -n 20      # 20 baris terakhir sejak boot

# 2. Filter berdasarkan tingkat log
journalctl -p err -b         # hanya error, sejak boot
journalctl -p warning -b     # warning ke atas
journalctl -p err --since "1 hour ago"

# 3. Log spesifik per layanan
systemctl status NetworkManager --no-pager
journalctl -u NetworkManager --no-pager -n 20
journalctl -u systemd-timesyncd --no-pager -n 10
journalctl -u sshd --no-pager -n 10

# 4. Log kernel
dmesg | tail -20
dmesg -T | tail -20          # dengan timestamp
journalctl -k -n 20          # kernel via journal

# 5. Cari pola dalam log
journalctl -b | grep -i error | head -10
journalctl -b | grep -i "network\|dns" | head -10
dmesg | grep -i "wlan\|network" | head -10

# 6. Log login dan gagal login
last -a -n 10                # login sukses
lastb -n 10                  # login gagal (btmp)

# 7. Log aplikasi/paket
tail -30 /var/log/pacman.log
grep -i "error\|failed" /var/log/pacman.log | tail -5

# 8. Ekspor log untuk analisis lebih lanjut
journalctl -b -p err > evidence/01-error-log.txt
journalctl -u NetworkManager --since "1 hour ago" > evidence/02-networkmanager.txt
dmesg -T | tail -50 > evidence/03-dmesg.txt
```

## Expected Result
- `journalctl --disk-usage` menunjukkan total ukuran log (±1.7G).
- `journalctl -p err -b` menampilkan hanya baris error sejak boot.
- `journalctl -u NetworkManager` menampilkan log spesifik service NetworkManager.
- `dmesg -T | tail` menampilkan log kernel dengan timestamp.
- `last -a` menampilkan riwayat login user, `lastb` menampilkan percobaan login gagal.

## Analysis
- `journalctl` adalah interface utama systemd-journald — query fleksibel (waktu, service, priority, boot).
- `-p err` filter priority error ke atas (err, crit, alert, emerg), `-p warning` lebih luas.
- `-b` batasi ke boot session saat ini, `-n N` batasi jumlah baris.
- `dmesg` membaca ring buffer kernel — untuk hardware/driver/network, `journalctl -k` sama.
- `/var/log/pacman.log` mencatat transaksi paket Arch (install/remove/upgrade) + waktu.
- `last`/`lastb` membaca `/var/log/wtmp` dan `/var/log/btmp` — audit keamanan login.
- Analisis sistematis: mulai dari error (`-p err`), perkecil ke service, lalu cari pola dengan `grep`.

## Evidence
Screenshot praktik aslinya sudah tersimpan di folder `evidence/`:
- ![EVIDENCE 1](evidence/evidence-1.png)
- ![EVIDENCE 2](evidence/evidence-2.png)
- ![EVIDENCE 3](evidence/evidence-3.png)
- ![EVIDENCE 4](evidence/evidence-4.png)

## Conclusion
Praktik successfully menunjukkan analisis log sistem dan layanan (`journalctl`, `dmesg`, `last`) — filter per priority/service/boot, mencari pola, dan memeriksa riwayat login untuk menemukan masalah.