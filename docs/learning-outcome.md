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
