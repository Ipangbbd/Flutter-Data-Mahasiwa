import 'package:flutter/material.dart';
import 'package:flut/models/student.dart';

class BiodataForm extends StatefulWidget {
  final Student? initial;
  final Set<String> existingNims;

  BiodataForm({this.initial, this.existingNims = const {}});
  @override
  BiodataForm_State createState() => BiodataForm_State();
}

class BiodataForm_State extends State<BiodataForm> {
  final _formKey = GlobalKey<FormState>();
  final _nimController = TextEditingController();
  final _namaController = TextEditingController();
  final _jurusanController = TextEditingController();
  Gender _selectedGender = Gender.male;

  @override
  void initState() {
    super.initState();
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
    _nimController.dispose();
    _namaController.dispose();
    _jurusanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

  Widget _textboxNama(){
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Nama'),
      controller: _namaController,
      textInputAction: TextInputAction.next,
      validator: (value) => (value == null || value.trim().isEmpty) ? 'Nama wajib diisi' : null,
    );
  }

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

  Widget _textboxJurusan(){
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Jurusan'),
      controller: _jurusanController,
      textInputAction: TextInputAction.done,
      validator: (value) => (value == null || value.trim().isEmpty) ? 'Jurusan wajib diisi' : null,
    );
  }

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