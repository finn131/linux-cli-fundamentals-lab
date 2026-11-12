# Lab 04: Host Firewall

## Objective
Mengatur firewall host agar hanya membuka port layanan yang dibutuhkan.

## Environment
- OS: Arch Linux
- Kernel: 7.2.11-arch1-1
- Tools: iptables, nft (legacy), systemd
- Services: sshd (port 22), NetworkManager (port 53 via DNS), named (port 53)
- User: nyxx (uid 1000, wheel group)
- Note: ufw tidak terinstall, gunakan iptables/nft

## Practical Implementation
```bash
# 1. Check status firewall service
sudo systemctl status iptables --no-pager 2>/dev/null || echo "iptables service not active"
sudo systemctl status nftables --no-pager 2>/dev/null || echo "nftables service not active"

# 2. List rules iptables yang ada
sudo iptables -L -n -v --line-numbers

# 3. List ruleset nft
sudo nft list ruleset

# 4. Policy default: DROP semua INPUT
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT ACCEPT

# 5. Allow loopback interface
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT

# 6. Allow established connections
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# 7. Allow SSH (port 22)
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT

# 8. Allow ICMP (ping)
sudo iptables -A INPUT -p icmp -j ACCEPT

# 9. Allowed services yang spesifik
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT    # HTTP
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT   # HTTPS
# (tambah port lain sesuai kebutuhan layanan)

# 10. List rules setelah ditambah
sudo iptables -L -n --line-numbers

# 11. Save rules permanen
sudo iptables-save > /etc/iptables/iptables.rules

# 12. Alternatif: gunakan nftables
sudo nft list ruleset
# Reset rules
sudo nft flush ruleset

# 13. Buat base chain dengan policy DROP
sudo nft add table ip filter
sudo nft add chain ip filter input { type filter hook input priority 0 \; policy drop \; }
sudo nft add chain ip filter output { type filter hook output priority 0 \; policy accept \; }

# 14. Allow loopback
sudo nft add rule ip filter input iif "lo" accept

# 15. Allow established connections
sudo nft add rule ip filter input ct state established,related accept

# 16. Allow SSH
sudo nft add rule ip filter input tcp dport 22 ct state new accept

# 17. Allow ICMP
sudo nft add rule ip filter input ip protocol icmp accept

# 18. List nft rules
sudo nft list chain ip filter input

# 19. Save nft rules
sudo nft list ruleset > /etc/nftables.conf

# 20. Flush rules (reset)
# sudo iptables -F
# sudo nft flush ruleset
```

## Expected Result
- `iptables -L -n` atau `nft list ruleset` menunjukkan rules yang diterapkan.
- INPUT chain memiliki policy `DROP`.
- Port 22 (SSH) allowed, port lainnya BLOCKED.
- Loopback dan established connections allowed.
- Rules tersimpan di `/etc/iptables/iptables.rules` ataupun `/etc/nftables.conf`.

## Analysis
- **Policy default**: `DROP` untuk security; `ACCEPT` untuk OUTPUT (client tidak restriction).
- **`-i lo`**: interface loopback = selalu aman, diizinkan.
- **`--state ESTABLISHED,RELATED`**: koneksi outbound otomatis allowed, balik ke server.
- **`tcp --dport 22`**: hanya port SSH yang izin datang dari luar.
- **`--dport 80/443`**: tambahkan port HTTPS/HTTP jika butuh web server.
- **`state --state NEW`**: hanya packet baru untuk port spesifik yang diizinkan.
- `iptables-save` → `/etc/iptables/iptables.rules` untuk persistence (jika iptables service dijalankan).
- `nftables` adalah replacement modern, sintaksnya beda namun konsepnya serupa.

## Evidence
Screenshot praktik aslinya sudah tersimpan di folder `evidence/`:
- ![EVIDENCE 1](evidence/evidence-1.png)
- ![EVIDENCE 2](evidence/evidence-2.png)
- ![EVIDENCE 3](evidence/evidence-3.png)
- ![EVIDENCE 4](evidence/evidence-4.png)
- ![EVIDENCE 5](evidence/evidence-5.png)

## Conclusion
Praktik successfully mengonfigurasi firewall dengan `iptables`/`nftables` untuk membatasi akses — policy DROP, allow loopback, established connections, dan port layanan kritis seperti SSH (22).