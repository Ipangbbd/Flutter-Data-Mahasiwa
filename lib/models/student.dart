import 'package:flutter/foundation.dart';

enum Gender { male, female }

extension GenderLabel on Gender {
  String get label => this == Gender.male ? 'Laki-laki' : 'Perempuan';
}

@immutable
class Student {
  final String nama;
  final String nim;
  final String jurusan;
  final Gender gender;

  const Student({
    required this.nama,
    required this.nim,
    required this.jurusan,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
        'nama': nama,
        'nim': nim,
        'jurusan': jurusan,
        'gender': describeEnum(gender),
      };

  factory Student.fromJson(Map<String, dynamic> json) {
    final String genderStr = (json['gender'] as String? ?? '').toLowerCase();
    final Gender g = genderStr == 'male'
        ? Gender.male
        : genderStr == 'female'
            ? Gender.female
            : Gender.male;
    return Student(
      nama: json['nama'] as String? ?? '',
      nim: json['nim'] as String? ?? '',
      jurusan: json['jurusan'] as String? ?? '',
      gender: g,
    );
  }
}


