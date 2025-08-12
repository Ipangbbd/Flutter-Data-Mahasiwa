// Import paket Material untuk widget UI dasar Flutter
import 'package:flutter/material.dart';
// Import halaman dashboard (daftar mahasiswa)
import 'package:flut/FormPage.dart';
// Import halaman sambutan (welcome screen)
import 'package:flut/welcome_screen.dart';

// Fungsi utama aplikasi; titik masuk eksekusi program
void main(){
  // Menjalankan aplikasi Flutter dengan widget root MyApp
  runApp(MyApp());
}

// Widget root aplikasi yang mendefinisikan tema dan halaman awal
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mengembalikan MaterialApp sebagai kerangka aplikasi
    return MaterialApp(
      // Menyembunyikan banner debug di kanan atas
      debugShowCheckedModeBanner: false,
      // Judul aplikasi (dipakai oleh OS)
      title: "Formulir Biodata",
      // Konfigurasi tema global aplikasi
      theme: ThemeData(
        // Menggunakan Material 3 untuk tampilan modern
        useMaterial3: true,
        // Warna dasar (akan menghasilkan color scheme otomatis)
        colorSchemeSeed: Colors.indigo,
        // AppBar berada di tengah secara default
        appBarTheme: const AppBarTheme(centerTitle: true),
        // Gaya bawaan untuk seluruh input text
        inputDecorationTheme: InputDecorationTheme(
          filled: true, // latar belakang isian
          fillColor: Colors.indigo.withOpacity(0.03), // warna latar halus
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // sudut membulat
            borderSide: BorderSide.none, // tanpa garis tepi
          ),
        ),
        // Gaya kartu default
        cardTheme: CardThemeData(
          elevation: 0, // tanpa bayangan
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // sudut
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // jarak
        ),
        // Gaya padding untuk ListTile
        listTileTheme: const ListTileThemeData(contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4)),
        // Gaya chip default (mis. FilterChip, Chip)
        chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ),
        // SnackBar melayang
        snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
        // Gaya garis pemisah
        dividerTheme: const DividerThemeData(thickness: 0.8, space: 0),
      ),
      // Halaman awal aplikasi adalah WelcomeScreen
      home: const WelcomeScreen(),
    );
  }
}