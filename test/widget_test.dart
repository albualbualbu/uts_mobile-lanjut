import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uts_mola/main.dart';
import 'package:uts_mola/pages/account_page.dart';
import 'package:uts_mola/pages/collection_page.dart';
import 'package:uts_mola/pages/home_page.dart';
import 'package:uts_mola/pages/sample_page.dart';
import 'package:uts_mola/pages/search_page.dart';
import 'package:uts_mola/pages/upgrade_page.dart';
import 'package:uts_mola/widgets/music_common_widgets.dart';

// LOKASI: Pengujian Widget Test Navigasi Aplikasi
void main() {
  // LOKASI: Helper Pengecekan Opacity Tab Aktif pada Transisi
  double tabRenderedOpacity(WidgetTester tester, Type pageType) {
    final Finder animatedOpacity = find
        .ancestor(
          of: find.byType(pageType),
          matching: find.byType(AnimatedOpacity),
        )
        .first;
    final FadeTransition fade = tester.widget<FadeTransition>(
      find
          .descendant(
            of: animatedOpacity,
            matching: find.byType(FadeTransition),
          )
          .first,
    );
    return fade.opacity.value;
  }

  // LOKASI: Helper Verifikasi Tab Aktif vs Tab Tersembunyi
  void expectActiveTab(WidgetTester tester, int expectedIndex) {
    final List<Type> pageTypes = [
      HomePage,
      SamplePage,
      SearchPage,
      CollectionPage,
      UpgradePage,
    ];
    for (int i = 0; i < pageTypes.length; i++) {
      expect(
        tabRenderedOpacity(tester, pageTypes[i]),
        i == expectedIndex ? 1.0 : 0.0,
        reason:
            'Tab ${pageTypes[i]} seharusnya opacity ${i == expectedIndex ? 1.0 : 0.0}',
      );
    }
  }

  // LOKASI: Helper Klik Tab pada Bottom Navigation Bar
  Future<void> tapBottomTab(WidgetTester tester, String label) async {
    await tester.tap(
      find.descendant(
        of: find.byType(MusicBottomNavBar),
        matching: find.text(label),
      ),
    );
    await tester.pumpAndSettle();
  }

  // LOKASI: Skenario Test 1 - Pindah Tab Maju & Mundur
  testWidgets('Navigasi tab maju dan mundur tidak stuck', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expectActiveTab(tester, 0);

    // LOKASI: Uji Pindah Tab Maju (0 -> 1 -> 2 -> 3 -> 4)
    await tapBottomTab(tester, 'Sampel');
    expectActiveTab(tester, 1);

    await tapBottomTab(tester, 'Telusuri');
    expectActiveTab(tester, 2);

    await tapBottomTab(tester, 'Koleksi');
    expectActiveTab(tester, 3);

    await tapBottomTab(tester, 'Upgrade');
    expectActiveTab(tester, 4);

    // LOKASI: Uji Pindah Tab Mundur (4 -> 3 -> 2 -> 1 -> 0)
    await tapBottomTab(tester, 'Koleksi');
    expectActiveTab(tester, 3);

    await tapBottomTab(tester, 'Telusuri');
    expectActiveTab(tester, 2);

    await tapBottomTab(tester, 'Sampel');
    expectActiveTab(tester, 1);

    await tapBottomTab(tester, 'Beranda');
    expectActiveTab(tester, 0);
  });

  // LOKASI: Skenario Test 2 - Koleksi -> Telusuri -> Tombol Kembali & Back Android
  testWidgets('Navigasi Koleksi ke Telusuri lalu tombol kembali & back Android', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tapBottomTab(tester, 'Koleksi');
    expectActiveTab(tester, 3);

    // LOKASI: Uji Klik Ikon Search di Header Koleksi
    await tester.tap(
      find.descendant(
        of: find.byType(CollectionPage),
        matching: find.byIcon(Icons.search),
      ),
    );
    await tester.pumpAndSettle();
    expectActiveTab(tester, 2);

    // LOKASI: Uji Klik Tombol Kembali pada SearchBar Telusuri
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expectActiveTab(tester, 3);

    // LOKASI: Uji Tombol Back Sistem Android Kembali ke Beranda
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expectActiveTab(tester, 0);
  });

  // LOKASI: Skenario Test 3 - Upgrade -> Halaman Akun -> Tutup Halaman Akun
  testWidgets('Navigasi dari Upgrade ke Akun dan kembali berfungsi', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tapBottomTab(tester, 'Upgrade');
    expectActiveTab(tester, 4);

    // LOKASI: Uji Klik Avatar Profil di Header Upgrade untuk Buka Halaman Akun
    await tester.tap(
      find.descendant(
        of: find.byType(UpgradePage),
        matching: find.byType(UserProfileAvatar),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(AccountPage), findsOneWidget);

    // LOKASI: Uji Klik Tombol X untuk Menutup Halaman Akun
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(find.byType(AccountPage), findsNothing);
    expectActiveTab(tester, 4);
  });
}
