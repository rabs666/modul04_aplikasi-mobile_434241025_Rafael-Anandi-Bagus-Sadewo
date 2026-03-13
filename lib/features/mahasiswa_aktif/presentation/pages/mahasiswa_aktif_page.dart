import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/common_widgets.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mahasiswa Aktif')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.green[50],
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: Text('Mahasiswa Aktif ${index + 1}'),
              subtitle: const Text('Semester 4\nAktif Kuliah'),
            ),
          );
        },
      ),
    );
  }
}
