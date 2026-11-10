import 'package:flutter/material.dart';

import '../data/image_urls.dart';
import '../widgets/music_bottom_nav.dart';

/// Halaman Sampel (Samples) dengan tampilan video musik vertikal seperti Shorts.
/// Halaman ini berdiri sendiri dan hanya menampilkan tampilan visual statis.
class SamplePage extends StatelessWidget {
  final ValueChanged<int>? onNavTap;

  const SamplePage({super.key, this.onNavTap});

  // Daftar ikon interaksi di sisi kanan layar
  static const List<_SideActionData> _sideActions = [
    _SideActionData(icon: Icons.thumb_up_outlined, label: '772 rb'),
    _SideActionData(icon: Icons.comment_outlined, label: '31 rb'),
    _SideActionData(icon: Icons.playlist_add, label: 'Simpan'),
    _SideActionData(icon: Icons.music_note, label: 'Shorts'),
    _SideActionData(icon: Icons.share_outlined, label: '1,1 jt'),
    _SideActionData(icon: Icons.play_arrow_outlined, label: 'Putar'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Gambar latar belakang / thumbnail konten sampel memenuhi layar
          _buildBackgroundThumbnail(),

          // 2. Gradien gelap atas & bawah agar teks dan ikon tetap jelas dibaca
          _buildGradientOverlays(),

          // 3. Konten overlay di atas gambar (header, lirik, tombol kanan, info lagu)
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Stack(
                    children: [
                      // Teks lirik singkat di tengah layar seperti pada referensi
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

                      // Deretan tombol interaksi di sisi kanan
                      Positioned(
                        right: 12,
                        top: 0,
                        bottom: 76,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: _sideActions
                                  .map((item) => _buildSideActionButton(item))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),

                      // Informasi musik di kiri bawah + ikon menu tiga titik di kanan bawah
                      Positioned(
                        left: 16,
                        right: 12,
                        bottom: 16,
                        child: _buildTrackInfo(),
                      ),

                      // Garis progres tipis di bagian paling bawah konten
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: SizedBox(
                          height: 2,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(color: Colors.white),
                              ),
                              Expanded(
                                flex: 8,
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
      bottomNavigationBar: MusicBottomNav(
        currentIndex: 1,
        backgroundColor: const Color(0xFF0A0A0A),
        onTap: onNavTap,
      ),
    );
  }

  /// Gambar latar belakang full screen dengan placeholder jika URL belum diisi
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

  /// Overlay gradien tipis di bagian atas dan bawah gambar
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

  /// Header bagian atas dengan logo aplikasi
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
        ],
      ),
    );
  }

  /// Satu tombol interaksi bulat transparan di sisi kanan layar
  Widget _buildSideActionButton(_SideActionData item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0x66000000),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.icon,
              color: Colors.white,
              size: 22,
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

  /// Informasi lagu di kiri bawah: cover album, judul, penyanyi, dan menu tiga titik
  Widget _buildTrackInfo() {
    return Row(
      children: [
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
        const SizedBox(width: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.more_horiz,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }

}

/// Model sederhana untuk tombol interaksi di sisi kanan halaman Sampel
class _SideActionData {
  final IconData icon;
  final String label;

  const _SideActionData({
    required this.icon,
    required this.label,
  });
}
