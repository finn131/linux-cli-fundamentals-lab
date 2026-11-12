# Lab 01: Network Configuration

## Objective
Memeriksa dan mengonfigurasi alamat IP, gateway, dan resolusi nama pada host.

## Environment
- OS: Arch Linux
- Kernel: 7.2.11-arch1-1
- Shell: zsh
- Network interface: wlan0 (10.195.1.172/24)
- Gateway: 10.195.1.53
- DNS: 127.0.0.1 (local), 1.1.1.1, 8.8.8.8
- Tools: ip, nmcli, nslookup
- User: nyxx (uid 1000, wheel group)

## Practical Implementation
```bash
# 1. Periksa interface jaringan
ip addr show
ip addr show wlan0

# 2. Periksa gateway dan routing
ip route show
ip route | grep default

# 3. Periksa DNS resolver
cat /etc/resolv.conf

# 4. Periksa connectivity ke gateway
ping -c 3 10.195.1.53

# 5. Periksa connectivity ke internet
ping -c 3 google.com
ping -c 3 8.8.8.8

# 6. Periksa DNS resolusi
nslookup google.com
nslookup archlinux.org

# 7. Dengan NetworkManager (jika pakai GUI/netplan)
nmcli device status
nmcli con show
nmcli con show "wlan0" | grep ipv4

# 8. Lihat semua protokol yang terhubung
ss -tuln | grep LISTEN
ss -tuln | head -10

# 9. Periksa MAC address
ip addr show wlan0 | grep link/ether

# 10. Setel IP statis (contoh untuk testing)
# sudo ip addr add 192.168.100.10/24 dev wlan0
# sudo ip route add default via 192.168.100.1
# rm /etc/resolv.conf
# echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
```

## Expected Result
- `ip addr show wlan0` menampilkan IP 10.195.1.172/24.
- `ip route` menunjukkan gateway default via 10.195.1.53.
- `cat /etc/resolv.conf` menunjukkan nameserver 127.0.0.1, 1.1.1.1, 8.8.8.8.
- `ping google.com` berhasil menerima reply (koneksi internet OK).
- `nslookup google.com` menampilkan IP address google.com.

## Analysis
- `ip addr show` menampilkan detail interface (IP, MAC, mtu, state).
- `ip route show` menunjukkan tabel routing, `default via` adalah gateway default.
- `/etc/resolv.conf` berisi DNS servers — bacaan NetworkManager, tidak langsung diedit.
- `ping -c N` mengirim N paket untuk testing connectivity.
- `nslookup` query DNS dan menampilkan rekord A record.
- `ss -tuln` menunjukkan port yang listening (tcp/udp, all interfaces).
- Untuk statis IP, gunakan `ip addr add` (temporary) atau konfigurasikan NetworkManager.

## Evidence
Screenshot praktik aslinya sudah tersimpan di folder `evidence/`:
- ![EVIDENCE 1](evidence/evidence-1.png)
- ![EVIDENCE 2](evidence/evidence-2.png)
- ![EVIDENCE 3](evidence/evidence-3.png)

## Conclusion
Praktik successfully memeriksa konfigurasi jaringan (IP, gateway, DNS, routing) dan menguji konektivitas basis (`ping`, `nslookup`).