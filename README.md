# 🎓 Aplikasi Manajemen Data Mahasiswa

[![Flutter](https://img.shields.io/badge/Flutter-3.22-blue?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.4-blue?logo=dart)](https://dart.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20|%20iOS%20|%20Web-green)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Maintained](https://img.shields.io/badge/Maintained-yes-success)]()
[![GitHub stars](https://img.shields.io/github/stars/Ipangbbd/Flutter-Data-Mahasiwa?style=social)](https://github.com/Ipangbbd/Flutter-Data-Mahasiwa/stargazers)

A **Flutter app** untuk mengelola data mahasiswa dengan fitur CRUD (Create, Read, Update, Delete) dan penyimpanan lokal.  
Dibuat menggunakan **Material 3 design** dan arsitektur yang bersih.  

---

## ✨ Fitur Utama

- 📊 **Dashboard** – Daftar mahasiswa dengan counter total & filter  
- ➕ **Tambah Mahasiswa** – Form input data baru dengan validasi  
- ✏️ **Edit Mahasiswa** – Ubah data mahasiswa yang sudah ada  
- 🗑️ **Hapus Mahasiswa** – Hapus data dengan opsi undo  
- 🔎 **Pencarian** – Cari mahasiswa berdasarkan NIM  
- 🚻 **Filter Gender** – Filter berdasarkan jenis kelamin  
- 💾 **Penyimpanan Lokal** – Data tersimpan di device menggunakan SharedPreferences  
- 👋 **Welcome Screen** – Halaman sambutan yang menarik  
- 👥 **Team Page** – Informasi anggota tim pengembang  

---

## 🗂️ Struktur Data Mahasiswa

- **Nama**: `String` (wajib)  
- **NIM**: `String unik` (wajib)  
- **Jurusan**: `String` (wajib)  
- **Gender**: `Enum (Laki-laki / Perempuan)`  

---

## 🛠️ Teknologi yang Digunakan

- [Flutter](https://flutter.dev) – Framework UI cross-platform  
- [Material 3](https://m3.material.io) – Modern design system  
- [SharedPreferences](https://pub.dev/packages/shared_preferences) – Penyimpanan lokal sederhana  
- [JSON](https://www.json.org) – Serialisasi data  

---

## 📂 Struktur Project

```

lib/
├── main.dart                   # Entry point aplikasi
├── models/
│   └── student.dart            # Model data mahasiswa
├── repositories/
│   └── student\_repository.dart # Akses penyimpanan lokal
├── FormPage.dart               # Dashboard utama
├── form\_biodata.dart           # Form tambah/edit
├── Detail\_Biodata.dart         # Halaman detail
├── welcome\_screen.dart         # Halaman sambutan
└── team\_page.dart              # Halaman tim

````

---

## 🚀 Cara Menjalankan

1. Pastikan **Flutter SDK** sudah terinstall  
2. Clone repository ini  
   ```bash
   git clone https://github.com/Ipangbbd/Flutter-Data-Mahasiwa.git
   cd Flutter-Data-Mahasiwa
````

3. Install dependencies

   ```bash
   flutter pub get
   ```
4. Jalankan aplikasi

   ```bash
   flutter run
   ```

---

## 📦 Dependencies

* `shared_preferences: ^2.2.2` – Penyimpanan lokal

---

## 🗺️ Roadmap

* [ ] 📑 Export data mahasiswa ke CSV / PDF
* [ ] 🔐 Autentikasi pengguna & role admin
* [ ] ☁️ Integrasi database cloud (Firebase / Supabase)
* [ ] 🎨 Dark mode & custom theme support
* [ ] 📱 Responsif untuk Web & Tablet
* [ ] 📊 Statistik jumlah mahasiswa per jurusan / gender
* [ ] 🌍 Multi-bahasa (ID / EN)

---

## 👨‍💻 Tim Pengembang

* Muhammad Ali Irfansyah
* Muhammad Ibnu Riyansyah
* Muhamad Ragil Jaushaq Fauzi
* Muhammad Rovi
* Prima Asadafa
* Rakha Maide Ghafitri
* Riza Alvaro

---

## 📖 Dokumentasi

📑 Lihat [docs/Function\_Annotations.md](docs/Function_Annotations.md)
untuk penjelasan detail setiap fungsi dan komponen.

---

## 📜 Lisensi

Project ini dibuat untuk **keperluan pembelajaran dan pengembangan aplikasi mobile**.
Distribusi dan modifikasi diperbolehkan untuk tujuan edukasi.
Mau aku bikinin **versi Finance Manager** juga yang udah include badges biar konsisten semua repo kamu keliatan keren?
```
