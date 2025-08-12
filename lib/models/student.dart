// Mengimpor utilitas Flutter untuk fitur seperti describeEnum
import 'package:flutter/foundation.dart';

// Enum untuk merepresentasikan gender mahasiswa
enum Gender { male, female }

// Ekstensi untuk menambahkan label ramah pengguna pada enum Gender
extension GenderLabel on Gender {
  // Mengembalikan teks label untuk ditampilkan di UI
  String get label => this == Gender.male ? 'Laki-laki' : 'Perempuan';
}

// Menandai kelas immutable (semua field final, objek tidak berubah)
@immutable
class Student {
  // Nama mahasiswa
  final String nama;
  // Nomor Induk Mahasiswa (unik)
  final String nim;
  // Jurusan mahasiswa
  final String jurusan;
  // Gender mahasiswa
  final Gender gender;

  // Konstruktor dengan parameter wajib
  const Student({
    required this.nama,
    required this.nim,
    required this.jurusan,
    required this.gender,
  });

  // Mengubah objek Student menjadi Map untuk diserialisasi (JSON)
  Map<String, dynamic> toJson() => {
        'nama': nama,
        'nim': nim,
        'jurusan': jurusan,
        // describeEnum mengubah enum ke string tanpa prefix nama enum
        'gender': describeEnum(gender),
      };

  // Factory untuk membuat Student dari Map (hasil decode JSON)
  factory Student.fromJson(Map<String, dynamic> json) {
    // Normalisasi string gender agar aman
    final String genderStr = (json['gender'] as String? ?? '').toLowerCase();
    // Mapping string menjadi enum; default ke male bila tidak valid
    final Gender g = genderStr == 'male'
        ? Gender.male
        : genderStr == 'female'
            ? Gender.female
            : Gender.male;
    // Membuat instance Student dengan fallback string kosong bila null
    return Student(
      nama: json['nama'] as String? ?? '',
      nim: json['nim'] as String? ?? '',
      jurusan: json['jurusan'] as String? ?? '',
      gender: g,
    );
  }
}


