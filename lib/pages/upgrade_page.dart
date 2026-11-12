import 'package:flutter/material.dart';

import '../widgets/music_common_widgets.dart';
import 'account_page.dart';

// LOKASI: Halaman Upgrade / YouTube Music Premium (UpgradePage)
class UpgradePage extends StatelessWidget {
  final ValueChanged<int>? onNavTap;
  final VoidCallback? onProfileTap;
  final ScrollController? scrollController;
  final bool showBottomBar;

  const UpgradePage({
    super.key,
    this.onNavTap,
    this.onProfileTap,
    this.scrollController,
    this.showBottomBar = true,
  });

  // LOKASI: Upgrade - Fungsi Navigasi ke Halaman Akun (Klik Avatar Profil)
  void _openAccountPage(BuildContext context) {
    if (onProfileTap != null) {
      onProfileTap!();
      return;
    }
    Navigator.of(context).push(
      buildSlideUpRoute(const AccountPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildGradientBackground(),
                  _buildScrollableContent(context),
                ],
              ),
            ),
          ],
        ),
      ),
      // LOKASI: Upgrade - Bottom Bar Standalone (Mini Player + Bottom Navigation)
      bottomNavigationBar: showBottomBar
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const MusicMiniPlayer(),
                MusicBottomNavBar(
                  activeIndex: 4,
                  onTap: onNavTap,
                ),
              ],
            )
          : null,
    );
  }

  // LOKASI: Upgrade - Header Atas (Logo Music & Avatar Profil Menuju Halaman Akun)
  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.fromLTRB(16, 6, 10, 6),
      child: Row(
        children: [
          // LOKASI: Upgrade - Logo Music Header
          const YouTubeMusicLogo(
            iconSize: 28,
            label: 'Music',
            fontSize: 22,
            spacing: 8,
          ),
          const Spacer(),
          // LOKASI: Upgrade - Tombol Avatar Profil Header (Buka Halaman Akun)
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => _openAccountPage(context),
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: UserProfileAvatar(size: 26),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // LOKASI: Upgrade - Latar Belakang Gradien Warna (Hijau Gelap, Ungu, Pink, Hitam)
  Widget _buildGradientBackground() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // LOKASI: Upgrade - Layer Gradien Dasar Hijau Gelap ke Hitam
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF061B14),
                Color(0xFF140D1E),
                Color(0xFF0A0A0A),
              ],
              stops: [0.0, 0.45, 1.0],
            ),
          ),
        ),
        // LOKASI: Upgrade - Layer Sorotan Radial Warna Ungu
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.35, -0.82),
              radius: 0.95,
              colors: [
                Color(0xBD9D5BF0),
                Color(0x665B249C),
                Colors.transparent,
              ],
              stops: [0.0, 0.45, 1.0],
            ),
          ),
        ),
        // LOKASI: Upgrade - Layer Sorotan Radial Warna Pink
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.95, -0.32),
              radius: 0.95,
              colors: [
                Color(0xCDE0486E),
                Color(0x669E1F48),
                Colors.transparent,
              ],
              stops: [0.0, 0.45, 1.0],
            ),
          ),
        ),
        // LOKASI: Upgrade - Layer Gradien Gelap Bagian Bawah
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color(0xB3090909),
                Color(0xFF080808),
              ],
              stops: [0.45, 0.78, 1.0],
            ),
          ),
        ),
      ],
    );
  }

  // LOKASI: Upgrade - Konten Tengah Penawaran Music Premium (Responsif)
  Widget _buildScrollableContent(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final bool isSmallScreen = width < 350;
        final bool isTablet = width >= 600;

        final double horizontalPadding = isSmallScreen ? 18 : 24;
        final double brandIconSize = isSmallScreen ? 30 : (isTablet ? 40 : 34);
        final double brandFontSize = isSmallScreen ? 22 : (isTablet ? 29 : 25);
        final double headlineSize = isSmallScreen ? 22 : (isTablet ? 30 : 27);
        final double priceSize = isSmallScreen ? 13.5 : (isTablet ? 16 : 15);

        return SingleChildScrollView(
          controller: scrollController,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 20,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: (constraints.maxHeight - 40).clamp(0.0, double.infinity),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // LOKASI: Upgrade - Logo Besar "YouTube Music"
                    YouTubeMusicLogo(
                      iconSize: brandIconSize,
                      label: 'YouTube Music',
                      fontSize: brandFontSize,
                      spacing: 10,
                    ),
                    SizedBox(height: isSmallScreen ? 20 : 28),
                    // LOKASI: Upgrade - Teks Judul Promo Music Premium
                    Text(
                      'Dapatkan Music Premium untuk mendengarkan musik bebas iklan, offline & tanpa menyalakan layar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: headlineSize,
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 18 : 26),
                    // LOKASI: Upgrade - Teks Harga Uji Coba & Langganan Bulanan
                    Text(
                      'Uji coba selama 1 bulan seharga Rp 0 \u00B7 Lalu Rp 54.990/bulan \u00B7 Batalkan kapan saja',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFE8E8E8),
                        fontSize: priceSize,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 22 : 28),
                    _buildPrimaryOfferButton(
                      context,
                      isSmallScreen: isSmallScreen,
                    ),
                    const SizedBox(height: 20),
                    _buildAlternativePlanText(context),
                    SizedBox(height: isSmallScreen ? 20 : 28),
                    // LOKASI: Upgrade - Teks Catatan Pengingat 7 Hari
                    const Text(
                      'Anda akan menerima pengingat 7 hari sebelum uji coba berakhir',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFB3B3B3),
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // LOKASI: Upgrade - Tombol Biru Penawaran ("Coba 1 bulan seharga Rp 0")
  Widget _buildPrimaryOfferButton(
    BuildContext context, {
    required bool isSmallScreen,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => showMusicFeedback(
          context,
          'Penawaran uji coba gratis 1 bulan dipilih',
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3EA6FF),
          foregroundColor: Colors.black,
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: isSmallScreen ? 13 : 15,
          ),
          shape: const StadiumBorder(),
        ),
        child: const Text(
          'Coba 1 bulan seharga Rp 0',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // LOKASI: Upgrade - Teks Tautan Alternatif Paket Keluarga atau Pelajar
  Widget _buildAlternativePlanText(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () => showMusicFeedback(
        context,
        'Melihat pilihan paket keluarga atau pelajar',
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text.rich(
          TextSpan(
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              height: 1.4,
            ),
            children: [
              TextSpan(text: 'Atau hemat uang dengan '),
              TextSpan(
                text: 'paket keluarga atau pelajar',
                style: TextStyle(
                  color: Color(0xFF3EA6FF),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
