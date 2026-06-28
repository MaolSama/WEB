# CompareDeck — Web Perbandingan Spesifikasi Laptop

Stack: **HTML + CSS + Vanilla JS** (frontend) — **PHP native + MySQL** (backend/API).
PHP dipakai sebagai jembatan ke MySQL karena browser tidak bisa connect ke database secara langsung.

## Fitur

- Katalog laptop: search, filter berdasarkan kebutuhan (Programming/Data Science/Design/Gaming/Office), sort harga & rating.
- **Compare Box**: tambahkan 2–3 laptop (maksimal 3, divalidasi di frontend & backend) untuk dibandingkan, seperti keranjang belanja.
- Halaman **Compare**: tabel data sheet, nilai terbaik per baris (harga termurah, RAM/storage/rating/garansi/resolusi terbesar) ditandai warna emas.
- **Login Admin** (session-based, password di-hash dengan `password_hash`).
- **CRUD laptop** khusus admin (tambah/edit/hapus), divalidasi juga di sisi API (bukan cuma disembunyikan di UI).

## Instalasi (XAMPP / Laragon)

1. Salin folder `compare-deck` ke `htdocs` (XAMPP) atau `www` (Laragon).
2. Buka phpMyAdmin, import file `database/laptop_compare.sql`. Ini akan membuat database `laptop_compare` beserta tabel `kebutuhan`, `laptop`, `rule_kebutuhan`, dan `users`.
3. Cek `config/database.php` — sesuaikan `DB_USER`/`DB_PASS` jika MySQL kamu pakai password.
4. Jalankan `http://localhost/compare-deck/setup.php` di browser **satu kali** untuk membuat akun admin pertama (isi username & password sendiri).
5. **Hapus file `setup.php`** setelah akun admin berhasil dibuat (supaya tidak disalahgunakan orang lain).
6. Login lewat `http://localhost/compare-deck/login.php` menggunakan akun yang baru dibuat.

## Struktur Folder

```
compare-deck/
├── api/                # Endpoint backend (JSON)
│   ├── auth.php        # login, logout, check session
│   └── laptops.php     # list, get, compare, kebutuhan, create, update, delete
├── admin/
│   └── index.php       # Dashboard CRUD (khusus admin)
├── assets/
│   ├── css/style.css
│   └── js/             # api.js, home.js, compare.js, admin.js, login.js
├── config/database.php # Koneksi PDO
├── includes/auth_check.php
├── database/laptop_compare.sql
├── setup.php            # Seed admin sekali jalan (hapus setelah dipakai)
├── index.php            # Katalog (home)
├── login.php
├── logout.php
└── compare.php
```

## Catatan Desain

Palet warna sengaja dibuat netral (abu kebiruan + putih) supaya tidak terlalu terang atau gelap, dengan satu aksen warna emas pudar (`#c9952e`) untuk menonjolkan harga, tombol utama, dan nilai spek terbaik di tabel perbandingan — memberi kesan "data sheet" produk premium. Angka dan data spesifikasi konsisten memakai font monospace (IBM Plex Mono), sedangkan judul memakai Space Grotesk, supaya datanya mudah dipindai dan terasa lebih profesional dibanding tabel polos.

## Akun & Keamanan

- Tidak ada password default yang ditanam di kode — kamu yang menentukan lewat `setup.php`.
- Semua endpoint tulis (`create`, `update`, `delete`) divalidasi session admin di server (`api/laptops.php`), bukan cuma disembunyikan di tampilan.
- Password disimpan dalam bentuk hash (`password_hash`/`password_verify`), tidak plain text.
