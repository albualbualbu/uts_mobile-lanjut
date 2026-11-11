import 'package:flutter/material.dart';

import '../widgets/music_common_widgets.dart';
import 'upgrade_page.dart';

/// Halaman menu akun pengguna (Akun) dengan tema gelap YouTube Music.
/// Halaman ini menampilkan tampilan statis terpisah dari bottom navigation bar.
class AccountPage extends StatelessWidget {
  final VoidCallback? onCloseTap;
  final VoidCallback? onGetPremiumTap;

  const AccountPage({
    super.key,
    this.onCloseTap,
    this.onGetPremiumTap,
  });

  void _navigateToUpgrade(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (_) => const UpgradePage(),
        ),
      );
    }
  }

  // Daftar menu utama sesuai urutan pada tampilan referensi Akun
  static const List<_AccountMenuItem> _menuItems = [
    _AccountMenuItem(icon: Icons.account_box_outlined, title: 'Channel Anda'),
    _AccountMenuItem(icon: Icons.download_outlined, title: 'Download'),
    _AccountMenuItem(icon: Icons.history, title: 'Histori'),
    _AccountMenuItem(icon: Icons.fast_rewind, title: 'Recap Kamu'),
    _AccountMenuItem(icon: Icons.celebration_outlined, title: 'Badge'),
    _AccountMenuItem(icon: Icons.switch_account_outlined, title: 'Ganti akun'),
    _AccountMenuItem(icon: Icons.settings_outlined, title: 'Setelan'),
    _AccountMenuItem(icon: Icons.help_outline, title: 'Bantuan & saran'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildProfileSection(),
                                  const Divider(
                                    color: Color(0xFF2B2B2B),
                                    height: 1,
                                    thickness: 1,
                                  ),
                                  const SizedBox(height: 6),
                                  for (final _AccountMenuItem item
                                      in _menuItems)
                                    _buildMenuItem(item),
                                  const SizedBox(height: 24),
                                ],
                              ),
                              _buildFooterInfo(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildGetPremiumButton(context),
    );
  }

  /// Header dengan ikon X di kiri dan judul "Akun".
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 6, 16, 6),
      child: Row(
        children: [
          IconButton(
            onPressed: onCloseTap ?? () => _navigateToUpgrade(context),
            icon: const Icon(
              Icons.close,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Akun',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Bagian profil pengguna berisi avatar, nama, username, panah kanan, dan tautan biru.
  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserProfileAvatar(size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trcy.',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '@Tracy_07',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 22,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Kelola Akun Google Anda',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF3EA6FF),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Satu baris item menu dengan ikon dan label teks.
  Widget _buildMenuItem(_AccountMenuItem item) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            Icon(
              item.icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Informasi kebijakan privasi, persyaratan layanan, dan ringkasan manfaat Music Premium.
  Widget _buildFooterInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: const [
              Text(
                'Kebijakan Privasi',
                style: TextStyle(
                  color: Color(0xFFAAAAAA),
                  fontSize: 13,
                ),
              ),
              Text(
                '\u2022',
                style: TextStyle(
                  color: Color(0xFFAAAAAA),
                  fontSize: 13,
                ),
              ),
              Text(
                'Persyaratan Layanan',
                style: TextStyle(
                  color: Color(0xFFAAAAAA),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Nikmati musik bebas iklan, dengarkan mode audio, dan putar musik secara offline.',
            style: TextStyle(
              color: Color(0xFF9E9E9E),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  /// Tombol merah besar di bagian paling bawah untuk penawaran Music Premium.
  Widget _buildGetPremiumButton(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: onGetPremiumTap ?? () => _navigateToUpgrade(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE60000),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text(
              'Dapatkan Music Premium',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Model data sederhana untuk satu baris menu pada halaman Akun.
class _AccountMenuItem {
  final IconData icon;
  final String title;

  const _AccountMenuItem({
    required this.icon,
    required this.title,
  });
}
