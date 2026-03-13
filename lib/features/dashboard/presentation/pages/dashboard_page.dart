import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../dosen/presentation/pages/dosen_page.dart';
import '../../../mahasiswa/presentation/pages/mahasiswa_page.dart';
import '../../../mahasiswa_aktif/presentation/pages/mahasiswa_aktif_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/dashboard_widgets.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);

  // Fungsi untuk mendapatkan icon berdasarkan judul stat sesuai foto 11a
  IconData _getIconForStat(String title) {
    switch (title) {
      case 'Total Mahasiswa':
        return Icons.school_rounded;
      case 'Mahasiswa Aktif':
        return Icons.person_rounded;
      case 'Dosen':
        return Icons.group_rounded;
      case 'Profile':
        return Icons.insert_chart_outlined_rounded;
      default:
        return Icons.analytics_outlined;
    }
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutQuart;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final selectedIndex = ref.watch(selectedStatIndexProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: dashboardState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data: ${error.toString()}',
          onRetry: () => ref.invalidate(dashboardNotifierProvider),
        ),
        data: (dashboardData) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(dashboardNotifierProvider),
            child: CustomScrollView(
              slivers: [
                // Header Gradient Biru sesuai Foto 11a
                SliverToBoxAdapter(
                  child: DashboardHeader(userName: dashboardData.userName),
                ),

                // Bagian Statistik
                SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Statistik',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1C1E),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () => ref.invalidate(dashboardNotifierProvider),
                              icon: const Icon(Icons.refresh_rounded, size: 16),
                              label: const Text('Refresh', style: TextStyle(fontSize: 12)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.95, // Disesuaikan agar tidak overflow
                          ),
                          itemCount: dashboardData.stats.length,
                          itemBuilder: (context, index) {
                            final stat = dashboardData.stats[index];
                            return ModernStatCard(
                              stats: stat,
                              icon: _getIconForStat(stat.title),
                              gradientColors: AppConstants.dashboardGradients[
                                  index % AppConstants.dashboardGradients.length],
                              isSelected: selectedIndex == index,
                              onTap: () {
                                ref.read(selectedStatIndexProvider.notifier).state = index;

                                Widget? targetPage;
                                switch (stat.title) {
                                  case 'Total Mahasiswa':
                                    targetPage = const MahasiswaPage();
                                    break;
                                  case 'Mahasiswa Aktif':
                                    targetPage = const MahasiswaAktifPage();
                                    break;
                                  case 'Dosen':
                                    targetPage = const DosenPage();
                                    break;
                                  case 'Profile':
                                    targetPage = const ProfilePage();
                                    break;
                                }

                                if (targetPage != null) {
                                  Navigator.push(context, _createRoute(targetPage));
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
              ],
            ),
          );
        },
      ),
    );
  }
}
