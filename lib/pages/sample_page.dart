import 'package:flutter/material.dart';

import '../data/image_urls.dart';
import '../widgets/music_bottom_nav.dart';
import '../widgets/music_common_widgets.dart';

// LOKASI: Halaman Sampel / Samples (SamplePage)
class SamplePage extends StatefulWidget {
  final ValueChanged<int>? onNavTap;
  final bool showBottomBar;
  final void Function(String title, String artist, String coverUrl)? onSongTap;

  const SamplePage({
    super.key,
    this.onNavTap,
    this.showBottomBar = true,
    this.onSongTap,
  });

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  // LOKASI: Sampel - State Status Like, Simpan, & Play/Jeda
  bool _isLiked = false;
  bool _isSaved = false;
  bool _isPlaying = true;

  @override
  Widget build(BuildContext context) {
    // LOKASI: Sampel - Daftar 6 Tombol Interaksi Sisi Kanan (Like, Komentar, Simpan, Shorts, Share, Putar)
    final List<_SideActionData> sideActions = [
      // LOKASI: Sampel - Tombol Like
      _SideActionData(
        icon: _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
        label: _isLiked ? '773 rb' : '772 rb',
        isActive: _isLiked,
        onTap: () {
          setState(() {
            _isLiked = !_isLiked;
          });
        },
      ),
      // LOKASI: Sampel - Tombol Komentar
      _SideActionData(
        icon: Icons.comment_outlined,
        label: '31 rb',
        onTap: () => showMusicFeedback(context, 'Membuka 31 rb komentar'),
      ),
      // LOKASI: Sampel - Tombol Simpan ke Koleksi
      _SideActionData(
        icon: _isSaved ? Icons.playlist_add_check : Icons.playlist_add,
        label: _isSaved ? 'Tersimpan' : 'Simpan',
        isActive: _isSaved,
        onTap: () {
          setState(() {
            _isSaved = !_isSaved;
          });
          showMusicFeedback(
            context,
            _isSaved ? 'Disimpan ke koleksi' : 'Dihapus dari koleksi',
          );
        },
      ),
      // LOKASI: Sampel - Tombol Shorts / Musik
      _SideActionData(
        icon: Icons.music_note,
        label: 'Shorts',
        onTap: () => showMusicFeedback(context, 'Membuka audio Shorts'),
      ),
      // LOKASI: Sampel - Tombol Share / Bagikan
      _SideActionData(
        icon: Icons.share_outlined,
        label: '1,1 jt',
        onTap: () => showMusicFeedback(context, 'Tautan sampel siap dibagikan'),
      ),
      // LOKASI: Sampel - Tombol Play / Jeda
      _SideActionData(
        icon: _isPlaying ? Icons.pause : Icons.play_arrow_outlined,
        label: _isPlaying ? 'Jeda' : 'Putar',
        onTap: () {
          setState(() {
            _isPlaying = !_isPlaying;
          });
          if (_isPlaying && widget.onSongTap != null) {
            widget.onSongTap!(
              'I Lay My Love on You (Remix)',
              'Westlife',
              ImageUrls.sampleAlbum1,
            );
          }
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // LOKASI: Sampel - Gambar Background / Thumbnail Video Penuh Layar
          _buildBackgroundThumbnail(),

          // LOKASI: Sampel - Overlay Gradien Gelap Atas & Bawah
          _buildGradientOverlays(),

          // LOKASI: Sampel - Layer Overlay Atas Gambar (Header, Lirik, Tombol Kanan, Info Lagu)
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Stack(
                    children: [
                      // LOKASI: Sampel - Teks Lirik Lagu Mengambang di Tengah Layar
                      Align(
                        alignment: const Alignment(-0.25, 0.08),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          color: Colors.black87,
                          child: const Text(
                            '♪ I lay my love on you ♪',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      // LOKASI: Sampel - Kolom Tombol Interaksi di Sisi Kanan
                      Positioned(
                        right: 12,
                        top: 0,
                        bottom: 76,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: sideActions
                                  .map((item) => _buildSideActionButton(item))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),

                      // LOKASI: Sampel - Info Lagu Kiri Bawah & Menu Tiga Titik Kanan Bawah
                      Positioned(
                        left: 16,
                        right: 12,
                        bottom: 16,
                        child: _buildTrackInfo(),
                      ),

                      // LOKASI: Sampel - Garis Progres Tipis Bagian Bawah Video
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: SizedBox(
                          height: 2,
                          child: Row(
                            children: [
                              Expanded(
                                flex: _isPlaying ? 4 : 2,
                                child: Container(color: Colors.white),
                              ),
                              Expanded(
                                flex: _isPlaying ? 6 : 8,
                                child: Container(color: Colors.white24),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // LOKASI: Sampel - Bottom Navigation Bar Standalone
      bottomNavigationBar: widget.showBottomBar
          ? MusicBottomNav(
              currentIndex: 1,
              backgroundColor: const Color(0xFF0A0A0A),
              onTap: widget.onNavTap,
            )
          : null,
    );
  }

  // LOKASI: Sampel - Widget Gambar Thumbnail Latar Belakang + Placeholder Error
  Widget _buildBackgroundThumbnail() {
    return Image.network(
      ImageUrls.sample1,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1F2A30),
                Color(0xFF121619),
                Color(0xFF080808),
              ],
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.ondemand_video,
              color: Colors.white24,
              size: 72,
            ),
          ),
        );
      },
    );
  }

  // LOKASI: Sampel - Widget Gradien Gelap Pelapis Atas & Bawah
  Widget _buildGradientOverlays() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 120,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xA6000000),
                Colors.transparent,
              ],
            ),
          ),
        ),
        Container(
          height: 220,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xD9000000),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }

  // LOKASI: Sampel - Header Atas (Logo Music)
  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          YouTubeMusicLogo(
            iconSize: 28,
            label: 'Music',
            fontSize: 22,
            spacing: 8,
          ),
        ],
      ),
    );
  }

  // LOKASI: Sampel - Widget Satu Tombol Bulat Interaksi Sisi Kanan
  Widget _buildSideActionButton(_SideActionData item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: item.isActive
                ? Colors.white.withValues(alpha: 0.22)
                : const Color(0x66000000),
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: item.onTap,
              child: SizedBox(
                width: 44,
                height: 44,
                child: Icon(
                  item.icon,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // LOKASI: Sampel - Informasi Lagu Bawah (Cover Album, Judul, Penyanyi, Menu Tiga Titik)
  Widget _buildTrackInfo() {
    return Row(
      children: [
        // LOKASI: Sampel - Cover Album Lagu Bawah
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            ImageUrls.sampleAlbum1,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 48,
                height: 48,
                color: const Color(0xFF262626),
                child: const Icon(
                  Icons.music_note,
                  color: Colors.white54,
                  size: 24,
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        // LOKASI: Sampel - Teks Judul Lagu & Penyanyi Bawah
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'I Lay My Love on You (Remix)',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Westlife',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // LOKASI: Sampel - Tombol Menu Tiga Titik Lagu Bawah
        IconButton(
          onPressed: () => showTrackOptionsSheet(
            context,
            title: 'I Lay My Love on You (Remix)',
            subtitle: 'Westlife',
          ),
          icon: const Icon(
            Icons.more_horiz,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }
}

// LOKASI: Sampel - Model Data Tombol Interaksi Sisi Kanan (_SideActionData)
class _SideActionData {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SideActionData({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });
}
