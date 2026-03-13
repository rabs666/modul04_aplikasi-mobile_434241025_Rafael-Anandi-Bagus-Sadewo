import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../providers/dosen_provider.dart';
import '../widgets/dosen_widget.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenState = ref.watch(dosenNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Dosen'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.invalidate(dosenNotifierProvider);
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: dosenState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data dosen: ${error.toString()}',
          onRetry: () {
            ref.read(dosenNotifierProvider.notifier).refresh();
          },
        ),
        data: (dosenList) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(dosenNotifierProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: dosenList.length,
              itemBuilder: (context, index) {
                final colors = [
                  [const Color(0xFFF667EE), const Color(0xFF764BA2)],
                  [const Color(0xFFF093FB), const Color(0xFFF5576C)],
                  [const Color(0xFF4FACFE), const Color(0xFF00F2FE)],
                ];
                return ModernDosenCard(
                  dosen: dosenList[index],
                  gradientColors: colors[index % colors.length],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
