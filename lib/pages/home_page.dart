import 'package:flutter/material.dart';

import '../data/image_urls.dart';
import '../widgets/music_bottom_nav.dart';

/// Halaman Beranda (Home) aplikasi musik dengan tema gelap.
/// Halaman ini berdiri sendiri dan hanya menampilkan tampilan visual statis.
class HomePage extends StatelessWidget {
  final ValueChanged<int>? onNavTap;

  const HomePage({super.key, this.onNavTap});

  // Daftar kategori suasana musik
  static const List<String> _moodCategories = [
    'Senang',
    'Bersantai',
    'Tidur',
    'Sedih',
    'Romansa',
  ];

  // Data contoh lagu pada bagian Pilihan cepat (halaman 1 & halaman 2)
  static const List<List<_SongItemData>> _quickPickColumns = [
    [
      _SongItemData(
        title: 'Great Expectation',
        subtitle: 'SIENNA SPIRO • 72 jt pemutaran',
        imageUrl: ImageUrls.album1,
      ),
      _SongItemData(
        title: 'Kepada Noor',
        subtitle: 'Panji Sakti • 15 jt pemutaran',
        imageUrl: ImageUrls.album2,
      ),
      _SongItemData(
        title: 'Angin Pujaan Hujan',
        subtitle: 'Payung Teduh • 16 jt pemutaran',
        imageUrl: ImageUrls.album3,
      ),
      _SongItemData(
        title: 'Dunia Yang Nanti',
        subtitle: 'Raim Laode • 130 jt pemutaran',
        imageUrl: ImageUrls.album4,
      ),
    ],
    [
      _SongItemData(
        title: 'Kenangan Manis',
        subtitle: 'Pamungkas • 98 jt pemutaran',
        imageUrl: ImageUrls.album5,
      ),
      _SongItemData(
        title: 'Resah Jadi Luka',
        subtitle: 'Daun Jatuh • 42 jt pemutaran',
        imageUrl: ImageUrls.album6,
      ),
      _SongItemData(
        title: 'Bertaut',
        subtitle: 'Nadin Amizah • 85 jt pemutaran',
        imageUrl: ImageUrls.album7,
      ),
      _SongItemData(
        title: 'Komang',
        subtitle: 'Raim Laode • 210 jt pemutaran',
        imageUrl: ImageUrls.album8,
      ),
    ],
  ];

  // Data contoh item grid pada bagian Pintasan cepat
  static const List<_ShortcutItemData> _shortcuts = [
    _ShortcutItemData(
      title: 'KOPLO SKUY',
      imageUrl: ImageUrls.playlist1,
      isPinned: true,
      showArrow: true,
    ),
    _ShortcutItemData(
      title: 'Angin Pujaan Hujan',
      imageUrl: ImageUrls.playlist2,
    ),
    _ShortcutItemData(
      title: 'BRAVY YEAR MIX',
      imageUrl: ImageUrls.playlist3,
      showProgressBar: true,
    ),
    _ShortcutItemData(
      title: 'Santai Sore',
      imageUrl: ImageUrls.playlist4,
    ),
    _ShortcutItemData(
      title: 'Indie Indonesia',
      imageUrl: ImageUrls.playlist5,
    ),
    _ShortcutItemData(
      title: 'Lagu Favorit',
      imageUrl: ImageUrls.playlist6,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Lebar satu kolom Pilihan cepat agar kolom kedua sedikit terlihat di tepi kanan
    final double quickPickColumnWidth =
        (MediaQuery.of(context).size.width * 0.85).clamp(250.0, 380.0);

    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      body: Container(
        // Gradien gelap tipis di bagian atas agar menyerupai tampilan referensi
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.2, 0.35),
            colors: [
              Color(0xFF101D20),
              Color(0xFF030303),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // Konten utama yang dapat digulir ke bawah
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 12),
                      _buildMoodChips(),
                      const SizedBox(height: 24),
                      _buildQuickPicksHeader(),
                      const SizedBox(height: 12),
                      _buildQuickPicksList(quickPickColumnWidth),
                      const SizedBox(height: 28),
                      _buildShortcutsHeader(),
                      const SizedBox(height: 14),
                      _buildShortcutsGrid(),
                    ],
                  ),
                ),
              ),
              // Mini Player di atas Bottom Navigation
              _buildMiniPlayer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MusicBottomNav(
        currentIndex: 0,
        onTap: onNavTap,
      ),
    );
  }

  /// Bagian Header: logo aplikasi, ikon notifikasi dengan badge, dan foto profil
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              ImageUrls.logo,
              width: 28,
              height: 28,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF0000),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 18,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Music',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          // Ikon notifikasi dengan indikator angka 1
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 26,
              ),
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF0000),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 18),
          // Foto profil pengguna
          _buildCircleAvatar(ImageUrls.profile, size: 28),
        ],
      ),
    );
  }

  /// Deretan chip kategori suasana musik yang dapat digeser secara horizontal
  Widget _buildMoodChips() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _moodCategories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0x1FFFFFFF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0x1AFFFFFF)),
            ),
            child: Text(
              _moodCategories[index],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }

  /// Judul bagian Pilihan cepat beserta tombol "Putar semua"
  Widget _buildQuickPicksHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Pilihan cepat',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white38),
            ),
            child: const Text(
              'Putar semua',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Daftar lagu Pilihan cepat dalam bentuk kolom yang dapat digeser ke samping
  Widget _buildQuickPicksList(double columnWidth) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < _quickPickColumns.length; i++) ...[
            if (i > 0) const SizedBox(width: 16),
            SizedBox(
              width: columnWidth,
              child: Column(
                children: _quickPickColumns[i]
                    .map((song) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildSongRow(song),
                        ))
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Satu baris item lagu: cover album, judul, penyanyi, dan ikon menu tiga titik
  Widget _buildSongRow(_SongItemData song) {
    return Row(
      children: [
        _buildRoundedImage(song.imageUrl, size: 54, radius: 4),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                song.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                song.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const Icon(
          Icons.more_vert,
          color: Colors.white70,
          size: 20,
        ),
      ],
    );
  }

  /// Judul bagian Pintasan cepat dengan foto profil dan label akun
  Widget _buildShortcutsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildCircleAvatar(ImageUrls.profile, size: 32),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TRCY.',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                'Pintasan cepat',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Grid 3 kolom untuk menampilkan kartu Pintasan cepat
  Widget _buildShortcutsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _shortcuts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) {
          return _buildShortcutCard(_shortcuts[index]);
        },
      ),
    );
  }

  /// Satu kartu Pintasan cepat dengan gambar, overlay gelap, dan judul
  Widget _buildShortcutCard(_ShortcutItemData item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            item.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFF222222),
                child: const Center(
                  child: Icon(
                    Icons.music_note,
                    color: Colors.white38,
                    size: 32,
                  ),
                ),
              );
            },
          ),
          // Gradien gelap di bawah agar teks judul tetap jelas terbaca
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color(0xD9000000),
                ],
                stops: [0.45, 1.0],
              ),
            ),
          ),
          if (item.isPinned)
            const Positioned(
              top: 6,
              right: 6,
              child: Icon(
                Icons.push_pin,
                color: Colors.white,
                size: 14,
              ),
            ),
          Positioned(
            left: 6,
            right: 6,
            bottom: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.showProgressBar)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: SizedBox(
                      height: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(color: const Color(0xFFFF0000)),
                          ),
                          Expanded(
                            flex: 8,
                            child: Container(color: Colors.white24),
                          ),
                        ],
                      ),
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (item.showArrow)
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 16,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Mini Player statis di atas Bottom Navigation
  Widget _buildMiniPlayer() {
    return Container(
      color: const Color(0xFF212121),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                _buildRoundedImage(
                  ImageUrls.miniPlayerCover,
                  size: 44,
                  radius: 4,
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
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Pamungkas',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.cast,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 28,
                ),
              ],
            ),
          ),
          // Garis progres tipis di bagian bawah Mini Player
          SizedBox(
            height: 2,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(color: Colors.white70),
                ),
                Expanded(
                  flex: 7,
                  child: Container(color: Colors.white24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper untuk menampilkan gambar bulat (avatar/profil) dengan placeholder
  Widget _buildCircleAvatar(String url, {required double size}) {
    return ClipOval(
      child: Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: const Color(0xFF2B2B2B),
            child: Icon(
              Icons.person,
              color: Colors.white60,
              size: size * 0.6,
            ),
          );
        },
      ),
    );
  }

  /// Helper untuk menampilkan cover album sudut membulat dengan placeholder
  Widget _buildRoundedImage(
    String url, {
    required double size,
    required double radius,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: const Color(0xFF262626),
            child: Icon(
              Icons.music_note,
              color: Colors.white54,
              size: size * 0.48,
            ),
          );
        },
      ),
    );
  }
}

/// Model sederhana untuk item lagu pada Pilihan cepat
class _SongItemData {
  final String title;
  final String subtitle;
  final String imageUrl;

  const _SongItemData({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

/// Model sederhana untuk kartu Pintasan cepat
class _ShortcutItemData {
  final String title;
  final String imageUrl;
  final bool isPinned;
  final bool showArrow;
  final bool showProgressBar;

  const _ShortcutItemData({
    required this.title,
    required this.imageUrl,
    this.isPinned = false,
    this.showArrow = false,
    this.showProgressBar = false,
  });
}
