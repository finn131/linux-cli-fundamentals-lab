# Lab 02: File Management

## Objective
Memahami dan mempraktikkan pengelolaan file dasar di Linux (membuat, menyalin, memindahkan, menghapus.

## Environment
- OS: Arch Linux
- Kernel: 7.2.11-arch1-1
- Shell: zsh
- Interface: Terminal
- User: nyxx

## Practical Implementation
```bash
# Buat file baru
touch catatan.txt
touch catatan2.txt
ls -la

# Tulis isi file (overwrite >, append >>)
echo "Halo, ini adalah baris pertama." > catatan.txt
echo "Ini baris kedua." >> catatan.txt
cat catatan.txt

# Salin file
cp catatan.txt catatan-backup.txt
cat catatan-backup.txt

# Salin direktori secara rekursif
cp -r docs docs-backup
ls -la

# Pindah / rename file
mv catatan.txt catatan-utama.txt
cat catatan-utama.txt

# Hapus file
rm catatan-backup.txt
ls -la

# Hapus direktori secara rekursif
rm -rf docs-backup
ls -la
```

## Expected Result
File `catatan-utama.txt` tersisa dengan isi dua baris, file backup dan direktori `docs-backup` sudah terhapus, dan `catatan2.txt` masih ada.

## Analysis
- `touch` membuat file kosong atau memperbarui timestamp akses/modifikasi.
- `echo "teks" > file` menulis ke file (overwrite — menggantikan isi lama).
- `echo "teks" >> file` menambahkan ke akhir file (append — tidak menggantikan isi lama).
- `cp file1 file2` menyalin file, `cp -r dir1 dir2` menyalin direktori secara rekursif.
- `mv file1 file2` memindahkan atau mengubah nama file.
- `rm file` menghapus file, `rm -rf dir` menghapus direktori secara rekursif tanpa konfirmasi — berbahaya jika salah sasaran.
- `cat file` menampilkan isi file ke terminal.

## Evidence
Screenshot praktik aslinya sudah tersimpan di folder `evidence/`:
- `evidence/evidence-1.png`
- `evidence/evidence-2.png`
- `evidence/evidence-3.png`
- `evidence/evidence-4.png`
- `evidence/evidence-5.png`

## Conclusion
Praktik successfully menunjukkan penggunaan perintah file management (`touch`, `echo`, `cp`, `mv`, `rm`, `cat`) untuk membuat, menyalin, memindahkan, dan mengambil file di Linux.