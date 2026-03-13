import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/dosen_model.dart';
import '../../data/repositories/dosen_repository.dart';

final dosenRepositoryProvider = Provider((ref) => DosenRepository());

final dosenNotifierProvider =
    StateNotifierProvider<DosenNotifier, AsyncValue<List<DosenModel>>>((ref) {
  final repository = ref.watch(dosenRepositoryProvider);
  return DosenNotifier(repository);
});

class DosenNotifier extends StateNotifier<AsyncValue<List<DosenModel>>> {
  final DosenRepository _repository;

  DosenNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadDosenList();
  }

  Future<void> loadDosenList() async {
    state = const AsyncValue.loading();
    try {
      final dosenList = await _repository.getDosenList();
      state = AsyncValue.data(dosenList);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    await loadDosenList();
  }
}
