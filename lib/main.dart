import 'package:flutter/material.dart';

import 'data/image_urls.dart';
import 'pages/account_page.dart';
import 'pages/collection_page.dart';
import 'pages/home_page.dart';
import 'pages/sample_page.dart';
import 'pages/search_page.dart';
import 'pages/upgrade_page.dart';
import 'widgets/music_common_widgets.dart';

// LOKASI: Fungsi Utama Aplikasi (Entry Point main)
void main() {
  runApp(const MyApp());
}

// LOKASI: Root Aplikasi & Tema Global MaterialApp (MyApp)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      // LOKASI: Pengaturan Tema Gelap Aplikasi
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const MainPage(),
    );
  }
}

// LOKASI: Halaman Induk Pengelola Navigasi 5 Tab, Mini Player, & Tombol Back (MainPage)
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // LOKASI: Index Tab Aktif (0=Beranda, 1=Sampel, 2=Telusuri, 3=Koleksi, 4=Upgrade)
  int _currentIndex = 0;

  // LOKASI: Riwayat Urutan Tab untuk Tombol Back Android
  final List<int> _tabHistory = [0];

  // LOKASI: ScrollController Tiap Tab (Menjaga Posisi Scroll & Scroll-to-Top)
  late final List<ScrollController> _scrollControllers =
      List<ScrollController>.generate(5, (_) => ScrollController());

  // LOKASI: Data Lagu Default & Status Play/Pause Mini Player Global
  String _currentTitle = 'Kenangan Manis';
  String _currentArtist = 'Pamungkas';
  String _currentCoverUrl = ImageUrls.miniPlayerCover;
  bool _isPlaying = false;

  @override
  void dispose() {
    for (final ScrollController controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // LOKASI: Logika Perpindahan Tab Bottom Navigation (_onNavTap)
  void _onNavTap(int index) {
    if (index < 0 || index > 4) return;
    FocusManager.instance.primaryFocus?.unfocus();

    // LOKASI: Scroll Kembali ke Atas Jika Tab yang Sama Ditekan Ulang
    if (index == _currentIndex) {
      final ScrollController controller = _scrollControllers[index];
      if (controller.hasClients && controller.offset > 0) {
        controller.animateTo(
          0,
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOut,
        );
      }
      return;
    }

    setState(() {
      if (index == 0) {
        _tabHistory
          ..clear()
          ..add(0);
      } else {
        _tabHistory.remove(index);
        _tabHistory.add(index);
      }
      _currentIndex = index;
    });
  }

  // LOKASI: Logika Tombol Back Android & Tombol Kembali SearchBar (_handleBack)
  void _handleBack() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_tabHistory.length > 1) {
      setState(() {
        _tabHistory.removeLast();
        _currentIndex = _tabHistory.last;
      });
    } else if (_currentIndex != 0) {
      setState(() {
        _tabHistory
          ..clear()
          ..add(0);
        _currentIndex = 0;
      });
    }
  }

  // LOKASI: Fungsi Membuka Halaman Akun dari Ikon Profil (_openAccountPage)
  void _openAccountPage() {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context).push(
      buildSlideUpRoute(
        AccountPage(
          onCloseTap: () => Navigator.of(context).pop(),
          onGetPremiumTap: () {
            Navigator.of(context).pop();
            _onNavTap(4);
          },
        ),
      ),
    );
  }

  // LOKASI: Fungsi Memperbarui Lagu Aktif pada Mini Player (_playTrack)
  void _playTrack(String title, String artist, String coverUrl) {
    setState(() {
      _currentTitle = title;
      _currentArtist = artist;
      _currentCoverUrl = coverUrl;
      _isPlaying = true;
    });
    showMusicFeedback(context, 'Memutar: $title');
  }

  @override
  Widget build(BuildContext context) {
    // LOKASI: Daftar Widget 5 Halaman Tab Utama
    final List<Widget> pages = [
      // LOKASI: Tab 0 - Halaman Beranda (HomePage)
      HomePage(
        onNavTap: _onNavTap,
        onProfileTap: _openAccountPage,
        scrollController: _scrollControllers[0],
        showBottomBar: false,
        onSongTap: _playTrack,
      ),
      // LOKASI: Tab 1 - Halaman Sampel (SamplePage)
      SamplePage(
        onNavTap: _onNavTap,
        showBottomBar: false,
        onSongTap: _playTrack,
      ),
      // LOKASI: Tab 2 - Halaman Telusuri (SearchPage)
      SearchPage(
        onTabSelected: _onNavTap,
        onBackTap: _handleBack,
        scrollController: _scrollControllers[2],
        showBottomBar: false,
        onSongTap: _playTrack,
      ),
      // LOKASI: Tab 3 - Halaman Koleksi (CollectionPage)
      CollectionPage(
        onTabSelected: _onNavTap,
        onProfileTap: _openAccountPage,
        scrollController: _scrollControllers[3],
        showBottomBar: false,
        onSongTap: _playTrack,
      ),
      // LOKASI: Tab 4 - Halaman Upgrade (UpgradePage)
      UpgradePage(
        onNavTap: _onNavTap,
        onProfileTap: _openAccountPage,
        scrollController: _scrollControllers[4],
        showBottomBar: false,
      ),
    ];

    final bool canExitApp = _tabHistory.length <= 1 && _currentIndex == 0;

    // LOKASI: Penangkap Tombol Back Android (PopScope)
    return PopScope(
      canPop: canExitApp,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _handleBack();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        // LOKASI: Area Konten Halaman dengan Transisi Fade & Menjaga State Tab
        body: Stack(
          children: List.generate(pages.length, (index) {
            final bool isActive = index == _currentIndex;
            return ExcludeFocus(
              excluding: !isActive,
              child: IgnorePointer(
                ignoring: !isActive,
                child: AnimatedOpacity(
                  opacity: isActive ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  // LOKASI: TickerMode di Dalam AnimatedOpacity agar Fade-Out Tetap Berjalan
                  child: TickerMode(
                    enabled: isActive,
                    child: pages[index],
                  ),
                ),
              ),
            );
          }),
        ),
        // LOKASI: Area Bawah Tetap (Mini Player Bersama & Bottom Navigation Bar)
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // LOKASI: Mini Player Global (Otomatis Tersembunyi di Tab Sampel)
            ClipRect(
              child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 180),
                sizeCurve: Curves.easeOut,
                crossFadeState: _currentIndex == 1
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: MusicMiniPlayer(
                  title: _currentTitle,
                  artist: _currentArtist,
                  coverUrl: _currentCoverUrl,
                  isPlaying: _isPlaying,
                  onPlayPauseTap: () {
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  },
                ),
                secondChild: const SizedBox(width: double.infinity, height: 0),
              ),
            ),
            // LOKASI: Bottom Navigation Bar Bersama 5 Menu
            MusicBottomNavBar(
              activeIndex: _currentIndex,
              backgroundColor: _currentIndex == 1
                  ? const Color(0xFF0A0A0A)
                  : const Color(0xFF141414),
              onTap: _onNavTap,
            ),
          ],
        ),
      ),
    );
  }
}
