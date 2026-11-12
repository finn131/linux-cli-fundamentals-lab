# Lab 02: Network Troubleshooting

## Objective
Mendiagnosis gangguan konektivitas secara bertahap dari host sampai layanan tujuan.

## Environment
- OS: Arch Linux
- Kernel: 7.2.11-arch1-1
- Shell: zsh
- Tools: ping, tracepath, ss, nslookup
- User: nyxx (uid 1000)

## Practical Implementation
```bash
# 1. Test basic ping ke localhost
ping -c 3 127.0.0.1

# 2. Test ping ke gateway
ping -c 3 10.195.1.53

# 3. Test ping ke DNS publik
ping -c 3 8.8.8.8

# 4. Test ping ke domain (menggunakan DNS)
ping -c 3 google.com

# 5. Traceroute/tracepath ke tujuan (lima hop pertama)
tracepath google.com
tracepath 8.8.8.8

# 6. DNS lookup
nslookup google.com
dig @8.8.8.8 google.com A +short

# 7. Periksa port yang listening
ss -tuln

# 8. Periksa koneksi tertentu
ss -tuln | grep :22    # SSH port
ss -tuln | grep :53    # DNS port

# 9. Test koneksi TCP ke port spesifik
timeout 5 bash -c 'echo > /dev/tcp/google.com/80' && echo "TCP connect OK" || echo "TCP connect FAIL"

# 10. Periksa routing ke tujuan
ip route get google.com
ip route get 8.8.8.8

# 11. Test dengan mtr (jika tersedia)
# mtr -r -c 5 google.com
```

## Expected Result
- Ping localhost (127.0.0.1) berhasil — loopback berfungsi.
- Ping gateway berhasil — koneksi ke router OK.
- Ping 8.8.8.8 berhasil — internet connectivity OK.
- Ping google.com berhasil — DNS resolusi OK.
- tracepath menunjukkan path ke tujuan melalui beberapa hop.
- `ss -tuln` menampilkan port yang listening.

## Analysis
- **Langkah 1-3 (Network stack)**: localhost → gateway → internet. Jika gagal di langkah mana?
- **Langkah 4 (DNS)**: Konektivitas OK? DNS gagal? Periksa `/etc/resolv.conf`.
- **tracepath**: Menunjukkan jalut paket melewati router. Timeout = firewall/gateway problem.
- **ss**: Mirip `netstat` — menunjukkan socket yang terbuka, berguna untuk service port.
- **timeout + /dev/tcp**: Pengujian TCP connect (bash built-in) untuk debugging firewall.
- **ip route get**: Menunjukkan rute mana yang dipakai untuk mencapai tujuan.

## Evidence
Screenshot praktik aslinya sudah tersimpan di folder `evidence/`:
- ![EVIDENCE 1](evidence/evidence-1.png)
- ![EVIDENCE 2](evidence/evidence-2.png)
- ![EVIDENCE 3](evidence/evidence-3.png)
- ![EVIDENCE 4](evidence/evidence-4.png)

## Conclusion
Praktik successfully menggunakan metodologi bertahap (localhost → gateway → internet → DNS) untuk mendiagnosis gangguan konektivitas, dengan alat `ping`, `tracepath`, `ss`, `nslookup`, dan `dig`.