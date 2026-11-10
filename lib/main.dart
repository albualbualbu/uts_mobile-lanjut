import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/sample_page.dart';
import 'widgets/music_bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

/// Root aplikasi musik dengan tema gelap.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: ThemeData.dark(),
      home: const MainPage(),
    );
  }
}

/// Pengatur navigasi utama untuk berpindah antar menu Bottom Navigation.
/// Saat ini menghubungkan halaman Beranda dan Sampel, sedangkan menu lainnya
/// menggunakan tampilan sementara sampai digabungkan dengan anggota kelompok lain.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Ganti placeholder index 2, 3, 4 dengan halaman dari anggota kelompok saat merge.
    switch (_currentIndex) {
      case 0:
        return HomePage(onNavTap: _onNavTap);
      case 1:
        return SamplePage(onNavTap: _onNavTap);
      case 2:
        return _PlaceholderTabPage(
          title: 'Telusuri',
          currentIndex: 2,
          onNavTap: _onNavTap,
        );
      case 3:
        return _PlaceholderTabPage(
          title: 'Koleksi',
          currentIndex: 3,
          onNavTap: _onNavTap,
        );
      case 4:
        return _PlaceholderTabPage(
          title: 'Upgrade',
          currentIndex: 4,
          onNavTap: _onNavTap,
        );
      default:
        return HomePage(onNavTap: _onNavTap);
    }
  }
}

/// Halaman sementara untuk menu yang dikerjakan oleh anggota kelompok lain.
class _PlaceholderTabPage extends StatelessWidget {
  final String title;
  final int currentIndex;
  final ValueChanged<int> onNavTap;

  const _PlaceholderTabPage({
    required this.title,
    required this.currentIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      body: Center(
        child: Text(
          'Halaman $title\n(Menunggu penggabungan)',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      ),
      bottomNavigationBar: MusicBottomNav(
        currentIndex: currentIndex,
        onTap: onNavTap,
      ),
    );
  }
}
