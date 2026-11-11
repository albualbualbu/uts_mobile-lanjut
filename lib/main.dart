
import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/sample_page.dart';
import 'pages/search_page.dart';
import 'pages/collection_page.dart';
import 'pages/upgrade_page.dart';

void main() {
  runApp(const MyApp());
}

/// Root aplikasi musik.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const MainPage(),
    );
  }
}

/// Pengelola navigasi utama untuk lima halaman aplikasi.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    if (index < 0 || index > 4) return;

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentIndex,
      children: [
        HomePage(onNavTap: _onNavTap),
        SamplePage(onNavTap: _onNavTap),
        SearchPage(onTabSelected: _onNavTap),
        CollectionPage(onTabSelected: _onNavTap),
        UpgradePage(onNavTap: _onNavTap),
      ],
    );
  }
}
