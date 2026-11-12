import 'package:flutter/material.dart';

import '../data/image_urls.dart';
import '../widgets/music_common_widgets.dart';
import 'account_page.dart';
import 'search_page.dart';

// LOKASI: Halaman Koleksi / Collection / Library (CollectionPage)
class CollectionPage extends StatefulWidget {
  const CollectionPage({
    super.key,
    this.onTabSelected,
    this.onProfileTap,
    this.scrollController,
    this.showBottomBar = true,
    this.onSongTap,
  });

  // LOKASI: Koleksi - Parameter Callback Navigasi Tab, Profil, Scroll, & Putar Lagu
  final ValueChanged<int>? onTabSelected;
  final VoidCallback? onProfileTap;
  final ScrollController? scrollController;
  final bool showBottomBar;
  final void Function(String title, String artist, String coverUrl)? onSongTap;

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  // LOKASI: Koleksi - State Chip Filter Kategori & Toggle Mode Grid/Daftar
  int? _selectedCategoryIndex;
  bool _isGridView = false;

  // LOKASI: Koleksi - Fungsi Navigasi ke Halaman Telusuri (Ikon Cari Header)
  void _navigateToSearch(BuildContext context, {bool push = false}) {
    if (widget.onTabSelected != null) {
      widget.onTabSelected!(2);
      return;
    }
    final MaterialPageRoute<void> route = MaterialPageRoute<void>(
      builder: (_) => const SearchPage(),
    );
    if (push) {
      Navigator.push(context, route);
    } else {
      Navigator.pushReplacement(context, route);
    }
  }

  // LOKASI: Koleksi - Fungsi Buka Halaman Akun dari Avatar Profil Header
  void _openAccountPage() {
    if (widget.onProfileTap != null) {
      widget.onProfileTap!();
      return;
    }
    Navigator.of(context).push(buildSlideUpRoute(const AccountPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // LOKASI: Koleksi - Daftar Scroll Utama Konten Koleksi
            SingleChildScrollView(
              controller: widget.scrollController,
              padding: const EdgeInsets.only(bottom: 84),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  _buildCategoryChips(),
                  _buildListControls(),
                  _buildCollectionList(),
                ],
              ),
            ),
            // LOKASI: Koleksi - Posisi Tombol Floating (+ Baru) di Kanan Bawah
            Positioned(
              right: 16,
              bottom: 14,
              child: _buildNewButton(),
            ),
          ],
        ),
      ),
      // LOKASI: Koleksi - Bottom Bar Standalone (Mini Player + Bottom Navigation)
      bottomNavigationBar: widget.showBottomBar
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const MusicMiniPlayer(),
                MusicBottomNavBar(
                  activeIndex: 3,
                  backgroundColor: const Color(0xFF1C1C1C),
                  onTap: (index) {
                    if (index == 2 && widget.onTabSelected == null) {
                      _navigateToSearch(context);
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

  // LOKASI: Koleksi - Header Atas (Judul Koleksi, Ikon Riwayat, Ikon Cari, Avatar Profil)
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 10, 10),
      child: Row(
        children: [
          const Text(
            'Koleksi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          // LOKASI: Koleksi - Tombol Ikon Riwayat Pemutaran Header
          IconButton(
            onPressed: () =>
                showMusicFeedback(context, 'Membuka histori pemutaran'),
            icon: const Icon(
              Icons.history,
              color: Colors.white,
              size: 24,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          const SizedBox(width: 4),
          // LOKASI: Koleksi - Tombol Ikon Search Header (Menuju Tab Telusuri)
          IconButton(
            onPressed: () => _navigateToSearch(context, push: true),
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 24,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          const SizedBox(width: 4),
          // LOKASI: Koleksi - Tombol Avatar Profil Header (Menuju Halaman Akun)
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

  // LOKASI: Koleksi - Baris Chip Filter Kategori (Download, Playlist, Lagu, Album, Artis)
  Widget _buildCategoryChips() {
    const List<String> categories = [
      'Download',
      'Playlist',
      'Lagu',
      'Album',
      'Artis',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
      child: Row(
        children: [
          for (int i = 0; i < categories.length; i++) ...[
            if (i > 0) const SizedBox(width: 10),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  setState(() {
                    _selectedCategoryIndex =
                        _selectedCategoryIndex == i ? null : i;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: _selectedCategoryIndex == i
                        ? Colors.white
                        : const Color(0xFF212121),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _selectedCategoryIndex == i
                          ? Colors.white
                          : const Color(0xFF2E2E2E),
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    categories[i],
                    style: TextStyle(
                      color: _selectedCategoryIndex == i
                          ? Colors.black
                          : Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // LOKASI: Koleksi - Baris Kontrol Urutan (Aktivitas Terbaru & Toggle Grid/List)
  Widget _buildListControls() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          // LOKASI: Koleksi - Tombol Dropdown Urutan Aktivitas Terbaru
          InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: () => showMusicFeedback(
              context,
              'Diurutkan berdasarkan aktivitas terbaru',
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Text(
                    'Aktivitas terbaru',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          // LOKASI: Koleksi - Tombol Toggle Tampilan Grid / Daftar
          IconButton(
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
              showMusicFeedback(
                context,
                _isGridView ? 'Tampilan grid dipilih' : 'Tampilan daftar dipilih',
              );
            },
            icon: Icon(
              _isGridView ? Icons.view_list : Icons.grid_view,
              color: Colors.white,
              size: 22,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }

  // LOKASI: Koleksi - Daftar Item Playlist & Profil Artis Koleksi
  Widget _buildCollectionList() {
    return Column(
      children: [
        _buildLikedMusicItem(),
        _buildProfileCollectionItem(
          title: 'KARAOKE SITE',
          subtitle: 'Profil \u00B7 @karaokesite',
          imageUrl: ImageUrls.karaokeSite,
        ),
        _buildProfileCollectionItem(
          title: 'NUR EDIT',
          subtitle: 'Profil \u00B7 @NUREDIT1',
          imageUrl: ImageUrls.nurEdit,
        ),
        _buildProfileCollectionItem(
          title: 'Rudi Agustian',
          subtitle: 'Profil \u00B7 @RudiAgustian',
          imageUrl: ImageUrls.rudiAgustian,
        ),
        _buildProfileCollectionItem(
          title: 'sing a song',
          subtitle: 'Profil \u00B7 @singasong-16',
          imageUrl: ImageUrls.singASong,
        ),
        _buildProfileCollectionItem(
          title: 'Zaidan',
          subtitle: 'Profil \u00B7 @mohammadzaidanmusic',
          imageUrl: ImageUrls.zaidan,
        ),
        _buildProfileCollectionItem(
          title: 'Hargun Somwani',
          subtitle: 'Profil \u00B7 @hargunsomwani',
          imageUrl: ImageUrls.hargunSomwani,
        ),
      ],
    );
  }

  // LOKASI: Koleksi - Item Khusus Musik yang Disukai (Thumbnail Ungu-Pink + Menu Tiga Titik)
  Widget _buildLikedMusicItem() {
    return InkWell(
      onTap: () {
        if (widget.onSongTap != null) {
          widget.onSongTap!(
            'Musik yang Disukai',
            'Playlist otomatis',
            ImageUrls.likedMusic,
          );
        } else {
          showMusicFeedback(context, 'Membuka Musik yang Disukai');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                width: 54,
                height: 54,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF7066FF),
                      Color(0xFFE059DE),
                    ],
                  ),
                ),
                child: Image.network(
                  ImageUrls.likedMusic,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.thumb_up,
                        color: Colors.white,
                        size: 26,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Musik yang Disukai',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.5,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(
                        Icons.push_pin,
                        color: Color(0xFF9E9E9E),
                        size: 13,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Playlist otomatis',
                          style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 13.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // LOKASI: Koleksi - Tombol Menu Tiga Titik Musik yang Disukai
            IconButton(
              onPressed: () => showTrackOptionsSheet(
                context,
                title: 'Musik yang Disukai',
                subtitle: 'Playlist otomatis',
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

  // LOKASI: Koleksi - Item Profil Koleksi (Foto Lingkaran, Nama, Handle, Menu Tiga Titik)
  Widget _buildProfileCollectionItem({
    required String title,
    required String subtitle,
    required String imageUrl,
  }) {
    return InkWell(
      onTap: () => showMusicFeedback(context, 'Membuka $title'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                width: 54,
                height: 54,
                color: const Color(0xFF2A2A2A),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.white54,
                        size: 28,
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
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.5,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
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
            // LOKASI: Koleksi - Tombol Menu Tiga Titik Item Profil Koleksi
            IconButton(
              onPressed: () => showTrackOptionsSheet(
                context,
                title: title,
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

  // LOKASI: Koleksi - Tombol Floating Putih (+ Baru)
  Widget _buildNewButton() {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(28),
      elevation: 6,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () => showMusicFeedback(context, 'Buat playlist atau radio baru'),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add,
                color: Colors.black,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                'Baru',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
