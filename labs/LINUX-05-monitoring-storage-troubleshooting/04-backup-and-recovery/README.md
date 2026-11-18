# Lab 04: Backup and Recovery

## Objective
Mencadangkan dan memulihkan data, memverifikasi integritas cadangan.

## Environment
- OS: Arch Linux
- Kernel: 7.2.11-arch1-1
- Shell: zsh
- Tools: tar, rsync, sha256sum
- Workspace: /home/nyxx
- User: nyxx (uid 1000)

## Practical Implementation
```bash
# 1. Siapkan data untuk dicadangkan
mkdir -p ~/backup-lab/data
echo "Konfigurasi penting #1" > ~/backup-lab/data/config1.txt
echo "Konfigurasi penting #2" > ~/backup-lab/data/config2.txt
echo "Data produksi" > ~/backup-lab/data/db.txt
ls -la ~/backup-lab/data/

# 2. Backup dengan tar (compressed)
tar -czf ~/backup-lab/backup-data.tar.gz -C ~/backup-lab data
ls -lh ~/backup-lab/backup-data.tar.gz

# 3. Verifikasi integritas archive
sha256sum ~/backup-lab/backup-data.tar.gz
# simpan checksum
sha256sum ~/backup-lab/backup-data.tar.gz | tee ~/backup-lab/backup-data.tar.gz.sha256

# 4. Cek isi archive (tanpa extract)
tar -tzf ~/backup-lab/backup-data.tar.gz

# 5. Simulasi kehilangan data — hapus folder asli
rm -rf ~/backup-lab/data
ls ~/backup-lab/

# 6. Restore dari backup
tar -xzf ~/backup-lab/backup-data.tar.gz -C ~/backup-lab/
ls -la ~/backup-lab/data/
cat ~/backup-lab/data/config1.txt

# 7. Verifikasi data terrestore cocok
sha256sum -c ~/backup-lab/backup-data.tar.gz.sha256

# 8. Sync dengan rsync (backup inkremental)
mkdir -p ~/backup-lab/restore
rsync -av ~/backup-lab/data/ ~/backup-lab/restore/
ls -la ~/backup-lab/restore/

# Tambah file baru, sync ulang
echo "Data baru" > ~/backup-lab/data/config3.txt
rsync -av --delete ~/backup-lab/data/ ~/backup-lab/restore/
ls -la ~/backup-lab/restore/

# 9. Buat versi backup bertanggal
DATE=$(date +%Y%m%d)
tar -czf ~/backup-lab/backup-$DATE.tar.gz -C ~/backup-lab data
ls -lh ~/backup-lab/backup-*.tar.gz

# 10. Bersihkan (jika sudah selesai)
rm -rf ~/backup-lab
```

## Expected Result
- `backup-data.tar.gz` tercipta dan bisa diverifikasi dengan `sha256sum`.
- Setelah `rm -rf data`, restore `tar -xzf` mengembalikan folder `data/` beserta seluruh isinya.
- `sha256sum -c` mengembalikan `OK` — integritas cadangan terbukti.
- `rsync -av` menyalin folder dan update inkremental; `--delete` menyinkronkan penghapusan.
- Backup bertanggal `backup-YYYYMMDD.tar.gz` tercipta.

## Analysis
- `tar -czf`: `c`reate, `z` compress (gzip), `f` file. `--` untuk flag panjang.
- `-C DIR` mengubah directory sebelum file — archive relatif, lebih mudah di-restore di mesin lain.
- **Verifikasi integritas wajib**: `sha256sum -c` membuktikan archive tidak korup.
- `rsync -a` archive mode (permission, timestamp, symlink, recursive), `v` verbose.
- `rsync --delete` membuat dest persis seperti source (hapus file dest yang tidak ada di source).
- Backup bertanggal (`backup-$(date +%Y%m%d).tar.gz`) = simple retention: buang file lama.
- Prinsip: **backup tanpa uji restore = belum backup**. Test restore adalah bagian inti.

## Evidence
Screenshot praktik aslinya sudah tersimpan di folder `evidence/`:
- ![EVIDENCE 1](evidence/evidence-1.png)
- ![EVIDENCE 2](evidence/evidence-2.png)
- ![EVIDENCE 3](evidence/evidence-3.png)
- ![EVIDENCE 4](evidence/evidence-4.png)

## Conclusion
Praktik successfully menunjukkan pencadangan data (`tar -czf`, `rsync -av`), verifikasi integritas (`sha256sum -c`), dan pemulihan data (restore dari archive) secara lengkap dan teruji.