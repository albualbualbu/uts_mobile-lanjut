import 'package:flutter/material.dart';

import '../widgets/music_common_widgets.dart';
import 'account_page.dart';

/// Halaman penawaran YouTube Music Premium (Upgrade).
/// Menampilkan tampilan statis sesuai tema gelap YouTube Music tanpa logika pembayaran.
class UpgradePage extends StatelessWidget {
  final ValueChanged<int>? onNavTap;
  final VoidCallback? onProfileTap;

  const UpgradePage({
    super.key,
    this.onNavTap,
    this.onProfileTap,
  });

  void _openAccountPage(BuildContext context) {
    if (onProfileTap != null) {
      onProfileTap!();
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => const AccountPage(),
      ),
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MusicMiniPlayer(),
          MusicBottomNavBar(
            activeIndex: 4,
            onTap: onNavTap,
          ),
        ],
      ),
    );
  }

  /// Header hitam dengan logo YouTube Music di kiri dan avatar profil di kanan.
  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const YouTubeMusicLogo(
            iconSize: 28,
            label: 'Music',
            fontSize: 22,
            spacing: 8,
          ),
          const Spacer(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _openAccountPage(context),
            child: const Padding(
              padding: EdgeInsets.all(2),
              child: UserProfileAvatar(size: 26),
            ),
          ),
        ],
      ),
    );
  }

  /// Latar belakang gradasi warna hijau gelap, ungu, pink, dan hitam.
  Widget _buildGradientBackground() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Dasar gradasi hijau sangat gelap ke hitam
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
        // Sorotan warna ungu di bagian atas tengah-kanan
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
        // Sorotan warna pink di sisi kanan atas-tengah
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
        // Gradasi gelap di bagian bawah agar teks tetap kontras dan mudah dibaca
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

  /// Konten penawaran Music Premium yang dapat digulir dan responsif.
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
                    YouTubeMusicLogo(
                      iconSize: brandIconSize,
                      label: 'YouTube Music',
                      fontSize: brandFontSize,
                      spacing: 10,
                    ),
                    SizedBox(height: isSmallScreen ? 20 : 28),
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
                    _buildPrimaryOfferButton(isSmallScreen: isSmallScreen),
                    const SizedBox(height: 20),
                    _buildAlternativePlanText(),
                    SizedBox(height: isSmallScreen ? 20 : 28),
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

  /// Tombol biru besar untuk penawaran uji coba gratis.
  Widget _buildPrimaryOfferButton({required bool isSmallScreen}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
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

  /// Teks alternatif paket keluarga atau pelajar dengan bagian tautan berwarna biru.
  Widget _buildAlternativePlanText() {
    return const Text.rich(
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
    );
  }
}
