# Lab 05: Command Output Analysis

## Objective
Memahami dan mempraktikkan analisis output perintah: redirect, pipe, dan navigasi file besar.

## Environment
- OS: Arch Linux
- Kernel: 7.2.11-arch1-1
- Shell: zsh
- Interface: Terminal
- User: nyxx

## Practical Implementation
```bash
# Redirect output ke file (overwrite)
ls -la > daftar.txt
cat daftar.txt

# Redirect output ke file (append)
echo "Baris baru" >> daftar.txt
cat daftar.txt

# Gabungkan stdout dan stderr
ls /nonexistent 2>&1 > error-log.txt
cat error-log.txt

# Pipe: alirkan output ke perintah lain
ls -la | head -5
ls -la | wc -l
ps aux | grep ssh

# Pipe dengan grep: filter output
ls -la | grep README
ps aux | grep bash
history | grep git

# Baca file besar dengan less
less daftar.txt
# Navigasi: j/k (turun/naik), space (half page), q (keluar), /cari (search)

# Lihat awal file (head)
head -3 daftar.txt

# Lihat akhir file (tail)
tail -3 daftar.txt
tail -f /var/log/syslog   # live follow

# Kombinasi pipe dan redirect
ls -la | grep -i readme > readme-list.txt
cat readme-list.txt
```

## Expected Result
File `daftar.txt` berisi listing direktori, `error-log.txt` menangkap pesan error dari `ls /nonexistent`, dan pipe mengalirkan output antar perintah dengan benar.

## Analysis
- `>` menimpa (overwrite) file, `>>` menambahkan (append) ke akhir file.
- `2>&1` mengarahkan stderr ke stdout, berguna untuk mencatat error.
- Pipe `|` mengalirkan stdout perintah kiri ke stdin perintah kanan.
- `less` memungkinkan navigasi file besar tanpa memuat seluruhnya ke memori.
- `head -n` menampilkan N baris awal, `tail -n` menampilkan N baris akhir.
- `tail -f` mengikuti file secara live, cocok untuk monitoring log.

## Evidence
Screenshot praktik aslinya sudah tersimpan di folder `evidence/`:
- `evidence/evidence-1.png`
- `evidence/evidence-2.png`
- `evidence/evidence-3.png`
- `evidence/evidence-4.png`
- `evidence/evidence-5.png`

## Conclusion
Praktik successfully menunjukkan penggunaan redirect (`>`, `>>`, `2>&1`), pipe (`|`), dan perintah navigasi file (`less`, `head`, `tail`, `grep`) untuk menganalisis dan mengelola output perintah di Linux.