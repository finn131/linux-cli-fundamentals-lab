# Lab 03: Storage Management

## Objective
Mengelola volume, filesystem, dan mount — dari inspeksi perangkat sampai mount/unmount yang benar.

## Environment
- OS: Arch Linux
- Kernel: 7.2.11-arch1-1
- Storage: `/dev/nvme0n1p2` (120G ext4, `/`), `/dev/nvme0n1p3` (1.1G vfat, `/boot`), `sda` (SATA, NTFS partisi)
- Tools: lsblk, fdisk, mkfs.ext4, mkfs.vfat, mount, umount, losetup
- User: nyxx (uid 1000, wheel group — sudo untuk operasi storage)

## Practical Implementation
```bash
# 1. Inspeksi block device
lsblk
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT
lsblk -f                      # dengan filesystem label

# 2. Detail kapasitas dan mount
df -hT
mount | grep -v 'proc\|sys\|cgroup\|dev'
cat /etc/fstab                # konfigurasi mount persisten

# 3. Analisis pemakaian disk
du -sh /var/log /usr /home
du -xh --max-depth=1 / | sort -rh | head -10
df -i /                       # inode usage

# ========================================================
# PRAKTIK AMAN: gunakan loop device, JANGAN partisi asli
# ========================================================

# 4. Buat image disk (volume virtual 100MB)
dd if=/dev/zero of=/tmp/testdisk.img bs=1M count=100 status=none

# 5. Pasang ke loop device
sudo losetup /dev/loop9 /tmp/testdisk.img
lsblk | grep loop

# 6. Buat filesystem ext4 di volume
sudo mkfs.ext4 /dev/loop9

# 7. Mount volume
sudo mkdir -p /mnt/testdisk
sudo mount /dev/loop9 /mnt/testdisk
df -h /mnt/testdisk
mount | grep testdisk

# 8. Uji write di mount
echo "lab data" | sudo tee /mnt/testdisk/lab.txt
sudo ls -la /mnt/testdisk/

# 9. Unmount (flush dulu)
sync
sudo umount /mnt/testdisk
mount | grep testdisk || echo "testdisk sudah unmounted"

# 10. Lepas loop device
sudo losetup -d /dev/loop9
rm /tmp/testdisk.img

# 11. Format ulang dengan vfat (untuk partisi USB)
dd if=/dev/zero of=/tmp/testusb.img bs=1M count=50 status=none
sudo losetup /dev/loop10 /tmp/testusb.img
sudo mkfs.vfat /dev/loop10
sudo mkdir -p /mnt/testusb
sudo mount /dev/loop10 /mnt/testusb
df -h /mnt/testusb
sudo umount /mnt/testusb
sudo losetup -d /dev/loop10
rm /tmp/testusb.img

# 12. Konfigurasi mount persisten (contoh entri fstab)
# /dev/loop9   /mnt/testdisk   ext4   defaults,nofail   0 2
# nofail = boot tidak hang jika device tidak ada
cat /etc/fstab | grep -v '^#' | grep -v '^$'
```

## Expected Result
- `lsblk -f` menampilkan seluruh block device beserta FSTYPE dan MOUNTPOINT.
- `df -hT` menunjukkan kapasitas setiap filesystem beserta tipe-nya.
- Loop device ter-mount di `/mnt/testdisk` dengan filesystem ext4, bisa ditulis.
- Setelah `umount`, `/mnt/testdisk` kosong dan `mount | grep testdisk` tidak menampilkan apa-apa.
- `mkfs.vfat` berhasil membuat filesystem FAT di image kedua.

## Analysis
- `lsblk` = tree block device, `-f` tambah label/UUID, `-o` pilih kolom.
- **UUID di fstab** lebih aman daripada path (`/dev/nvme0n1p2`) — UUID tetap meski partisi pindah slot.
- `mkfs.ext4` membuat filesystem ext4; **`mkfs` menghapus semua data** di perangkat — selalu cek nama device dulu!
- Loop device: cara aman melatih mount/mkfs tanpa menyentuh partisi fisik.
- `sync` sebelum `umount` memastikan semua data tertulis ke device.
- `nofail` di fstab: boot tidak berhenti jika device mount-nya tidak ada saat boot.
- `df -i` cek inode — filesystem bisa penuh inode walau space masih ada.

## Evidence
Screenshot praktik aslinya sudah tersimpan di folder `evidence/`:
- ![EVIDENCE 1](evidence/evidence-1.png)
- ![EVIDENCE 2](evidence/evidence-2.png)
- ![EVIDENCE 3](evidence/evidence-3.png)
- ![EVIDENCE 4](evidence/evidence-4.png)

## Conclusion
Praktik successfully menunjukkan pengelolaan storage — inspeksi perangkat (`lsblk`, `df`), pembuatan filesystem (`mkfs.ext4`, `mkfs.vfat`) via loop device, serta mount/unmount yang benar (`mount`, `umount`, `sync`).