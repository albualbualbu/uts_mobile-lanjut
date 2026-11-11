import 'package:flutter/material.dart';

/// Widget Bottom Navigation yang digunakan bersama pada halaman Beranda, Sampel,
/// dan halaman sementara lainnya agar susunan menu selalu konsisten.
class MusicBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final Color backgroundColor;

  const MusicBottomNav({
    super.key,
    required this.currentIndex,
    this.onTap,
    this.backgroundColor = const Color(0xFF181818),
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: backgroundColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      selectedFontSize: 11,
      unselectedFontSize: 11,
      currentIndex: currentIndex,
      onTap: onTap ?? (_) {},
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fast_forward_outlined),
          activeIcon: Icon(Icons.fast_forward),
          label: 'Sampel',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Telusuri',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border),
          activeIcon: Icon(Icons.bookmark),
          label: 'Koleksi',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_outline),
          activeIcon: Icon(Icons.play_circle),
          label: 'Upgrade',
        ),
      ],
    );
  }
}
