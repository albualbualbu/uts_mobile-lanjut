import 'package:flutter/material.dart';

import '../data/image_urls.dart';
import '../widgets/music_common_widgets.dart';
import 'collection_page.dart';

// LOKASI: Halaman Telusuri / Search (SearchPage)
class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
    this.onTabSelected,
    this.onBackTap,
    this.scrollController,
    this.showBottomBar = true,
    this.onSongTap,
  });

  // LOKASI: Telusuri - Parameter Callback Navigasi Tab, Back, Scroll, & Putar Lagu
  final ValueChanged<int>? onTabSelected;
  final VoidCallback? onBackTap;
  final ScrollController? scrollController;
  final bool showBottomBar;
  final void Function(String title, String artist, String coverUrl)? onSongTap;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // LOKASI: Telusuri - Controller & FocusNode Input Kolom Pencarian
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  // LOKASI: Telusuri - Aksi Tombol Kembali (Panah Kiri Bilah Pencarian)
  void _handleBack(BuildContext context) {
    _searchFocusNode.unfocus();
    if (widget.onBackTap != null) {
      widget.onBackTap!();
      return;
    }
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  // LOKASI: Telusuri - Navigasi ke Halaman Koleksi (Mode Standalone)
  void _navigateToCollection(BuildContext context) {
    _searchFocusNode.unfocus();
    if (widget.onTabSelected != null) {
      widget.onTabSelected!(3);
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (_) => const CollectionPage(),
      ),
    );
  }

  // LOKASI: Telusuri - Isi Otomatis Teks Kolom Pencarian dari Riwayat
  void _fillSearchQuery(String query) {
    setState(() {
      _searchController.text = query;
      _searchController.selection = TextSelection.collapsed(
        offset: query.length,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // LOKASI: Telusuri - Daftar Scroll Utama Halaman Telusuri
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          controller: widget.scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
      // LOKASI: Telusuri - Bottom Bar Standalone (Mini Player + Bottom Navigation)
      bottomNavigationBar: widget.showBottomBar
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const MusicMiniPlayer(),
                MusicBottomNavBar(
                  activeIndex: 2,
                  backgroundColor: const Color(0xFF1C1C1C),
                  onTap: (index) {
                    if (index == 3 && widget.onTabSelected == null) {
                      _navigateToCollection(context);
                    } else {
                      widget.onTabSelected?.call(index);
                    }
                  },
                ),
              ],
            )
          : null,
    );
  }

  // LOKASI: Telusuri - Header Pencarian (Tombol Back, Kolom Ketik, Clear, Mic, Pengenalan Lagu)
  Widget _buildSearchHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      child: Row(
        children: [
          // LOKASI: Telusuri - Kotak Input Pencarian (Bentuk Pill)
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
                  // LOKASI: Telusuri - Tombol Panah Kembali SearchBar
                  IconButton(
                    onPressed: () => _handleBack(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 22,
                    ),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(width: 4),
                  // LOKASI: Telusuri - Kolom TextField Ketik Pencarian
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textInputAction: TextInputAction.search,
                      onChanged: (_) => setState(() {}),
                      onSubmitted: (value) {
                        final String query = value.trim();
                        if (query.isNotEmpty) {
                          showMusicFeedback(context, 'Mencari "$query"...');
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Ketik untuk menelusuri',
                        hintStyle: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                  // LOKASI: Telusuri - Tombol Hapus Teks Pencarian (X)
                  if (_searchController.text.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white70,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  // LOKASI: Telusuri - Tombol Mikrofon Pencarian Suara
                  IconButton(
                    onPressed: () => showMusicFeedback(
                      context,
                      'Pencarian suara siap digunakan',
                    ),
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
          // LOKASI: Telusuri - Tombol Bulat Pengenalan Lagu (Ikon Gelombang Suara)
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFF212121),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => showMusicFeedback(
                context,
                'Pengenalan musik siap digunakan',
              ),
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

  // LOKASI: Telusuri - Bagian Penelusuran Terbaru (Judul + Scroll Kartu Horizontal)
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
                artist: 'Sheila On 7',
              ),
              const SizedBox(width: 12),
              _buildRecentSearchCard(
                imageUrl: ImageUrls.searchRecent2,
                title: 'Kugadaikan Cintaku',
                artist: 'Gombloh',
              ),
              const SizedBox(width: 12),
              _buildRecentSearchCard(
                imageUrl: ImageUrls.searchRecent3,
                title: 'Great Expectations',
                artist: 'SIENNA SPIRO',
              ),
              const SizedBox(width: 12),
              _buildRecentSearchCard(
                imageUrl: ImageUrls.searchRecent4,
                title: 'BRAVY YEAR MIX 2025',
                artist: 'Bravy',
              ),
            ],
          ),
        ),
      ],
    );
  }

  // LOKASI: Telusuri - Kartu Individual Penelusuran Terbaru
  Widget _buildRecentSearchCard({
    required String imageUrl,
    required String title,
    required String artist,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        if (widget.onSongTap != null) {
          widget.onSongTap!(title, artist, imageUrl);
        } else {
          showMusicFeedback(context, 'Memutar: $title');
        }
      },
      child: SizedBox(
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
      ),
    );
  }

  // LOKASI: Telusuri - Daftar Riwayat Pencarian & Rekomendasi Artis
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

  // LOKASI: Telusuri - Baris Riwayat Pencarian (Ikon Jam, Teks Query, Panah Autofill)
  Widget _buildHistoryRow(String query) {
    return InkWell(
      onTap: () {
        _fillSearchQuery(query);
        showMusicFeedback(context, 'Mencari "$query"...');
      },
      child: Padding(
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
            // LOKASI: Telusuri - Tombol Panah Autofill Riwayat ke SearchBar
            IconButton(
              onPressed: () => _fillSearchQuery(query),
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
      ),
    );
  }

  // LOKASI: Telusuri - Baris Rekomendasi Artis (Foto Bulat, Nama, Audiens, Menu Tiga Titik)
  Widget _buildArtistRow({
    required String name,
    required String subtitle,
    required String imageUrl,
  }) {
    return InkWell(
      onTap: () => showMusicFeedback(context, 'Membuka profil artis: $name'),
      child: Padding(
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
            // LOKASI: Telusuri - Tombol Menu Tiga Titik Rekomendasi Artis
            IconButton(
              onPressed: () => showTrackOptionsSheet(
                context,
                title: name,
                subtitle: subtitle,
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

  // LOKASI: Telusuri - Baris 3 Kartu Kategori Bawah (Rilis Baru, Tangga Lagu, Jenis Musik)
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

  // LOKASI: Telusuri - Kartu Kategori Individual Bawah
  Widget _buildRecommendationCard({
    required IconData icon,
    required String label,
  }) {
    final String cleanLabel = label.replaceAll('\n', ' ');

    return Material(
      color: const Color(0xFF1F1F1F),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => showMusicFeedback(context, 'Membuka $cleanLabel'),
        child: Padding(
          padding: const EdgeInsets.all(14),
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
        ),
      ),
    );
  }
}
