import 'package:flutter/material.dart';
import '../data/image_urls.dart';
import 'search_page.dart';

/// Halaman Koleksi (Collection/Library) untuk tampilan visual aplikasi musik.
class CollectionPage extends StatelessWidget {
  const CollectionPage({
    super.key,
    this.onTabSelected,
  });

  /// Callback opsional untuk pergantian tab ketika dibungkus oleh halaman utama.
  final ValueChanged<int>? onTabSelected;

  void _navigateToSearch(BuildContext context, {bool push = false}) {
    if (onTabSelected != null) {
      onTabSelected!(2);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
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
            Positioned(
              right: 16,
              bottom: 14,
              child: _buildNewButton(),
            ),
          ],
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

  /// Header dengan judul "Koleksi", ikon riwayat, ikon pencarian, dan foto profil.
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
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
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.history,
              color: Colors.white,
              size: 24,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          const SizedBox(width: 8),
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
          const SizedBox(width: 12),
          ClipOval(
            child: Container(
              width: 28,
              height: 28,
              color: const Color(0xFF2A2A2A),
              child: Image.network(
                ImageUrls.profile,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white70,
                      size: 18,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Deretan chip kategori koleksi yang dapat digeser secara horizontal.
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF212121),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF2E2E2E),
                  width: 0.8,
                ),
              ),
              child: Text(
                categories[i],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Baris pengaturan urutan "Aktivitas terbaru" dan ikon tampilan grid.
  Widget _buildListControls() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          const Text(
            'Aktivitas terbaru',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 20,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.grid_view,
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

  /// Daftar playlist dan profil artis pada halaman Koleksi.
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

  /// Item khusus "Musik yang Disukai" dengan thumbnail kotak bergradien ungu-pink.
  Widget _buildLikedMusicItem() {
    return Padding(
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

  /// Item profil koleksi dengan foto berbentuk lingkaran.
  Widget _buildProfileCollectionItem({
    required String title,
    required String subtitle,
    required String imageUrl,
  }) {
    return Padding(
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

  /// Tombol floating "+ Baru" berbentuk pill putih dengan teks hitam.
  Widget _buildNewButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Row(
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

  /// Bottom navigation dengan menu Koleksi aktif dan navigasi ke Telusuri.
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
              ),
              _buildNavItem(
                icon: Icons.fast_forward_outlined,
                label: 'Sampel',
                isActive: false,
              ),
              _buildNavItem(
                icon: Icons.search,
                label: 'Telusuri',
                isActive: false,
                onTap: () => _navigateToSearch(context),
              ),
              _buildNavItem(
                icon: Icons.bookmark,
                label: 'Koleksi',
                isActive: true,
              ),
              _buildNavItem(
                icon: Icons.play_circle_outline,
                label: 'Upgrade',
                isActive: false,
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

