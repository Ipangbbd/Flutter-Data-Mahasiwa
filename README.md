# Aplikasi Manajemen Data Mahasiswa

## Deskripsi
Aplikasi Flutter untuk mengelola data mahasiswa dengan fitur CRUD (Create, Read, Update, Delete) dan penyimpanan lokal. Dibuat dengan Material 3 design dan arsitektur yang bersih.

## Fitur Utama
- **Dashboard**: Daftar mahasiswa dengan counter total dan filter
- **Tambah Mahasiswa**: Form input data baru dengan validasi
- **Edit Mahasiswa**: Ubah data mahasiswa yang sudah ada
- **Hapus Mahasiswa**: Hapus data dengan opsi undo
- **Pencarian**: Cari mahasiswa berdasarkan NIM
- **Filter Gender**: Filter berdasarkan jenis kelamin
- **Penyimpanan Lokal**: Data tersimpan di device menggunakan SharedPreferences
- **Welcome Screen**: Halaman sambutan yang menarik
- **Team Page**: Informasi anggota tim pengembang

## Struktur Data Mahasiswa
- **Nama**: String (wajib)
- **NIM**: String unik (wajib)
- **Jurusan**: String (wajib)
- **Gender**: Enum (Laki-laki/Perempuan)

## Teknologi yang Digunakan
- **Flutter**: Framework UI cross-platform
- **Material 3**: Design system modern
- **SharedPreferences**: Penyimpanan lokal sederhana
- **JSON**: Serialisasi data

## Struktur Project
```
lib/
├── main.dart                 # Entry point aplikasi
├── models/
│   └── student.dart          # Model data mahasiswa
├── repositories/
│   └── student_repository.dart # Akses penyimpanan lokal
├── FormPage.dart             # Dashboard utama
├── form_biodata.dart         # Form tambah/edit
├── Detail_Biodata.dart       # Halaman detail
├── welcome_screen.dart       # Halaman sambutan
└── team_page.dart            # Halaman tim
```

## Cara Menjalankan
1. Pastikan Flutter SDK terinstall
2. Clone repository ini
3. Jalankan `flutter pub get` untuk install dependencies
4. Jalankan `flutter run` untuk menjalankan aplikasi

## Dependencies
- `shared_preferences: ^2.2.2` - Penyimpanan lokal

## Tim Pengembang
- Muhammad Ali Irfansyah
- Muhammad Ibnu Riyansyah
- Muhamad Ragil Jaushaq Fauzi
- Muhammad Rovi
- Prima Asadafa
- Rakha Maide Ghafitri
- Riza Alvaro

## Dokumentasi
Lihat [docs/Function_Annotations.md](docs/Function_Annotations.md) untuk penjelasan detail setiap fungsi dan komponen.

## Lisensi
Project ini dibuat untuk keperluan pembelajaran dan pengembangan aplikasi mobile.
