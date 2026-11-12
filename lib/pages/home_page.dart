import 'package:flutter/material.dart';

import '../data/image_urls.dart';
import '../widgets/music_bottom_nav.dart';
import '../widgets/music_common_widgets.dart';
import 'account_page.dart';

// LOKASI: Halaman Beranda / Home (HomePage)
class HomePage extends StatefulWidget {
  final ValueChanged<int>? onNavTap;
  final VoidCallback? onProfileTap;
  final ScrollController? scrollController;
  final bool showBottomBar;
  final void Function(String title, String artist, String coverUrl)? onSongTap;

  const HomePage({
    super.key,
    this.onNavTap,
    this.onProfileTap,
    this.scrollController,
    this.showBottomBar = true,
    this.onSongTap,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // LOKASI: Beranda - Data Mood Chips (Kategori Suasana Musik)
  static const List<String> _moodCategories = [
    'Senang',
    'Bersantai',
    'Tidur',
    'Sedih',
    'Romansa',
  ];

  // LOKASI: Beranda - Data Lagu Pilihan Cepat (Kolom 1 & Kolom 2)
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

  // LOKASI: Beranda - Data Grid Kartu Pintasan Cepat
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

  // LOKASI: Beranda - State Pilihan Mood & Badge Notifikasi
  int? _selectedMoodIndex;
  bool _hasUnreadNotification = true;

  // LOKASI: Beranda - Aksi Buka Halaman Akun dari Profil
  void _openAccountPage() {
    if (widget.onProfileTap != null) {
      widget.onProfileTap!();
      return;
    }
    Navigator.of(context).push(buildSlideUpRoute(const AccountPage()));
  }

  // LOKASI: Beranda - Aksi Putar Lagu ke Mini Player
  void _playTrack(String title, String artist, String imageUrl) {
    if (widget.onSongTap != null) {
      widget.onSongTap!(title, artist, imageUrl);
    } else {
      showMusicFeedback(context, 'Memutar: $title');
    }
  }

  @override
  Widget build(BuildContext context) {
    // LOKASI: Beranda - Lebar Kolom Pilihan Cepat Responsif
    final double quickPickColumnWidth =
        (MediaQuery.of(context).size.width * 0.85).clamp(250.0, 380.0);

    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      // LOKASI: Beranda - Background Gradien Gelap Bagian Atas
      body: Container(
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
        // LOKASI: Beranda - Daftar Scroll Utama Konten Beranda
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            controller: widget.scrollController,
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
      ),
      // LOKASI: Beranda - Bottom Bar Standalone (Mini Player + Bottom Navigation)
      bottomNavigationBar: widget.showBottomBar
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const MusicMiniPlayer(),
                MusicBottomNav(
                  currentIndex: 0,
                  onTap: widget.onNavTap,
                ),
              ],
            )
          : null,
    );
  }

  // LOKASI: Beranda - Header Atas (Logo Music, Ikon Notifikasi, Ikon Profil)
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 10, 8),
      child: Row(
        children: [
          // LOKASI: Beranda - Logo Aplikasi Header
          const YouTubeMusicLogo(
            iconSize: 28,
            label: 'Music',
            fontSize: 22,
            spacing: 8,
          ),
          const Spacer(),
          // LOKASI: Beranda - Tombol Ikon Notifikasi & Badge Angka 1
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              setState(() {
                _hasUnreadNotification = false;
              });
              showMusicFeedback(
                context,
                'Notifikasi: Rekomendasi musik baru untuk Anda',
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 26,
                  ),
                  if (_hasUnreadNotification)
                    Positioned(
                      right: -4,
                      top: -4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 1,
                        ),
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
            ),
          ),
          const SizedBox(width: 8),
          // LOKASI: Beranda - Tombol Foto Profil Header (Buka Halaman Akun)
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: _openAccountPage,
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: UserProfileAvatar(size: 28),
            ),
          ),
        ],
      ),
    );
  }

  // LOKASI: Beranda - Baris Chip Kategori Suasana Musik (Mood Chips)
  Widget _buildMoodChips() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _moodCategories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final bool isSelected = _selectedMoodIndex == index;
          return Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                setState(() {
                  _selectedMoodIndex = isSelected ? null : index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color:
                      isSelected ? Colors.white : const Color(0x1FFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? Colors.white
                        : const Color(0x1AFFFFFF),
                  ),
                ),
                child: Text(
                  _moodCategories[index],
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // LOKASI: Beranda - Header Bagian Pilihan Cepat & Tombol Putar Semua
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
          // LOKASI: Beranda - Tombol Putar Semua Pilihan Cepat
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              final _SongItemData firstSong = _quickPickColumns.first.first;
              _playTrack(
                firstSong.title,
                firstSong.subtitle.split(' • ').first,
                firstSong.imageUrl,
              );
            },
            child: Container(
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
          ),
        ],
      ),
    );
  }

  // LOKASI: Beranda - Daftar Kolom Horizontal Pilihan Cepat
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
                    .map(
                      (song) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _buildSongRow(song),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // LOKASI: Beranda - Item Baris Lagu Pilihan Cepat (Cover, Judul, Penyanyi, Menu Tiga Titik)
  Widget _buildSongRow(_SongItemData song) {
    final String artist = song.subtitle.split(' • ').first;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => _playTrack(song.title, artist, song.imageUrl),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            // LOKASI: Beranda - Cover Album Lagu Pilihan Cepat
            _buildRoundedImage(song.imageUrl, size: 54, radius: 4),
            const SizedBox(width: 12),
            // LOKASI: Beranda - Teks Judul & Penyanyi Lagu
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
            // LOKASI: Beranda - Tombol Menu Tiga Titik Item Lagu
            IconButton(
              onPressed: () => showTrackOptionsSheet(
                context,
                title: song.title,
                subtitle: song.subtitle,
              ),
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white70,
                size: 20,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
          ],
        ),
      ),
    );
  }

  // LOKASI: Beranda - Header Bagian Pintasan Cepat (Avatar, Label TRCY., Judul)
  Widget _buildShortcutsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: _openAccountPage,
        child: Row(
          children: const [
            UserProfileAvatar(size: 32),
            SizedBox(width: 12),
            Column(
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
      ),
    );
  }

  // LOKASI: Beranda - Grid 3 Kolom Pintasan Cepat
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

  // LOKASI: Beranda - Kartu Individual Grid Pintasan Cepat
  Widget _buildShortcutCard(_ShortcutItemData item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // LOKASI: Beranda - Gambar Cover Kartu Pintasan Cepat
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
          // LOKASI: Beranda - Gradien Overlay Gelap Kartu Pintasan Cepat
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
          // LOKASI: Beranda - Ikon Pin Pojok Kanan Atas Kartu Pintasan
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
          // LOKASI: Beranda - Teks Judul & Garis Progres Kartu Pintasan
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
          // LOKASI: Beranda - Area Sentuh Ripple Kartu Pintasan Cepat
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _playTrack(item.title, 'Pintasan cepat', item.imageUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // LOKASI: Beranda - Helper Gambar Cover Kotak Sudut Membulat & Placeholder
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

// LOKASI: Beranda - Model Data Lagu Pilihan Cepat (_SongItemData)
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

// LOKASI: Beranda - Model Data Kartu Pintasan Cepat (_ShortcutItemData)
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
