import 'package:flutter/material.dart';

import '../data/image_urls.dart';

// LOKASI: Helper Transisi Halaman Modal Slide-Up (Untuk Halaman Akun)
Route<void> buildSlideUpRoute(Widget page) {
  return PageRouteBuilder<void>(
    transitionDuration: const Duration(milliseconds: 240),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final Animation<Offset> slide = Tween<Offset>(
        begin: const Offset(0, 0.08),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      );
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: SlideTransition(position: slide, child: child),
      );
    },
  );
}

// LOKASI: Helper Umpan Balik SnackBar Gelap Saat Tombol Ditekan (showMusicFeedback)
void showMusicFeedback(BuildContext context, String message) {
  final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(context);
  if (messenger == null) return;

  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 13.5),
        ),
        backgroundColor: const Color(0xFF282828),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
}

// LOKASI: Helper Bottom Sheet Menu Opsi Tiga Titik Lagu/Artis (showTrackOptionsSheet)
void showTrackOptionsSheet(
  BuildContext context, {
  required String title,
  required String subtitle,
}) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: const Color(0xFF1C1C1C),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (sheetContext) {
      return SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // LOKASI: Garis Handle Atas Bottom Sheet
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // LOKASI: Judul & Subjudul Lagu pada Menu Tiga Titik
              ListTile(
                title: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white60),
                ),
              ),
              const Divider(color: Color(0xFF2E2E2E), height: 1),
              // LOKASI: Opsi Menu - Putar Berikutnya
              ListTile(
                leading: const Icon(Icons.playlist_play, color: Colors.white),
                title: const Text(
                  'Putar berikutnya',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  showMusicFeedback(context, 'Ditambahkan ke antrean: $title');
                },
              ),
              // LOKASI: Opsi Menu - Simpan ke Playlist
              ListTile(
                leading: const Icon(Icons.playlist_add, color: Colors.white),
                title: const Text(
                  'Simpan ke playlist',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  showMusicFeedback(context, 'Disimpan ke koleksi: $title');
                },
              ),
              // LOKASI: Opsi Menu - Bagikan
              ListTile(
                leading: const Icon(Icons.share_outlined, color: Colors.white),
                title: const Text(
                  'Bagikan',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  showMusicFeedback(context, 'Membagikan "$title"');
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

// LOKASI: Widget Logo YouTube Music + Teks (YouTubeMusicLogo)
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
        // LOKASI: Gambar Logo Bulat Aplikasi & Placeholder Error
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
        // LOKASI: Teks Nama Brand Aplikasi ("Music" / "YouTube Music")
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

// LOKASI: Widget Avatar Foto Profil Lingkaran (UserProfileAvatar)
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

// LOKASI: Widget Mini Player Bawah Aplikasi (MusicMiniPlayer)
class MusicMiniPlayer extends StatelessWidget {
  final String title;
  final String artist;
  final String coverUrl;
  final bool isPlaying;
  final VoidCallback? onPlayPauseTap;
  final VoidCallback? onCastTap;
  final VoidCallback? onTap;

  const MusicMiniPlayer({
    super.key,
    this.title = 'Kenangan Manis',
    this.artist = 'Pamungkas',
    this.coverUrl = ImageUrls.miniPlayerCover,
    this.isPlaying = false,
    this.onPlayPauseTap,
    this.onCastTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF212121),
      child: InkWell(
        onTap: onTap ??
            () => showMusicFeedback(
                  context,
                  'Sedang diputar: $title - $artist',
                ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  // LOKASI: Mini Player - Cover Album Lagu
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      width: 44,
                      height: 44,
                      color: const Color(0xFF2F2F2F),
                      child: Image.network(
                        coverUrl,
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
                  // LOKASI: Mini Player - Judul Lagu & Nama Penyanyi
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          artist,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFFB3B3B3),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // LOKASI: Mini Player - Tombol Cast Perangkat
                  IconButton(
                    onPressed: onCastTap ??
                        () => showMusicFeedback(
                              context,
                              'Mencari perangkat Cast...',
                            ),
                    icon: const Icon(
                      Icons.cast,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  // LOKASI: Mini Player - Tombol Play / Pause
                  IconButton(
                    onPressed: onPlayPauseTap ??
                        () => showMusicFeedback(
                              context,
                              isPlaying ? 'Pemutaran dijeda' : 'Memutar $title',
                            ),
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            // LOKASI: Mini Player - Garis Progres Tipis Bawah
            SizedBox(
              height: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: isPlaying ? 5 : 3,
                    child: Container(color: Colors.white70),
                  ),
                  Expanded(
                    flex: isPlaying ? 5 : 7,
                    child: Container(color: Colors.white24),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// LOKASI: Widget Bottom Navigation Bar Utama (MusicBottomNavBar)
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

  // LOKASI: Daftar 5 Menu Bottom Navigation (Beranda, Sampel, Telusuri, Koleksi, Upgrade)
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      color: backgroundColor,
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: List.generate(_navItems.length, (index) {
                final _NavItemData item = _navItems[index];
                final bool isActive = activeIndex == index;
                final Color itemColor =
                    isActive ? Colors.white : const Color(0xFFC4C4C4);

                // LOKASI: Item Tombol Menu Bottom Navigation (Ikon & Label)
                return Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: onTap == null ? null : () => onTap!(index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
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
      ),
    );
  }
}

// LOKASI: Model Data Item Menu Bottom Navigation (_NavItemData)
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
