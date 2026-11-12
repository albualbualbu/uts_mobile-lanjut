import 'package:flutter/material.dart';

import '../widgets/music_common_widgets.dart';
import 'upgrade_page.dart';

// LOKASI: Halaman Menu Akun Pengguna (AccountPage)
class AccountPage extends StatelessWidget {
  final VoidCallback? onCloseTap;
  final VoidCallback? onGetPremiumTap;

  const AccountPage({
    super.key,
    this.onCloseTap,
    this.onGetPremiumTap,
  });

  // LOKASI: Akun - Fungsi Tutup Modal / Kembali ke Halaman Upgrade
  void _closeOrNavigateToUpgrade(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        buildSlideUpRoute(const UpgradePage()),
      );
    }
  }

  // LOKASI: Akun - Daftar 8 Item Menu Utama Akun (Channel, Download, Histori, Recap, Badge, Ganti Akun, Setelan, Bantuan)
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
                // LOKASI: Akun - Daftar Scroll Profil, Menu Akun, & Footer
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
                                  _buildProfileSection(context),
                                  const Divider(
                                    color: Color(0xFF2B2B2B),
                                    height: 1,
                                    thickness: 1,
                                  ),
                                  const SizedBox(height: 6),
                                  for (final _AccountMenuItem item
                                      in _menuItems)
                                    _buildMenuItem(context, item),
                                  const SizedBox(height: 24),
                                ],
                              ),
                              _buildFooterInfo(context),
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

  // LOKASI: Akun - Header Atas (Tombol Tutup X & Judul "Akun")
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 6, 16, 6),
      child: Row(
        children: [
          // LOKASI: Akun - Tombol Tutup Halaman Akun (Ikon X)
          IconButton(
            onPressed: onCloseTap ?? () => _closeOrNavigateToUpgrade(context),
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

  // LOKASI: Akun - Bagian Profil Pengguna (Avatar, Trcy., @Tracy_07, Kelola Akun Google)
  Widget _buildProfileSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LOKASI: Akun - Avatar Profil Besar
          const UserProfileAvatar(size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LOKASI: Akun - Baris Nama & Username (@Tracy_07)
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => showMusicFeedback(
                    context,
                    'Profil akun: Trcy. (@Tracy_07)',
                  ),
                  child: const Row(
                    children: [
                      Expanded(
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
                      SizedBox(width: 8),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 22,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                // LOKASI: Akun - Teks Biru "Kelola Akun Google Anda"
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () => showMusicFeedback(
                    context,
                    'Membuka pengelolaan Akun Google',
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      'Kelola Akun Google Anda',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFF3EA6FF),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // LOKASI: Akun - Widget Baris Item Menu Akun (Ikon + Judul Menu)
  Widget _buildMenuItem(BuildContext context, _AccountMenuItem item) {
    return InkWell(
      onTap: () => showMusicFeedback(context, 'Membuka menu ${item.title}'),
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

  // LOKASI: Akun - Footer (Kebijakan Privasi, Persyaratan Layanan, & Info Manfaat Premium)
  Widget _buildFooterInfo(BuildContext context) {
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
            children: [
              // LOKASI: Akun - Tautan Kebijakan Privasi
              InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () =>
                    showMusicFeedback(context, 'Membuka Kebijakan Privasi'),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: Text(
                    'Kebijakan Privasi',
                    style: TextStyle(
                      color: Color(0xFFAAAAAA),
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const Text(
                '\u2022',
                style: TextStyle(
                  color: Color(0xFFAAAAAA),
                  fontSize: 13,
                ),
              ),
              // LOKASI: Akun - Tautan Persyaratan Layanan
              InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () =>
                    showMusicFeedback(context, 'Membuka Persyaratan Layanan'),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: Text(
                    'Persyaratan Layanan',
                    style: TextStyle(
                      color: Color(0xFFAAAAAA),
                      fontSize: 13,
                    ),
                  ),
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

  // LOKASI: Akun - Tombol Merah Bawah ("Dapatkan Music Premium" Menuju Tab Upgrade)
  Widget _buildGetPremiumButton(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed:
                onGetPremiumTap ?? () => _closeOrNavigateToUpgrade(context),
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

// LOKASI: Akun - Model Data Item Menu Akun (_AccountMenuItem)
class _AccountMenuItem {
  final IconData icon;
  final String title;

  const _AccountMenuItem({
    required this.icon,
    required this.title,
  });
}
