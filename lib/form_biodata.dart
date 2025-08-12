// Halaman form untuk menambah/mengedit data mahasiswa
import 'package:flutter/material.dart';
// Model Student yang akan dibuat/diedit dari form
import 'package:flut/models/student.dart';

class BiodataForm extends StatefulWidget {
  // Data awal untuk mode edit (null jika mode tambah)
  final Student? initial;
  // Kumpulan NIM yang sudah ada, untuk validasi unik
  final Set<String> existingNims;

  BiodataForm({this.initial, this.existingNims = const {}});
  @override
  BiodataForm_State createState() => BiodataForm_State();
}

class BiodataForm_State extends State<BiodataForm> {
  // Kunci global untuk memvalidasi form
  final _formKey = GlobalKey<FormState>();
  // Controller input teks
  final _nimController = TextEditingController();
  final _namaController = TextEditingController();
  final _jurusanController = TextEditingController();
  // Nilai gender yang dipilih
  Gender _selectedGender = Gender.male;

  @override
  void initState() {
    super.initState();
    // Saat mode edit, muat nilai awal ke controller dan gender
    final initial = widget.initial;
    if (initial != null) {
      _namaController.text = initial.nama;
      _nimController.text = initial.nim;
      _jurusanController.text = initial.jurusan;
      _selectedGender = initial.gender;
    }
  }

  @override
  void dispose() {
    // Bebaskan resource controller saat widget dihancurkan
    _nimController.dispose();
    _namaController.dispose();
    _jurusanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Judul dinamis berdasarkan mode tambah atau edit
        title: Text(widget.initial == null ? 'Tambah Mahasiswa' : 'Edit Mahasiswa'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _textboxNama(),
              const SizedBox(height: 12),
              _textboxNim(),
              const SizedBox(height: 12),
              _textboxJurusan(),
              const SizedBox(height: 12),
              _genderSelector(),
              const SizedBox(height: 20),
              _tombolSimpan()
            ],
          ),
        ),
      ),
    );
  }

  // Input untuk Nama mahasiswa (wajib diisi)
  Widget _textboxNama(){
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Nama'),
      controller: _namaController,
      textInputAction: TextInputAction.next,
      validator: (value) => (value == null || value.trim().isEmpty) ? 'Nama wajib diisi' : null,
    );
  }

  // Input untuk NIM (unik dan wajib diisi)
  Widget _textboxNim(){
    return TextFormField(
      decoration: const InputDecoration(labelText: 'NIM'),
      controller: _nimController,
      textInputAction: TextInputAction.next,
      validator: (value) {
        final v = value?.trim() ?? '';
        if (v.isEmpty) return 'NIM wajib diisi';
        if (widget.existingNims.contains(v)) return 'NIM sudah digunakan';
        return null;
      },
    );
  }

  // Input untuk Jurusan (wajib diisi)
  Widget _textboxJurusan(){
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Jurusan'),
      controller: _jurusanController,
      textInputAction: TextInputAction.done,
      validator: (value) => (value == null || value.trim().isEmpty) ? 'Jurusan wajib diisi' : null,
    );
  }

  // Pilihan gender menggunakan RadioListTile
  Widget _genderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Gender'),
        Row(
          children: [
            Expanded(
              child: RadioListTile<Gender>(
                value: Gender.male,
                groupValue: _selectedGender,
                title: const Text('Laki-laki'),
                onChanged: (v) => setState(() => _selectedGender = v ?? Gender.male),
              ),
            ),
            Expanded(
              child: RadioListTile<Gender>(
                value: Gender.female,
                groupValue: _selectedGender,
                title: const Text('Perempuan'),
                onChanged: (v) => setState(() => _selectedGender = v ?? Gender.female),
              ),
            ),
          ],
        )
      ],
    );
  }

  // Tombol untuk menyimpan/perbarui data dan mengembalikan Student ke halaman sebelumnya
  Widget _tombolSimpan(){
    return ElevatedButton(
      child: Text(widget.initial == null ? 'Simpan' : 'Perbarui'),
      onPressed: (){
        if (!(_formKey.currentState?.validate() ?? false)) return;
        final student = Student(
          nama: _namaController.text.trim(),
          nim: _nimController.text.trim(),
          jurusan: _jurusanController.text.trim(),
          gender: _selectedGender,
        );
        Navigator.pop(context, student);
      },
    );
  }
}