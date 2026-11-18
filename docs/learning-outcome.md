# Learning Outcomes

Setelah menyelesaikan semua lab, pembelajar mampu:

# LINUX-01: Basic Linux

## 01 Directory Navigation
- Menjelaskan perbedaan absolute path vs relative path.
- Mengenal dan menggunakan perintah `pwd`, `ls`, `cd`, `mkdir`, `tree`.
- Mampu berpindah antar direktori dengan efisien.

## 02 File Management
- Membuat, menyalin, memindahkan, dan menghapus file/direktori.
- Mengenal perintah `touch`, `cp`, `mv`, `rm`, `cat`, `echo`.
- Memahami risiko `rm -rf` dan cara menghindarinya.

## 03 Basic Linux Command
- Mengakses manual page perintah dengan `man`.
- Menemukan lokasi binary dengan `which` dan `whereis`.
- Mengelola riwayat perintah dengan `history`.
- Menggunakan `clear` untuk membersihkan terminal.

## 04 File Permissions
- Membaca dan memahami permission string (rwx) dan octal.
- Mengubah permission file dengan `chmod`.
- Mengubah owner dan group dengan `chown`.
- Memahami `umask` dan dampaknya terhadap permission default.

## 05 Command Output Analysis
- Mengarahkan output ke file dengan `>` dan `>>`.
- Menggabungkan stdout dan stderr.
- Menggunakan pipe `|` untuk mengalirkan output ke perintah lain.
- Membaca file besar dengan `less`, `head`, `tail`.
- Mencari teks dengan `grep`.

# LINUX-02: User Management

## 01 User Management
- Membuat pengguna baru dengan `useradd` (flag `-M`, `-m`, `-s`, `-g`, `-G`).
- Membuat grup baru dengan `groupadd`.
- Mengatur password dengan `passwd`.
- Memverifikasi akun dengan `id`, `getent passwd`, `groups`.

## 02 Group Management
- Menambahkan pengguna ke grup dengan `usermod -aG` dan `gpasswd -a`.
- Menghapus anggota grup dengan `gpasswd -d`.
- Membuat grup dengan GID spesifik (`groupadd -g`) dan mengubah nama grup (`groupmod -n`).
- Membedakan primary group dan secondary group.

## 03 Permission Fundamentals
- Menjelaskan arti `r` (read), `w` (write), `x` (execute) bagi user, group, dan others.
- Menghubungkan permission simbolik (`rw-r--r--`) dengan octal (`644`).
- Memilih kombinasi permission yang tepat untuk file vs direktori.

## 04 Ownership Management
- Mengubah ownership dengan `chown` dan `chgrp`.
- Mengubah ownership secara rekursif (`chown -R`).
- Mengubah permission sesuai kebutuhan (`chmod 640`, `750`, `644`).
- Memahami pengaruh `umask` terhadap permission file baru.

## 05 Access Testing
- Menguji akses file/direktori sebagai pengguna lain dengan `sudo -u`.
- Membuktikan permission bekerja sesuai konfigurasi (user/group/others).
- Menjelaskan hasil akses yang berhasil dan gagal beserta alasannya.

## 06 Permission Analysis
- Menganalisis permission file sistem (`/etc/passwd`, `/etc/shadow`, `/etc/sudoers`).
- Menjelaskan alasan pemilihan konfigurasi hak akses berdasarkan prinsip least privilege.
- Menerapkan klasifikasi data (publik/internal/rahasia) ke permission yang sesuai.
- Memahami mengapa key private SSH harus `600`.

# LINUX-03: Software, Process, Services

## 01 Package Management
- Memasang perangkat lunak dari repositori resmi dengan `pacman -S`.
- Memperbarui semua paket dengan `pacman -Syu`.
- Menghapus paket beserta dependensi orfan dengan `pacman -Rns`.
- Memverifikasi hasil installasi (`which`, cek versi, jalankan).
- Membedakan official repository dan AUR (`yay`/`paru`).

## 02 Process Management
- Memantau proses berjalan dengan `ps` dan `top`.
- Menemukan PID proses dengan `pgrep` dan `pidof`.
- Menghentikan proses dengan `kill` (TERM vs KILL) dan `killall`.
- Mengatur prioritas proses dengan `renice` (nilai -20 hingga 19).
- Mengelola background jobs (`&`, `jobs`, `fg`, `bg`).

## 03 Service Management
- Menjalankan, menghentikan, dan me-restart service dengan `systemctl`.
- Mengaktifkan service agar berjalan saat boot dengan `systemctl enable`.
- Memverifikasi status service dengan `systemctl is-active` dan `is-enabled`.
- Membaca log service dengan `journalctl -u`.

## 04 Task Scheduling
- Menjadwalkan tugas berulang dengan systemd timers (`OnCalendar`).
- Memastikan timer berjalan saat boot dengan `systemctl enable --now`.
- Menjalankan tugas sekali/jadwal dengan `systemd-run --on-calendar`.
- Memverifikasi eksekusi jadwal dengan `systemctl list-timers` dan `journalctl`.
- Mengetahui alternatif cronie di Arch (`pacman -S cronie`).

# LINUX-04: Network, Remote Access

## 01 Network Configuration
- Memeriksa alamat IP, gateway, dan DNS resolver (`ip addr`, `ip route`, `resolv.conf`).
- Menguji konektivitas basis (`ping`, `nslookup`).
- Memeriksa port yang listening (`ss -tuln`).

## 02 Network Troubleshooting
- Mendiagnosis gangguan konektivitas bertahap: localhost → gateway → internet → DNS.
- Menelusuri path jaringan dengan `tracepath`.
- Mengakses log service dengan `journalctl -u`.
- Menguji koneksi TCP (`/dev/tcp`) dan routing (`ip route get`).

## 03 SSH Key Authentication
- Membuat SSH key pair (`ssh-keygen`) dan setup `authorized_keys`.
- Mengonfigurasi `sshd_config` untuk key-only auth (`PasswordAuthentication no`).
- Membatasi login tidak perlu (`PermitRootLogin no`).
- Memverifikasi koneksi SSH tanpa password.

## 04 Host Firewall
- Mengatur firewall dengan `iptables` — policy DROP, allow loopback/established/SSH.
- Mengonfigurasi `nftables` sebagai alternatif modern.
- Menyimpan rules permanen (`iptables-save`, `nft list ruleset`).

# LINUX-05: Monitoring, Storage, Troubleshooting

## 01 Log Analysis
- Menganalisis log sistem dan layanan (`journalctl`, `dmesg`, `last`, `lastb`).
- Filter log per priority/service/boot dan mencari pola dengan `grep`.
- Memeriksa riwayat login dan log aplikasi/paket (`/var/log/pacman.log`).

## 02 Resource Monitoring
- Memantau CPU (`top`, `htop`, `vmstat`), RAM (`free`, `ps --sort=-%mem`), dan storage (`df`, `du`).
- Memahami load average dan interprestasinya terhadap jumlah CPU.
- Mengidentifikasi proses boros resource dan file besar yang boros storage.

## 03 Storage Management
- Inspeksi block device (`lsblk`, `df`, `mount`).
- Membuat filesystem (`mkfs.ext4`, `mkfs.vfat`) via loop device (aman).
- Mount/unmount volume dan konfigurasi `fstab` persisten.

## 04 Backup and Recovery
- Mencadangkan data dengan `tar` (archive) dan `rsync` (inkremental).
- Memverifikasi integritas cadangan (`sha256sum`).
- Memulihkan data dari backup dan membuktikan restore berhasil.

## 05 System Troubleshooting
- Troubleshooting sistematis 5 langkah: Identifikasi → Data → Diagnosis → Tindakan → Verifikasi.
- Mengumpulkan data: log kernel/service, resource, network, boot analysis.
- Tindakan perbaikan: `systemctl restart`, `journalctl --vacuum`, cleanup storage.
