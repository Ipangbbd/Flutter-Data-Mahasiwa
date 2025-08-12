import 'package:flutter/material.dart';
import 'package:flut/models/student.dart';

class FormDetail extends StatefulWidget {
  final Student student;

  FormDetail({required this.student});

  @override
  _FormDetailState createState()=> _FormDetailState();
}

class _FormDetailState extends State<FormDetail>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Mahasiswa'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(radius: 28, child: Text(_initials(widget.student.nama))),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.student.nama, style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 4),
                          Text(widget.student.nim, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(label: Text('Jurusan: ${widget.student.jurusan}')),
                    Chip(label: Text('Gender: ${widget.student.gender.label}')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      children: [
        SizedBox(width: 90, child: Text('$label')),
        const Text(' : '),
        Expanded(child: Text(value)),
      ],
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