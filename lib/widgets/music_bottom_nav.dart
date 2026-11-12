import 'package:flutter/material.dart';

import 'music_common_widgets.dart';

// LOKASI: Widget Wrapper Bottom Navigation Lama (Mengarah ke MusicBottomNavBar)
class MusicBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final Color backgroundColor;

  const MusicBottomNav({
    super.key,
    required this.currentIndex,
    this.onTap,
    this.backgroundColor = const Color(0xFF141414),
  });

  @override
  Widget build(BuildContext context) {
    // LOKASI: Pemanggilan Widget Bottom Navigation Utama
    return MusicBottomNavBar(
      activeIndex: currentIndex,
      onTap: onTap,
      backgroundColor: backgroundColor,
    );
  }
}
