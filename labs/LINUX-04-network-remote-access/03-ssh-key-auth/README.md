# Lab 03: SSH Key Authentication

## Objective
Mengamankan akses jarak jauh dengan autentikasi berbasis kunci dan membatasi login yang tidak perlu.

## Environment
- OS: Arch Linux
- SSH Server: OpenSSH_10.6p1, OpenSSL 3.6.5
- Tools: ssh-keygen, ssh, systemctl, sshd
- User: nyxx (uid 1000, wheel group)

## Practical Implementation
```bash
# 1. Buat SSH key pair (RSA 4096 bit)
ssh-keygen -t rsa -b 4096 -C "nyxx@$HOSTNAME" -f ~/.ssh/id_rsa_manual

# 2. Lihat key yang baru dibuat
ls -la ~/.ssh/id_rsa_manual*
cat ~/.ssh/id_rsa_manual.pub

# 3. Tambahkan ke authorized_keys (mode manual)
mkdir -p ~/.ssh
cat ~/.ssh/id_rsa_manual.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh

# 4. Verifikasi permission
ls -la ~/.ssh/

# 5. Cek konfigurasi sshd
sudo cat /etc/ssh/sshd_config | grep -v '^#' | grep -v '^$'

# 6. Edit sshd_config untuk key-only auth
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

# 7. Restart sshd service
sudo systemctl restart sshd
sudo systemctl status sshd --no-pager

# 8. Test connection ke server sendiri (from localhost)
ssh -o BatchMode=yes -o ConnectTimeout=5 -p 22 nyxx@localhost 'echo "SSH key auth OK"'

# 9. Generate key untuk user lain (contoh testing)
sudo su - -c 'ssh-keygen -t ed25519 -C "testuser@localhost" -f /home/testuser/.ssh/id_ed25519'
sudo chown -R testuser:testuser /home/testuser/.ssh

# 10. Disable password auth (final config)
sudo sshd -T | grep -E 'passwordauthentication|permitrootlogin'
```

## Expected Result
- Key pair RSA 4096-bit berhasil dibuat di `~/.ssh/id_rsa_manual`.
- Public key ditambahkan ke `~/.ssh/authorized_keys`.
- Permission `.ssh` = 700, `authorized_keys` = 600.
- SSH daemon restart tanpa error (`systemctl status sshd`).
- `ssh -o BatchMode=yes nyxx@localhost` berhasil login tanpa password prompt.

## Analysis
- `ssh-keygen -t rsa -b 4096` buat key kuat RSA 4096-bit atau `ed25519` lebih modern.
- `-C` menambah comment ke public key untuk identifikasi.
- `-f` tentukan filename, default `~/.ssh/id_rsa`.
- Permission kritis: `.ssh` harus 700, `authorized_keys` harus 600.
- `PasswordAuthentication no` di sshd_config menonaktifkan password login.
- `PermitRootLogin no` mencegah login root langsung.
- `sshd -T` menampilkan konfigurasi yang aktif (query).
- `systemctl restart sshd` menerapkan perubahan config.

## Evidence
Screenshot praktik aslinya sudah tersimpan di folder `evidence/`:
- ![EVIDENCE 1](evidence/evidence-1.png)
- ![EVIDENCE 2](evidence/evidence-2.png)
- ![EVIDENCE 3](evidence/evidence-3.png)
- ![EVIDENCE 4](evidence/evidence-4.png)
- ![EVIDENCE 5](evidence/evidence-5.png)

## Conclusion
Praktik successfully menunjukkan pembuatan SSH key pair (`ssh-keygen`), setup authorized_keys, konfigurasi sshd untuk key-only authentication, serta pembatasan login tidak perlu (`PasswordAuthentication no`, `PermitRootLogin no`).