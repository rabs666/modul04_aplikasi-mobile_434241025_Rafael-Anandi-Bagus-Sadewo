import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/dashboard_model.dart';

// Notifier untuk mengelola state dashboard
class DashboardNotifier extends StateNotifier<AsyncValue<DashboardData>> {
  DashboardNotifier() : super(const AsyncValue.loading()) {
    _fetchData();
  }

  Future<void> _fetchData() async {
    state = const AsyncValue.loading();
    try {
      // Simulasi fetch data
      await Future.delayed(const Duration(milliseconds: 800));
      
      final stats = [
        DashboardStats(
          title: "Total Mahasiswa", 
          value: "1,200", 
          subtitle: "Total Mahasiswa terdaftar", 
          percentage: 8.5, 
          isIncrease: true
        ),
        DashboardStats(
          title: "Mahasiswa Aktif", 
          value: "550", 
          subtitle: "Mahasiswa sedang kuliah", 
          percentage: 5.2, 
          isIncrease: true
        ),
        DashboardStats(
          title: "Dosen", 
          value: "650", 
          subtitle: "Dosen aktif mengajar", 
          percentage: 2.1, 
          isIncrease: true
        ),
        DashboardStats(
          title: "Profile", 
          value: "", 
          subtitle: "Informasi Akun", 
          percentage: 0, 
          isIncrease: true
        ),
      ];

      final data = DashboardData(
        userName: "Admin D4TI",
        stats: stats,
        lastUpdate: DateTime.now(),
      );
      
      state = AsyncValue.data(data);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    await _fetchData();
  }
}

// Provider untuk DashboardNotifier
final dashboardNotifierProvider =
    StateNotifierProvider<DashboardNotifier, AsyncValue<DashboardData>>((ref) {
  return DashboardNotifier();
});

// Provider untuk index yang dipilih
final selectedStatIndexProvider = StateProvider<int>((ref) => -1);
