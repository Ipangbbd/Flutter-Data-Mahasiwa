import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  TeamPage({super.key});

  final List<String> _members = const [
    'Muhammad Ali Irfansyah',
    'Muhammad Ibnu Riyansyah',
    'Muhamad Ragil Jaushaq Fauzi',
    'Muhammad Rovi',
    'Prima Asadafa',
    'Rakha Maide Ghafitri',
    'Riza Alvaro',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Tim')),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _members.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final name = _members[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text(_initials(name))),
              title: Text(name),
              subtitle: const Text('Anggota Tim'),
            ),
          );
        },
      ),
    );
  }

  String _initials(String fullName) {
    if (fullName.trim().isEmpty) return '?';
    final parts = fullName.trim().split(RegExp(r"\s+"));
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}


