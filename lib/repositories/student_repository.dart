// Mengimpor utilitas untuk enkode/dekode JSON
import 'dart:convert';

// SharedPreferences dipakai sebagai penyimpanan lokal sederhana (key-value)
import 'package:shared_preferences/shared_preferences.dart';
// Model Student yang akan disimpan/dimuat
import 'package:flut/models/student.dart';

// Repository yang mengelola penyimpanan data mahasiswa secara lokal
class StudentRepository {
  // Kunci untuk menyimpan list mahasiswa (versi 1)
  static const String _key = 'students_v1';

  // Memuat daftar mahasiswa dari penyimpanan lokal
  Future<List<Student>> loadStudents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return <Student>[];
    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => Student.fromJson(e as Map<String, dynamic>)).toList();
  }

  // Menyimpan daftar mahasiswa ke penyimpanan lokal
  Future<void> saveStudents(List<Student> students) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String raw = jsonEncode(students.map((e) => e.toJson()).toList());
    await prefs.setString(_key, raw);
  }
}


