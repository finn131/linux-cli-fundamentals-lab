# Lab 03: Basic Linux Command

## Objective
Memahami dan mempraktikkan perintah dasar Linux: akses manual page, temukan lokasi binary, kelola riwayat perintah, dan bersihkan terminal.

## Environment
- OS: Arch Linux
- Kernel: 7.2.11-arch1-1
- Shell: zsh
- Interface: Terminal
- User: nyxx

## Practical Implementation
```bash
# Baca manual page (tekan q untuk keluar)
man ls

# Cari manual page berdasarkan kata kunci
man -k copy
man -k file

# Cari lokasi binary
which cp
which zsh
which python3

# Cari lokasi binary + info tambahan
whereis cp
whereis zsh

# Lihat riwayat perintah
history
history 20

# Ulangi perintah dari history
!ls
!!
!$

# Bersihkan terminal
clear
# atau tekan Ctrl + L
```

## Expected Result
Terminal bersih, manual page `ls` ditampilkan, output `which` dan `whereis` menunjukkan path binary yang benar, dan riwayat perintah dapat diakses.

## Analysis
- `man perintah` menampilkan halaman bantuan (manual page) untuk perintah tersebut.
- `man -k kata_kunci` mencari manual page berdasarkan kata kunci tanpa membuka halaman.
- `which perintah` menunjukkan path binary yang dijalankan (prioritas PATH).
- `whereis perintah` menunjukkan path binary, source, dan manual page.
- `history` menampilkan daftar perintah yang pernah dijalankan, `!!` mengulang perintah terakhir, `!$` mengambil argumen terakhir.
- `clear` atau `Ctrl + L` membersihkan layar terminal.

## Evidence
Screenshot praktik aslinya sudah tersimpan di folder `evidence/`:
- `evidence/evidence-1.png`
- `evidence/evidence-2.png`
- `evidence/evidence-3.png`
- `evidence/evidence-4.png`

## Conclusion
Praktik successfully menunjukkan penggunaan perintah dasar (`man`, `which`, `whereis`, `history`, `clear`) untuk mengakses bantuan, menemukan binary, dan mengelola riwayat perintah di Linux.