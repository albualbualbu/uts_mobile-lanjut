import 'package:flutter/material.dart';
import '../data/image_urls.dart';
import 'collection_page.dart';

/// Halaman Telusuri (Search) untuk tampilan visual aplikasi musik.
class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
    this.onTabSelected,
  });

  /// Callback opsional untuk pergantian tab ketika dibungkus oleh halaman utama.
  final ValueChanged<int>? onTabSelected;

  void _navigateToCollection(BuildContext context) {
    if (onTabSelected != null) {
      onTabSelected!(3);
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (_) => const CollectionPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchHeader(context),
              _buildRecentSearchSection(),
              const SizedBox(height: 8),
              _buildSearchAndArtistList(),
              const SizedBox(height: 16),
              _buildRecommendationCards(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMiniPlayer(),
          _buildBottomNavigation(context),
        ],
      ),
    );
  }

  /// Header pencarian dengan tombol kembali, kolom input visual, mic, dan pencarian suara.
  Widget _buildSearchHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF212121),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 22,
                    ),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Text(
                      'Ketik untuk menelusuri',
                      style: TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.mic_none,
                      color: Colors.white,
                      size: 22,
                    ),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFF212121),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.graphic_eq,
                color: Colors.white,
                size: 22,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  /// Bagian "Penelusuran terbaru" berupa daftar kartu horizontal.
  Widget _buildRecentSearchSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 6, 16, 12),
          child: Text(
            'Penelusuran terbaru',
            style: TextStyle(
              color: Color(0xFFB3B3B3),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRecentSearchCard(
                imageUrl: ImageUrls.searchRecent1,
                title: 'Melompat Lebih Tinggi',
              ),
              const SizedBox(width: 12),
              _buildRecentSearchCard(
                imageUrl: ImageUrls.searchRecent2,
                title: 'Kugadaikan Cintaku',
              ),
              const SizedBox(width: 12),
              _buildRecentSearchCard(
                imageUrl: ImageUrls.searchRecent3,
                title: 'Great Expectations',
              ),
              const SizedBox(width: 12),
              _buildRecentSearchCard(
                imageUrl: ImageUrls.searchRecent4,
                title: 'BRAVY YEAR MIX 2025',
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Item kartu kotak untuk daftar penelusuran terbaru.
  Widget _buildRecentSearchCard({
    required String imageUrl,
    required String title,
  }) {
    return SizedBox(
      width: 98,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 98,
              height: 98,
              color: const Color(0xFF212121),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.music_note,
                      color: Colors.white54,
                      size: 32,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Daftar riwayat pencarian dan rekomendasi artis sesuai susunan screenshot.
  Widget _buildSearchAndArtistList() {
    return Column(
      children: [
        _buildHistoryRow('bravy'),
        _buildArtistRow(
          name: 'One Direction',
          subtitle: '90,8 jt audiens bulanan',
          imageUrl: ImageUrls.artistOneDirection,
        ),
        _buildHistoryRow('kepada noor'),
        _buildHistoryRow('izinkan aku untuk terakhir kalinya'),
        _buildArtistRow(
          name: 'Bruno Mars',
          subtitle: '608 jt audiens bulanan',
          imageUrl: ImageUrls.artistBrunoMars,
        ),
        _buildArtistRow(
          name: 'YOASOBI',
          subtitle: 'Rilis baru',
          imageUrl: ImageUrls.artistYoasobi,
        ),
      ],
    );
  }

  /// Baris riwayat pencarian dengan ikon jam di kiri dan panah isi otomatis di kanan.
  Widget _buildHistoryRow(String query) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const SizedBox(
            width: 48,
            child: Center(
              child: Icon(
                Icons.history,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              query,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.north_west,
              color: Colors.white,
              size: 20,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }

  /// Baris rekomendasi artis dengan foto lingkaran, nama, info audiens, dan menu titik tiga.
  Widget _buildArtistRow({
    required String name,
    required String subtitle,
    required String imageUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ClipOval(
            child: Container(
              width: 48,
              height: 48,
              color: const Color(0xFF2A2A2A),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white54,
                      size: 26,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 13.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {},
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
    );
  }

  /// Kartu rekomendasi tambahan di bagian bawah halaman Telusuri.
  Widget _buildRecommendationCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildRecommendationCard(
              icon: Icons.new_releases_outlined,
              label: 'Rilis\nbaru',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildRecommendationCard(
              icon: Icons.trending_up,
              label: 'Tangga\nLagu',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildRecommendationCard(
              icon: Icons.sentiment_satisfied_alt,
              label: 'Jenis\nMusik',
            ),
          ),
        ],
      ),
    );
  }

  /// Satu kartu rekomendasi berlatar abu-abu gelap dengan sudut membulat.
  Widget _buildRecommendationCard({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Mini player visual di atas bottom navigation.
  Widget _buildMiniPlayer() {
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
                    width: 46,
                    height: 46,
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
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Pamungkas',
                        style: TextStyle(
                          color: Color(0xFFAAAAAA),
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
            color: const Color(0xFF333333),
          ),
        ],
      ),
    );
  }

  /// Bottom navigation dengan menu Telusuri aktif dan navigasi ke Koleksi.

Widget _buildBottomNavigation(BuildContext context) {
  return Container(
    color: const Color(0xFF1C1C1C),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            _buildNavItem(
              icon: Icons.home_outlined,
              label: 'Beranda',
              isActive: false,
              onTap: () => onTabSelected?.call(0),
            ),
            _buildNavItem(
              icon: Icons.fast_forward_outlined,
              label: 'Sampel',
              isActive: false,
              onTap: () => onTabSelected?.call(1),
            ),
            _buildNavItem(
              icon: Icons.search,
              label: 'Telusuri',
              isActive: true,
            ),
            _buildNavItem(
              icon: Icons.bookmark_border,
              label: 'Koleksi',
              isActive: false,
              onTap: () => _navigateToCollection(context),
            ),
            _buildNavItem(
              icon: Icons.play_circle_outline,
              label: 'Upgrade',
              isActive: false,
              onTap: () => onTabSelected?.call(4),
            ),
          ],
        ),
      ),
    ),
  );
}


  /// Satu item menu pada bottom navigation.
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    VoidCallback? onTap,
  }) {
    final Color color = isActive ? Colors.white : const Color(0xFFC4C4C4);
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

