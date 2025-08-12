import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flut/models/student.dart';

class StudentRepository {
  static const String _key = 'students_v1';

  Future<List<Student>> loadStudents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return <Student>[];
    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => Student.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveStudents(List<Student> students) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String raw = jsonEncode(students.map((e) => e.toJson()).toList());
    await prefs.setString(_key, raw);
  }
}


