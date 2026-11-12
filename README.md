# Linux CLI Fundamentals Lab

Hands-on Linux Command Line Interface (CLI) lab. Mulai dari navigasi dasar, manajemen file, sampai manajemen user dan permission.

## Environment
- OS: Arch Linux
- Kernel: 7.2.11-arch1-1
- Shell: zsh
- User: nyxx

Detail environment lengkap di `docs/lab-environment.md`.

## Struktur
```
.
├── README.md
├── docs/
│   ├── lab-environment.md
│   └── learning-outcome.md
├── scripts/
│   ├── system-info.sh
│   └── user-audit.sh
└── labs/
    ├── LINUX-01-basic-linux/
    │   ├── 01-directory-navigation/
    │   │   └── evidence/
    │   ├── 02-file-management/
    │   │   └── evidence/
    │   ├── 03-basic-linux-command/
    │   │   └── evidence/
    │   ├── 04-file-permissions/
    │   │   └── evidence/
    │   └── 05-command-output-analysis/
    │       └── evidence/
    ├── LINUX-02-user-management/
    │   ├── 01-user-management/
    │   │   └── evidence/
    │   ├── 02-group-management/
    │   │   └── evidence/
    │   ├── 03-permission-fundamentals/
    │   │   └── evidence/
    │   ├── 04-ownership-management/
    │   │   └── evidence/
    │   ├── 05-access-testing/
    │   │   └── evidence/
    │   └── 06-permission-analysis/
    │       └── evidence/
    └── LINUX-03-software-process-services/
        ├── 01-package-management/
        │   └── evidence/
        ├── 02-process-management/
        │   └── evidence/
        ├── 03-service-management/
        │   └── evidence/
        └── 04-task-scheduling/
            └── evidence/
```

## Cara Mulai
1. Baca `docs/learning-outcome.md` untuk paham tujuan tiap lab.
2. Cek `docs/lab-environment.md` untuk detail environment.
3. Ikuti langkah-langkah di README masing-masing folder `labs/`.
4. Jalankan perintah di terminal, catat output ke folder `evidence/` (screenshot atau `tee`).
5. Untuk contoh script, lihat `scripts/system-info.sh` dan `scripts/user-audit.sh`.

## Kompetensi
| Kompetensi | Topik |
|------------|-------|
| **LINUX-01: Basic Linux** | 01 Directory Navigation · 02 File Management · 03 Basic Linux Command · 04 File Permissions · 05 Command Output Analysis |
| **LINUX-02: User Management** | 01 User Management · 02 Group Management · 03 Permission Fundamentals · 04 Ownership Management · 05 Access Testing · 06 Permission Analysis |
| **LINUX-03: Software, Process, Services** | 01 Package Management · 02 Process Management · 03 Service Management · 04 Task Scheduling |
