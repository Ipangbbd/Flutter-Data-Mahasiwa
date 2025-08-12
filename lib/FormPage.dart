import 'package:flutter/material.dart';
import 'package:flut/Detail_Biodata.dart';
import 'package:flut/form_biodata.dart';
import 'package:flut/models/student.dart';
import 'package:flut/repositories/student_repository.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final StudentRepository _repository = StudentRepository();
  final List<Student> _students = <Student>[];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadStudents() async {
    final loaded = await _repository.loadStudents();
    if (loaded.isEmpty) {
      _students.addAll(const <Student>[
        Student(nama: 'Jhony', nim: '12181001', jurusan: 'Informatika', gender: Gender.male),
        Student(nama: 'Andi', nim: '12181002', jurusan: 'Sistem Informasi', gender: Gender.male),
        Student(nama: 'Santi', nim: '12181003', jurusan: 'Teknik Komputer', gender: Gender.female),
      ]);
      await _repository.saveStudents(_students);
    } else {
      _students.addAll(loaded);
    }
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _saveStudents() => _repository.saveStudents(_students);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final Student? newStudent = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BiodataForm(
                    existingNims: _students.map((e) => e.nim).toSet(),
                  ),
                ),
              );
              if (newStudent != null) {
                setState(() => _students.add(newStudent));
                await _saveStudents();
              }
            },
          )
        ],
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value.trim()),
              decoration: InputDecoration(
                hintText: 'Cari berdasarkan NIM...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              ),
            ),
          ),
        ),
      ),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final List<Student> visibleStudents = _searchQuery.isEmpty
            ? _students
            : _students.where((s) => s.nim.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

        if (visibleStudents.isEmpty) {
          return const Center(child: Text('Tidak ada data'));
        }

        return ListView.separated(
          itemCount: visibleStudents.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final student = visibleStudents[index];
            return Mahasiswa(
              student: student,
              onEdit: () async {
                final int originalIndex = _students.indexWhere((e) => e.nim == student.nim);
                if (originalIndex < 0) return;
                final Student? updated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BiodataForm(
                      initial: student,
                      existingNims: _students
                          .where((e) => e.nim != student.nim)
                          .map((e) => e.nim)
                          .toSet(),
                    ),
                  ),
                );
                if (updated != null) {
                  setState(() => _students[originalIndex] = updated);
                  await _saveStudents();
                }
              },
              onDelete: () => _deleteStudent(student),
            );
          },
        );
      })
    );
  }

  void _deleteStudent(Student student) {
    final int index = _students.indexWhere((e) => e.nim == student.nim);
    if (index < 0) return;
    final Student removed = _students.removeAt(index);
    setState(() {});
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Text('Dihapus: ${removed.nama} (${removed.nim})'),
        action: SnackBarAction(
          label: 'URUNGKAN',
          onPressed: () {
            setState(() => _students.insert(index, removed));
            _saveStudents();
          },
        ),
      ),
    );
    _saveStudents();
  }
}

class Mahasiswa extends StatelessWidget{
  final Student student;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const Mahasiswa({required this.student, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          leading: CircleAvatar(child: Text(_initials(student.nama))),
          title: Text(student.nama),
          subtitle: Text('${student.nim} • ${student.jurusan} • ${student.gender.label}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
              IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
            FormDetail(student: student)));
      },
    );
  }

  String _initials(String fullName) {
    if (fullName.trim().isEmpty) return '?';
    final parts = fullName.trim().split(RegExp(r"\s+"));
    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}