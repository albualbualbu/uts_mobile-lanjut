import 'package:flutter/material.dart';

import '../data/image_urls.dart';

/// Logo ikon dan teks branding YouTube Music dengan fallback jika gambar gagal dimuat.
class YouTubeMusicLogo extends StatelessWidget {
  final double iconSize;
  final String label;
  final double fontSize;
  final double spacing;

  const YouTubeMusicLogo({
    super.key,
    this.iconSize = 28,
    this.label = 'Music',
    this.fontSize = 22,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipOval(
          child: Image.network(
            ImageUrls.logo,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: iconSize,
                height: iconSize,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF0000),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: iconSize * 0.64,
                ),
              );
            },
          ),
        ),
        SizedBox(width: spacing),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ],
    );
  }
}

/// Avatar profil pengguna berbentuk lingkaran dengan fallback ikon bawaan.
class UserProfileAvatar extends StatelessWidget {
  final double size;

  const UserProfileAvatar({
    super.key,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color: const Color(0xFF2B2B2B),
        child: Image.network(
          ImageUrls.profile,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                Icons.person,
                color: Colors.white70,
                size: size * 0.6,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Mini-player statis di bagian bawah halaman yang menampilkan lagu sedang diputar.
class MusicMiniPlayer extends StatelessWidget {
  const MusicMiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF212121),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: 44,
                    height: 44,
                    color: const Color(0xFF2F2F2F),
                    child: Image.network(
                      ImageUrls.miniPlayerCover,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.music_note,
                            color: Colors.white54,
                            size: 24,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kenangan Manis',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Pamungkas',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFFB3B3B3),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.cast,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: const Color(0xFF2E2E2E),
          ),
        ],
      ),
    );
  }
}

/// Bottom navigation bar yang konsisten dengan tema gelap YouTube Music.
class MusicBottomNavBar extends StatelessWidget {
  final int? activeIndex;
  final ValueChanged<int>? onTap;
  final Color backgroundColor;

  const MusicBottomNavBar({
    super.key,
    this.activeIndex,
    this.onTap,
    this.backgroundColor = const Color(0xFF141414),
  });

  static const List<_NavItemData> _navItems = [
    _NavItemData(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Beranda',
    ),
    _NavItemData(
      icon: Icons.fast_forward_outlined,
      activeIcon: Icons.fast_forward,
      label: 'Sampel',
    ),
    _NavItemData(
      icon: Icons.search,
      activeIcon: Icons.search,
      label: 'Telusuri',
    ),
    _NavItemData(
      icon: Icons.bookmark_border,
      activeIcon: Icons.bookmark,
      label: 'Koleksi',
    ),
    _NavItemData(
      icon: Icons.play_circle_outline,
      activeIcon: Icons.play_circle,
      label: 'Upgrade',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: List.generate(_navItems.length, (index) {
              final _NavItemData item = _navItems[index];
              final bool isActive = activeIndex == index;
              final Color itemColor =
                  isActive ? Colors.white : const Color(0xFFC4C4C4);

              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onTap == null ? null : () => onTap!(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isActive ? item.activeIcon : item.icon,
                          color: itemColor,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: itemColor,
                            fontSize: 11,
                            fontWeight:
                                isActive ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

/// Model sederhana untuk item menu pada bottom navigation.
class _NavItemData {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItemData({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
