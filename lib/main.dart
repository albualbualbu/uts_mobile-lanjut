import 'package:flutter/material.dart';
import 'pages/collection_page.dart';
import 'pages/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Musik',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const MainNavigationPage(),
    );
  }
}

/// Wrapper navigasi utama sementara untuk berpindah antara Telusuri dan Koleksi.
/// Saat merge dengan halaman anggota lain (Beranda, Sampel, Upgrade),
/// cukup tambahkan halaman tersebut ke daftar tab di sini.
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  // 2 = Telusuri, 3 = Koleksi.
  int _currentTabIndex = 2;

  void _handleTabSelected(int tabIndex) {
    if (tabIndex != 2 && tabIndex != 3) {
      return;
    }
    if (_currentTabIndex == tabIndex) {
      return;
    }
    setState(() {
      _currentTabIndex = tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final int stackIndex = _currentTabIndex == 3 ? 1 : 0;

    return IndexedStack(
      index: stackIndex,
      children: [
        SearchPage(onTabSelected: _handleTabSelected),
        CollectionPage(onTabSelected: _handleTabSelected),
      ],
    );
  }
}
