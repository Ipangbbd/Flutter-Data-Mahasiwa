// UI Material dan widget Flutter
import 'package:flutter/material.dart';
// Halaman detail mahasiswa
import 'package:flut/Detail_Biodata.dart';
// Halaman form tambah/edit mahasiswa
import 'package:flut/form_biodata.dart';
// Model Student untuk data
import 'package:flut/models/student.dart';
// Repository untuk penyimpanan lokal mahasiswa
import 'package:flut/repositories/student_repository.dart';
// Halaman sambutan (untuk navigasi kembali)
import 'package:flut/welcome_screen.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // Akses storage lokal
  final StudentRepository _repository = StudentRepository();
  // Sumber data mahasiswa yang ditampilkan
  final List<Student> _students = <Student>[];
  // Controller untuk input pencarian NIM
  final TextEditingController _searchController = TextEditingController();
  // Nilai kueri pencarian terkini
  String _searchQuery = '';
  // Menandai proses pemuatan awal data
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

  // Memuat mahasiswa dari storage; bila kosong akan seeding default
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

  // Menyimpan daftar mahasiswa saat ini ke storage
  Future<void> _saveStudents() => _repository.saveStudents(_students);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const WelcomeScreen()),
            );
          },
        ),
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
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _searchQuery = value.trim()),
                  decoration: const InputDecoration(
                    hintText: 'Cari berdasarkan NIM...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              _genderChips(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final List<Student> visibleStudents = _filterStudents();

        if (visibleStudents.isEmpty) {
          return const Center(child: Text('Tidak ada data'));
        }

        final int totalCount = _students.length;
        final int shownCount = visibleStudents.length;

        return ListView.separated(
          itemCount: shownCount + 1,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.people_alt),
                    title: Text('Total Mahasiswa: $totalCount'),
                    subtitle: shownCount != totalCount
                        ? Text('Ditampilkan: $shownCount')
                        : null,
                  ),
                ),
              );
            }
            final student = visibleStudents[index - 1];
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

  // Memfilter mahasiswa berdasarkan kueri NIM dan filter gender
  List<Student> _filterStudents() {
    final q = _searchQuery.toLowerCase();
    Iterable<Student> iter = _students;
    if (q.isNotEmpty) {
      iter = iter.where((s) => s.nim.toLowerCase().contains(q));
    }
    if (_selectedGenderFilter != null) {
      iter = iter.where((s) => s.gender == _selectedGenderFilter);
    }
    return iter.toList();
  }

  Gender? _selectedGenderFilter;
  // Komponen FilterChip untuk memilih filter gender
  Widget _genderChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          FilterChip(
            label: const Text('Semua'),
            selected: _selectedGenderFilter == null,
            onSelected: (_) => setState(() => _selectedGenderFilter = null),
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Laki-laki'),
            selected: _selectedGenderFilter == Gender.male,
            onSelected: (_) => setState(() => _selectedGenderFilter = Gender.male),
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Perempuan'),
            selected: _selectedGenderFilter == Gender.female,
            onSelected: (_) => setState(() => _selectedGenderFilter = Gender.female),
          ),
        ],
      ),
    );
  }

  // Menghapus mahasiswa dan memberikan opsi undo melalui SnackBar
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

// Widget item untuk menampilkan satu mahasiswa pada daftar
class Mahasiswa extends StatelessWidget{
  // Data mahasiswa yang ditampilkan
  final Student student;
  // Aksi untuk mengedit mahasiswa
  final VoidCallback onEdit;
  // Aksi untuk menghapus mahasiswa
  final VoidCallback onDelete;

  const Mahasiswa({required this.student, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          leading: Hero(
            tag: 'avatar_${student.nim}',
            child: CircleAvatar(child: Text(_initials(student.nama))),
          ),
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

  // Menghasilkan inisial dari nama lengkap untuk avatar
  String _initials(String fullName) {
    if (fullName.trim().isEmpty) return '?';
    final parts = fullName.trim().split(RegExp(r"\s+"));
    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}